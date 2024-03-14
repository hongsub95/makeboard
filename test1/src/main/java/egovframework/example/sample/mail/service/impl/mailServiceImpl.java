package egovframework.example.sample.mail.service.impl;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.mail.api.SMail;
import egovframework.example.sample.mail.model.MailVO;
import egovframework.rte.fdl.property.EgovPropertyService;


@Service
public class mailServiceImpl{
	
	@Resource(name="propertiesService")
	private EgovPropertyService propertiesService;
	
	public void sendMail(MailVO mailvo,MultipartFile[] files) throws Exception{
		
		SMail smail = new SMail();
		
		String mailPath = propertiesService.getString("mailFileStorePath");
		if (files != null && files.length > 0 ) {
			String[] saveFileNameList = new String[files.length];
			String[] originFileNameList = new String[files.length];
			int i = 0;
			for (MultipartFile file : files) {
				long time = System.currentTimeMillis();
				String originFileName = file.getOriginalFilename(); // 원본 파일 명
				String fileExtension = FilenameUtils.getExtension(originFileName);
				String saveFileName = String.format("%d_%s", time, UUID.randomUUID() + "." + fileExtension);
				try { // 파일생성
					file.transferTo(new File(mailPath + File.separator + saveFileName));
					saveFileNameList[i] = saveFileName;
					originFileNameList[i] = originFileName;
					i++;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (saveFileNameList != null && saveFileNameList.length >0) {
				smail.setAttachOrgFileNameList(originFileNameList);
				smail.setAttachFileNameList(saveFileNameList);
			}
		}
		smail.setAttachFilePath(mailPath);
		smail.setTitle(mailvo.getTitle());
		smail.setContent(mailvo.getContent());
		smail.setHtml(true);
		smail.setSender("소프트시그널(주)");
		smail.setCc(mailvo.getCcAddressList());
		smail.setBcc(mailvo.getBccAddressList());
		smail.setReciever(mailvo.getToAddressList());
		smail.setMailServer("smtp-mail.outlook.com");
		smail.setServerId("hsshin@soft-signal.com");
		smail.setServerPassword("Wjstjf123!");
		smail.setServerPort(587);
		smail.send();
		/*if (smail.send()==false) {
			mailvo.setSendYn("N");
		}
		else {
			mailvo.setSendYn("Y");			
		}*/
	}
}
