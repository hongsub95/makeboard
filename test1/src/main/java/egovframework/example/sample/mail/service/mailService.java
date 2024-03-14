package egovframework.example.sample.mail.service;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.mail.model.MailVO;

public interface mailService {
	public void sendMail(MailVO mailvo,MultipartFile file) throws Exception;
}
