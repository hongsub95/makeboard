package egovframework.example.sample.user.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.example.sample.admin.dao.AdminDAO;
import egovframework.example.sample.admin.model.GradelogVO;
import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.user.dao.UserDAO;
import egovframework.example.sample.user.model.UserVO;
import egovframework.example.sample.user.service.UserService;

@Service
public class UserServiceimpl implements UserService{
	
	@Autowired
	private UserDAO userdao;
	
	@Autowired
	private AdminDAO admindao;
	
	@Override
	public UserVO findUserInfo(Long user_id) {
		return userdao.selectUserinfo(user_id);
	}
	
	@Override
	public void modifyUserInfo(UserVO vo) {
		vo.setUpdated(new Date());
		userdao.updateUserinfo(vo);
	}
	
	@Override
	public void newPwdEncoding(UserVO vo,String new_password) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String new_securePw = encoder.encode(new_password);
		vo.setPassword(new_securePw);
		vo.setUpdated(new Date());
		userdao.updatesetPassword(vo);
	}
	
	@Override
	public int findUserCnt() {
		return userdao.selectAlluserCnt();
	}
	
	@Override
	public List<UserVO> findAllUser(PagingVO pagingvo){
		return userdao.selectAllUser(pagingvo);
	}
	
	@Override
	public List<UserVO> findAllUserBygrade(PagingVO pagingvo){
		return userdao.selectAllUserByGrade(pagingvo);
	}
	
	@Override
	public void softdeleteUser(UserVO vo) {
		vo.setIsDeleted(true);
		vo.setDeleted(new Date());
		userdao.updateSoftdeleteuser(vo);
	}
	
	@Override
	public void softdeleteReason(UserVO vo) {
		
		userdao.updateSoftdeleteReason(vo);
	}
	
	@Override
	public void updateGrade(UserVO vo,GradelogVO logvo,Long user_id1,Long user_id2, int grade1, int grade2) {
		vo.setUser_id(user_id2);
		vo.setGrade(grade2);
		logvo.setQualify_userId(user_id1);
		logvo.setQualified_userId(user_id2);
		logvo.setQualify_grade(grade1);
		logvo.setQualified_grade(grade2);
		logvo.setCreated(new Date());
		if (grade2 >= 1) {
			vo.setIsAdmin(true);
		}
		else {
			vo.setIsAdmin(false);
		}
		userdao.updateUserGrade(vo);
		admindao.insertGradeLog(logvo);
	}
}
