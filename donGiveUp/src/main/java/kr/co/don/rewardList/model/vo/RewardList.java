package kr.co.don.rewardList.model.vo;

import lombok.Data;

@Data
public class RewardList {
	
	private int fundingNo;
	private int rewardListNo;
	private String rewardName;
	private int rewardPrice;
	private int rewardAmount;
	private String rewardSendDate;
	private String rewardImgFilename;
	private String rewardImgFilepath;
	
}
