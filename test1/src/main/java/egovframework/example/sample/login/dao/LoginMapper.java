package egovframework.example.sample.login.dao;

import egovframework.example.sample.user.model.UserVO;

public interface LoginMapper {
	

	
	public void insertUser(UserVO vo);
	
	public void insertOauthUser(UserVO vo);
	
	public UserVO selectUserForemail(String email);
	
	public String selectLoginMethod(UserVO vo);
	
	public String selectName(UserVO vo);
	
	public String selectEmail(Long user_id);
	
}
