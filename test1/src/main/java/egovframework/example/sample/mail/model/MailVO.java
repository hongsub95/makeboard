package egovframework.example.sample.mail.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MailVO {
	
	private String address;
	private String toAddressList;
	private String ccAddressList;
	private String bccAddressList;
	private String name;
	private String content;
	private String title;
	private String sendYn;
	private boolean isUseHtmlYn;
	private List<AttchFileVO> attchFileList = new ArrayList<>();
	
	
}
