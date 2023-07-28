package egovframework.example.sample.user.service;

import egovframework.example.sample.user.model.UserVO;

public interface UserService {
	public UserVO findUserInfo(Long user_id);
	
	public void modifyUserInfo(UserVO vo);
	
	public void newPwdEncoding(UserVO vo,String new_password);
}
