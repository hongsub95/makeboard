package egovframework.example.sample.login.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.user.model.UserVO;

@Repository
public class LoginDAO implements LoginMapper{
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Override
	public String selectHasEmail(UserVO vo) {
		
		return sqlsession.selectOne("login.has_email",vo);
	}
	
	@Override
	public void insertUser(UserVO vo) {
		
		sqlsession.insert("login.inser_user",vo);
	}
	
	@Override
	public UserVO selectUserForemail(String email) {
		
		return sqlsession.selectOne("login.selectUserForemail", email);
	}
	
	
	
	
}
