package egovframework.example.sample.user.service;

import java.util.List;

import egovframework.example.sample.admin.model.GradelogVO;
import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.user.model.UserVO;

public interface UserService {
	public UserVO findUserInfo(Long user_id);
	
	public void modifyUserInfo(UserVO vo);
	
	public void newPwdEncoding(UserVO vo,String new_password);
	
	public int findUserCnt();
	
	public List<UserVO> findAllUser(PagingVO pagingvo);
	
	public List<UserVO> findAllUserBygrade(PagingVO pagingvo);
	
	public void softdeleteUser(UserVO vo);
	
	public void softdeleteReason(UserVO vo);
	
	public void updateGrade(UserVO vo,GradelogVO logvo,Long user_id1,Long user_id2, int grade1, int grade2);
}
