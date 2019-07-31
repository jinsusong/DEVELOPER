package poly.dto;

public class FileDTO {
	private String fileNo;
	private String orgName;
	private String chgName;
	private String filePath;
	private String extension;
	private String userName;
	private String regDt;
	
	
	private String commuNo;
	private String userNo;

	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getFileNo() {
		return fileNo;
	}
	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getChgName() {
		return chgName;
	}
	public void setChgName(String chgName) {
		this.chgName = chgName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getCommuNo() {
		return commuNo;
	}
	public void setCommuNo(String commuNo) {
		this.commuNo = commuNo;
	}
	public String getUserNo() {
		return userNo;
	}
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
}
