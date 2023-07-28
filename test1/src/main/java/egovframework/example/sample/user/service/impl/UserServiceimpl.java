package egovframework.example.sample.user.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.example.sample.user.dao.UserDAO;
import egovframework.example.sample.user.model.UserVO;
import egovframework.example.sample.user.service.UserService;

@Service
public class UserServiceimpl implements UserService{
	
	@Autowired
	private UserDAO userdao;
	
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
}
