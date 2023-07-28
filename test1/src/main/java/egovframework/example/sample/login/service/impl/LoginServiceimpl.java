package egovframework.example.sample.login.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.example.sample.login.dao.LoginDAO;
import egovframework.example.sample.login.service.LoginService;
import egovframework.example.sample.user.model.UserVO;


@Service
public class LoginServiceimpl implements LoginService{
	
	@Autowired
	private LoginDAO logindao;
	
	
	
	@Override
	public void pwdEncoding(UserVO vo) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(vo.getPassword());
		vo.setPassword(securePw);
		vo.setCreated(new Date());
		logindao.insertUser(vo);
		
	}
	@Override
	public boolean has_email(UserVO vo) {
		String has_email = logindao.selectHasEmail(vo);
		if (has_email == null) {
			
			return true;
		}
		else {
			return false;
		}
	}
	@Override
	public boolean lengthPwd(String pwd) {
		
		
		if (8 <= pwd.length()) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@Override
	public UserVO findByemail(String email) {
		return logindao.selectUserForemail(email);
		}
}
