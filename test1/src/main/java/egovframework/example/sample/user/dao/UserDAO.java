package egovframework.example.sample.user.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.user.model.UserVO;

@Repository
public class UserDAO implements UserMapper{
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public UserVO selectUserinfo(Long user_id) {
		return sqlsession.selectOne("User.selectUserinfo",user_id);
	}
	
	@Override
	public void updateUserinfo(UserVO vo) {
		
		sqlsession.update("User.updateUserinfo",vo);
	}
	
	@Override
	public void updatesetPassword(UserVO vo) {
		sqlsession.update("User.updatesetPassword",vo);
	}
	
	@Override
	public int selectAlluserCnt() {
		return sqlsession.selectOne("User.AllUserCount");
	}
	
	@Override
	public List<UserVO> selectAllUser(PagingVO pagingvo){
		
		return sqlsession.selectList("User.AlluserByCreated",pagingvo);
	}
	
	@Override
	public List<UserVO> selectAllUserByGrade(PagingVO pagingvo){
		return sqlsession.selectList("User.AlluserByGrade",pagingvo);
	}
	
	@Override
	public void updateSoftdeleteuser(UserVO vo) {
		sqlsession.update("User.SoftdeleteUser",vo);
	}
	
	@Override
	public void updateSoftdeleteReason(UserVO vo) {
		sqlsession.update("User.SoftdeleteReason",vo);
	}
	
	@Override
	public void updateUserGrade(UserVO vo) {
		sqlsession.update("User.updateUserGrade",vo);
	}
}
