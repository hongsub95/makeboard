package egovframework.example.sample.user.dao;

import egovframework.example.sample.user.model.UserVO;

public interface UserMapper {
	public UserVO selectUserinfo(Long user_id);
	
	public void updateUserinfo(UserVO vo);
	
	public void updatesetPassword(UserVO vo);
}
