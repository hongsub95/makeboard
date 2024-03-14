package egovframework.example.sample.mail.model;

public class AttchFileVO extends MailVO{
	
	private String realFileNm;
	private String attachFileNm;
	
	public String getRealFileNm() {
		return realFileNm;
	}
	public void setRealFileNm(String realFileNm) {
		this.realFileNm = realFileNm;
	}
	public String getAttachFileNm() {
		return attachFileNm;
	}
	public void setAttachFileNm(String attachFileNm) {
		this.attachFileNm = attachFileNm;
	}
}
