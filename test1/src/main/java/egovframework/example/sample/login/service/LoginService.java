package egovframework.example.sample.login.service;

import egovframework.example.sample.user.model.UserVO;

public interface LoginService {
	
	public void pwdEncoding(UserVO vo);
	
	public boolean has_email(UserVO vo);
	
	public boolean lengthPwd(String pwd);
	
	public UserVO findByemail(String email);
	
}
