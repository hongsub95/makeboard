package egovframework.example.sample.login.dao;

import egovframework.example.sample.user.model.UserVO;

public interface LoginMapper {
	
	public String selectHasEmail(UserVO vo);
	
	public void insertUser(UserVO vo);
	
	public UserVO selectUserForemail(String email);
	
}
