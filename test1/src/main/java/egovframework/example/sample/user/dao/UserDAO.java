package egovframework.example.sample.user.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.user.model.UserVO;

@Repository
public class UserDAO implements UserMapper{
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	public UserVO selectUserinfo(Long user_id) {
		return sqlsession.selectOne("User.selectUserinfo",user_id);
	}
	
	public void updateUserinfo(UserVO vo) {
		
		sqlsession.update("User.updateUserinfo",vo);
	}
	
	public void updatesetPassword(UserVO vo) {
		sqlsession.update("User.updatesetPassword",vo);
	}
}
