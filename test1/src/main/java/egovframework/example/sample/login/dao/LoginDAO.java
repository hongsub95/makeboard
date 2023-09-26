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
	public void insertUser(UserVO vo) {
		
		sqlsession.insert("login.insertUser",vo);
	}
	
	@Override
	public void insertOauthUser(UserVO vo) {
		
		sqlsession.insert("login.insertKakaoUser",vo);
	}
	
	@Override
	public UserVO selectUserForemail(String email) {
		
		return sqlsession.selectOne("login.selectUserForemail", email);
	}
	
	@Override
	public String selectLoginMethod(UserVO vo) {
		return sqlsession.selectOne("login.selectLoginMethod",vo);
	}
	
	@Override
	public String selectName(UserVO vo) {
		return sqlsession.selectOne("login.selectName",vo);
	}
	
	@Override
	public String selectEmail(Long user_id) {
		return sqlsession.selectOne("login.selectEmail",user_id);
	}
	
	
}
