<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Don Give Up</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<style>
	body{
		font-family: 'Noto Sans KR', sans-serif;
	}
	.content{
		height: 1400px;
		width: 100%;
		margin: 0 auto;
		background-image: url("/imgs/charities3.jpg");
		background-repeat: no-repeat;
		background-size: cover;
		background-position: 50%;
		opacity: 0.8;
		
	}
	
	.joinArea{
		width: 800px;
		height: 100%;
		background-color: white;
		border-radius: 15px;
		box-sizing: border-box;
		padding-bottom: 50px;
	}
	
	.joinDiv>div{
		margin: 0 auto;
	}
	
	.joinText{
		padding-top : 100px;
		text-align: center;
	}
	
	.joinNextBtn{
		width: 220px; 
		height: 50px;
		background-color: #cbe86b;
		border: none;
		border-radius: 10px;
		color : black;
		font-size: 16px;
	}
	
	.joinNextBtn:hover {
		opacity: 0.8;
	}
	
	.joinStep{
		width : 615px;
		margin: 0 auto;
	}
	
	.joinStepBox{
		width: 200px;
		height: 100px;
		line-height: 100px;
		display: inline-block;
		text-align: center;
		background-color: white;
		padding: 0;
		margin-top: 20px;
		margin-bottom: -50px;
		border-radius: 15px;
		font-size: 18px;
		font-weight: bold;
		
	}
	
	.joinStepBox:nth-child(2){
		background-color: #cbe86b;
	}
	
	.personTable>tbody>tr>td>input{
		width: 240px;
	}
	
	.personTable{
		margin: 0 auto;
	}
	
	.personTable>tbody>tr>td{
		padding-bottom: 15px;
	}
	
	#joinPersonBtn{
		margin-left : 85px;
		width: 300px;
		height: 300px;
		margin-right: 20px;
		margin-bottom: 20px;
	}
	
	#joinPersonBtn:hover{
		cursor: pointer;
	}
	
	#joinCompanyBtn:hover{
		cursor: pointer;
	}
	
	#joinCompanyBtn{
		width: 300px;
		height: 300px;
	}
	
	.joinTableWrap{
		padding-top:30px;
		margin: 0 auto;
		border: 1px solid gray;
		border-radius: 5px;
		width: 650px;
		
	}
	
	.personTable>tbody>tr>td>span{
		display: none;
		color : red;
		font-weight: bold;
	}
	
