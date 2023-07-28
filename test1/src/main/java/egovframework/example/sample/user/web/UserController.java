package egovframework.example.sample.user.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import egovframework.example.sample.login.service.impl.LoginServiceimpl;
import egovframework.example.sample.user.model.UserVO;
import egovframework.example.sample.user.service.impl.UserServiceimpl;

@Controller
public class UserController {
	
	@Autowired
	private UserServiceimpl userserviceimpl;
	@Autowired
	private LoginServiceimpl loginserviceimpl;
	
	@RequestMapping("/UserInfo.do")
	public String UserInfo(HttpServletRequest request,Model model) {
		HttpSession session = request.getSession(false);
		Long user_id = (Long) session.getAttribute("user_id");
		if(user_id == null) {
			return "sample/failedLogin";
		}
		else {
			
			model.addAttribute("user",userserviceimpl.findUserInfo(user_id));
			return "sample/UserInfo";
		}
		
	}
	
	@RequestMapping("/userupdate.do")
	public String updateUserInfo(UserVO vo) {
		
		userserviceimpl.modifyUserInfo(vo);
		
		
		return "redirect:/home.do";
	}
	
	
	@RequestMapping("/setpassword.do")
	@ResponseBody
	public ModelAndView setPassword (@RequestParam("user_id") Long user_id,@RequestParam("old_password") String old_password,@RequestParam("new_password") String new_password) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		UserVO vo = userserviceimpl.findUserInfo(user_id);
		boolean checkpwd = encoder.matches(old_password, vo.getPassword());
		boolean pwdLength = loginserviceimpl.lengthPwd(new_password);
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		String setpassword = "fail";
		if(checkpwd && pwdLength) {
			userserviceimpl.newPwdEncoding(vo, new_password);
			setpassword = "success";
			mav.addObject("setpassword", setpassword);
			return mav;
			}
		else {
			mav.addObject("setpassword",setpassword);
			return mav;
		}
	}
}
		
	

