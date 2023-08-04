package egovframework.example.sample.login.service;

import java.util.Map;

import egovframework.example.sample.user.model.UserVO;

public interface LoginService {
	
	public void pwdEncoding(UserVO vo);
	
	public void SignupOauthUser(UserVO vo);
	
	public String findLoginMethod(UserVO vo);
	
	public boolean lengthPwd(String pwd);
	
	public UserVO findByemail(String email);
	
	public String getAccessToken(String code);
	
	public Map<String,Object> getUserInfo(String AccessToken);

	
}