</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.3.1.js"></script>
<script>
//이메일 입력방식 선택
$(function () {
	var count = 0;
	var checkCount = 0;
	$('#selectEmail').change(function(){
		$("#selectEmail option:selected").each(function () {
			if($(this).val()== '1'){ //직접입력일 경우 
				$("#str_email02").val(''); //값 초기화
				$("#str_email02").attr("disabled",false); //활성화 
			}else{ //직접입력이 아닐경우 
				$("#str_email02").val($(this).text()); //선택값 입력
				$("#str_email02").attr("disabled",true); //비활성화 
			} 
		}); 
	});
	
	$("#memberId").focusout(function() {
		var regExp = /^[a-zA-Z0-9]{6,16}$/;
		var id = $("#memberId").val();
		if(id!=""){
			if(!regExp.test(id)){
				$("#errorId").css("display","inline-block");
				checkCount = 0;
			}else{
				$("#errorId").css("display","none");
				checkCount = 1;
			}
		}else{
			$("#errorId").css("display","none");
		}
		
	});
	
	$("#memberIdCheck").click(function () {
		if(checkCount==1){
			var memberId = $("#memberId").val();
			$.ajax({
	            url:"/member/checkId.don",
	            type:"get",
	            data:{memberId:memberId},
	            success:function(data){
	                if(data==1){
	                	$("#errorCheckId").css("display","inline-block");
	                	$("#successCheckId").css("display","none");
	                  	$("#memberId").focus();
	                	
	                	
	                }else{
	                	$("#successCheckId").css("display","inline-block");
	                	$("#errorCheckId").css("display","none");
	                	count += 1;
	                }
	            }
	        });
		}else{
			$("#errorCheckId").css("display","none");
			$("#successCheckId").css("display","none");
		}
		
	});
	
	$("#memberPw").focusout(function() {
		var regExp =/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		var pw = $("#memberPw").val();
		if(pw!=""){
			if(!regExp.test(pw)){
				$("#errorPw").css("display","inline-block");
			}else{
				$("#errorPw").css("display","none");
				count += 1;
			}
			
			var pwVal = $("#memberPw").val();
			var pwReVal = $("#memberPwRe").val();
			if(pwReVal!=""){
				if(pwVal != pwReVal){
					$("#errorPwRe").css("display","inline-block");
				}else{
					$("#errorPwRe").css("display","none");
				}
			}
		}else{
			$("#errorPw").css("display","none");
		}
		
		
	});
	
	$("#memberPwRe").focusout(function () {
		var pw = $("#memberPw").val();
		var pwRe = $("#memberPwRe").val();
		if(pwRe!="" && pw!=""){
			if(pw != pwRe){
				$("#errorPwRe").css("display","inline-block");
			}else{
				$("#errorPwRe").css("display","none");
				count += 1;
			}
		}else{
			$("#errorPwRe").css("display","none");
		}
		
	});
	
	$("#memberName").focusout(function() {
		var regExp = /^[가-힣]{2,4}$/;
		var name = $("#memberName").val();
		if(name!=""){
			if(!regExp.test(name)){
				$("#errorName").css("display","inline-block");
			}else{
				$("#errorName").css("display","none");
				count += 1;
			}
		}else{
			$("#errorName").css("display","none");
		}
	});
	
	$("#memberPhone").focusout(function() {
		var regExp = /^[0-9]{10,11}$/;
		var phone = $("#memberPhone").val();
		if(phone!=""){
			if(!regExp.test(phone)){
				$("#errorPhone").css("display","inline-block");
			}else{
				$("#errorPhone").css("display","none");
				count += 1;
			}
		}else{
			$("#errorPhone").css("display","none");
		}
	});
	
	$("#addrSearchBtn").click(function () {
		new daum.Postcode({
            oncomplete:function(data){
                $("#memberAddr1").val(data.roadAddress);
            }
        }).open();
	});
    
	$("form").submit(function () {
		var str01 = $("#str_email01").val();
		var str02 = $("#str_email02").val();
		$("#memberEmail").val(str01+"@"+str02);
		var addr1 = $("#memberAddr1").val();
		var addr2 = $("#memberAddr2").val();
		$("#memberAddr").val(addr1+" "+addr2);
		console.log($("#memberEmail").val());
		console.log($("#memberAddr").val());
		confirm("제출하시겠습니까?");
		if(confirm == true){
			return true;
		}else{
			return false;
		}
		
	});
    
});

