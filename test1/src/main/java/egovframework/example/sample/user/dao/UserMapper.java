package egovframework.example.sample.user.dao;

import java.util.List;

import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.user.model.UserVO;

public interface UserMapper {
	public UserVO selectUserinfo(Long user_id);
	
	public void updateUserinfo(UserVO vo);
	
	public void updatesetPassword(UserVO vo);
	
	public int selectAlluserCnt();
	
	public List<UserVO> selectAllUser(PagingVO pagingvo);
	
	public List<UserVO> selectAllUserByGrade(PagingVO pagingvo);
	
	public void updateSoftdeleteuser(UserVO vo);
	
	public void updateSoftdeleteReason(UserVO vo);
	
	public void updateUserGrade(UserVO vo);
}
