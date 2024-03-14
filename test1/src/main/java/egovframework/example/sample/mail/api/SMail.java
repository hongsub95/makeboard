package egovframework.example.sample.mail.api;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SMail {
	
	/*@Autowired
    private JavaMailSender javaMailSender;*/
	
	private final String ENCODING= "UTF-8";
	
	private String sender;
	private String title;
	private String reciever;
	private String cc;
	private String bcc;
	private String content;
	private String mailServer;
	private String serverId;
	private int serverPort;
	private String serverPassword; 
	private String filePath;
	private boolean isHtml;
	private String attachFilePath;
	private String[] attachFileNameList;
	private String[] attachOrgFileNameList;
	/*private String[] attachBigFileList;*/
	
	
	public boolean send() throws Exception{
		JavaMailSender javaMailSender = createMailServer();
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();
		try {
			MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage,true,"UTF-8");
			List<String> recieverList = SplitStringToList(reciever);
			InternetAddress[] toAddress = arrayTointernetList(recieverList);
			if (cc != null && !cc.equals("")) {
				List<String> ccList = SplitStringToList(cc);
				InternetAddress[] ccAddress = arrayTointernetList(ccList);
				if (ccList != null && ccList.size() > 0) {
					mimeMessageHelper.setCc(ccAddress);
				}
			}
			if (bcc != null && !bcc.equals("")){
				List<String> bccList = SplitStringToList(bcc);
				InternetAddress[] bccAddress = arrayTointernetList(bccList);
				if (bccList != null && bccList.size() >0) {
					mimeMessageHelper.setBcc(bccAddress);
				}
			}
			mimeMessageHelper.setFrom(MimeUtility.encodeText(sender, ENCODING,"B"));
			mimeMessageHelper.setSubject(title);
			mimeMessageHelper.setTo(toAddress);
			mimeMessageHelper.setText(content,isHtml);
			if(attachFileNameList != null && attachFileNameList.length > 0) {
				String path = attachFilePath;
				for(int i = 0; i<attachFileNameList.length; i ++) {
					String originFileName = attachOrgFileNameList[i];
					String saveFileName = attachFileNameList[i];
					FileSystemResource fileSystemResource = new FileSystemResource(new File(path,saveFileName));
					// encodeText를 사용할 경우 한글깨짐 발생
					/*mimeMessageHelper.addAttachment(MimeUtility.encodeText(filevo.getOriginalFileName(), "UTF-8","B"),fileSystemResource);*/
					mimeMessageHelper.addAttachment(new String(originFileName.getBytes("UTF-8")),fileSystemResource);
					
				}
			}
			javaMailSender.send(mimeMessage);
			return true;
			
		}
		catch (Exception e) {
            e.printStackTrace();
            return false;
		}
	}
	
	private JavaMailSender createMailServer() throws Exception{
		JavaMailSenderImpl javaMailSender = new JavaMailSenderImpl();
        javaMailSender.setHost(mailServer);
        javaMailSender.setUsername(serverId);
        javaMailSender.setPassword(serverPassword);
        

        javaMailSender.setPort(serverPort);

        javaMailSender.setJavaMailProperties(getMailProperties());

        return javaMailSender;
	}
	
	private Properties getMailProperties() {
        Properties properties = new Properties();
        properties.setProperty("mail.transport.protocol", "smtp");
        properties.setProperty("mail.smtp.auth", "true");
        properties.setProperty("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.debug", "true");
        return properties;
    }
	
	private List<String> SplitStringToList(String reciever) throws Exception{
		String[] splitList = reciever.split(";");
		List<String> recieverList = Arrays.asList(splitList);
		return recieverList;
	}

	
	private InternetAddress[] arrayTointernetList(List<String> addressList) throws Exception{
		InternetAddress[] address = new InternetAddress[addressList.size()];
		for (int i = 0; i < addressList.size(); i++) {
	        address[i] = new InternetAddress(addressList.get(i));
	    }
		return address;
	}
	
}