</script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/main/header.jsp"/>
	<div class="content">
	<div class="joinDiv">
		<div class="joinText">
			<span style="font-size: 50px; color: white; font-weight: bold;">회원가입</span>
		</div>
		<div class="joinStep">
			<p class="joinStepBox">Step 1 . 이용약관</p>
			<p class="joinStepBox">Step 2 . 정보입력</p>
			<p class="joinStepBox">Step 3 . 회원가입 완료</p>
		</div>
		<br><br>
		<div class="joinArea">
		<br><br>
        <button type="button" id="joinPersonBtn">개인</button>
        <button type="button" id="joinCompanyBtn">기관</button>
			<form action="/member/insertMember.don" method="post" id="joinForm">
            	
            	<div class="joinTableWrap">
            		<table class="personTable">
            			<tr>
            				<td style="width: 100px;">*아이디</td>
            				<td style="width: 250px;"><input type="text" placeholder="영어 + 숫자 조합 (6~16 문자)" name="memberId" id="memberId" required></td>
            				<td style="width: 100px;"><button type="button" style="width: 100px;" id="memberIdCheck">중복확인</button></td>
            				<td style="width: 150px;"><span id="errorId">잘못된 입력입니다.</span><span id="errorCheckId">아이디가 중복됩니다.</span><span id="successCheckId" style="color:blue;">사용가능합니다.</span></td>
            				
            			</tr>
            			<tr>
            				<td style="width: 100px;">*비밀번호</td>
            				<td><input type="password" placeholder="영어 + 숫자 + 특수문자 조합 (8~20 문자)" name="memberPw" id="memberPw" required></td>
            				<td style="width: 100px;"></td>
            				<td colspan="2"><span id="errorPw">잘못된 입력입니다.</span></td>
            			</tr>
            			<tr>
            				<td style="width: 100px;">*비밀번호 확인</td>
            				<td><input type="password" placeholder="내용을 입력하세요." id="memberPwRe" required></td>
            				<td style="width: 100px;"></td>
            				<td colspan="2"><span id="errorPwRe">비밀번호가 다릅니다.</span></td>
            			</tr>
            			<tr>
            				<td>*이름</td>
            				<td><input type="text" placeholder="한글만 입력해주세요.(2~6 글자)" name="memberName" id="memberName" required></td>
            				<td style="width: 100px;"></td>
            				<td><span id="errorName">잘못된 입력입니다.</span></td>
            			</tr>
            			<tr>
            				<td>*휴대폰번호</td>
            				<td><input type="text" placeholder="- 빼고 번호만 입력(10~11자리의 숫자)" name="memberPhone" id="memberPhone" required></td>
            				<td style="width: 100px;"></td>
            				<td><span id="errorPhone">잘못된 입력입니다.</span></td>
            			</tr>
            			<tr>
            				<td>*이메일</td>
            				<td colspan="3">
            				<input type="text" name="str_email01" id="str_email01" style="width:150px" required> @ <input type="text" name="str_email02" id="str_email02" style="width:150px;" disabled value="naver.com"> 
            				<select style="width:100px;margin-right:10px" name="selectEmail" id="selectEmail">
            					<option value="1">직접입력</option> 
        	    				<option value="naver.com" selected>naver.com</option> 
           	 					<option value="hanmail.net">hanmail.net</option> 
      	      					<option value="hotmail.com">hotmail.com</option> 
      	      					<option value="nate.com">nate.com</option> 
            					<option value="yahoo.co.kr">yahoo.co.kr</option> 
            					<option value="empas.com">empas.com</option> 
            					<option value="dreamwiz.com">dreamwiz.com</option> 
            					<option value="freechal.com">freechal.com</option> 
            					<option value="lycos.co.kr">lycos.co.kr</option> 
            					<option value="korea.com">korea.com</option> 
            					<option value="gmail.com">gmail.com</option> 
            					<option value="hanmir.com">hanmir.com</option> 
            					<option value="paran.com">paran.com</option> 
            				</select>
            				<input type="hidden" name="memberEmail" id="memberEmail">
            			</tr>
            			<tr>
            				<td>*주소</td>
            				<td><input type="text" id="memberAddr1" readonly></td>
            				<td><button type="button" style="width: 100px;" id="addrSearchBtn">주소검색</button></td>
            			</tr>
            			<tr>
            				<td>*상세주소</td>
            				<td><input type="text" name="memberAddr2" id="memberAddr2" required><input type="hidden" name="memberAddr" id="memberAddr"></td>
            			</tr>
            			<tr>
            				<td>추천인 입력</td>
            				<td><input type="text" placeholder="추천인 아이디를 입력하세요.(선택사항)" name="memberReferee"></td>
            			</tr>
            		</table>
            		<div style="text-align: center;">
            		<br><br>
            			<button type="reset" style=" background-color: #dddfe6;" class="joinNextBtn">취소</button>
            			<button type="submit" class="joinNextBtn">등록</button>
            		<br><br>
            		</div>
            	</div>
            </form>
			
		</div>
	</div>
	</div>
	<jsp:include page="/WEB-INF/views/main/footer.jsp"></jsp:include>
</body>

</html>