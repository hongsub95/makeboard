package egovframework.example.sample.login.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import egovframework.example.sample.login.service.impl.LoginServiceimpl;
import egovframework.example.sample.user.model.UserVO;


@Controller
public class LoginController {
	
	@Autowired
	private LoginServiceimpl loginserviceimpl;
	
	@GetMapping("/SignupForm.do")
	public String SignupFormView(UserVO vo) {
		return "sample/SignupForm";
	}
	
	@PostMapping("/SignupForm.do")
	public ModelAndView SignupForm(UserVO vo) {
		
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		boolean pwdLength = loginserviceimpl.lengthPwd(vo.getPassword());
		UserVO has_email = loginserviceimpl.findByemail(vo.getEmail());
		Map<String,String> message = new HashMap<String,String>();
		
		if (pwdLength && has_email == null ) {
			
			loginserviceimpl.pwdEncoding(vo);
			mav.addObject("msg", "success");
			
			return mav;
			
		}
		else if (has_email != null) {
			
			mav.addObject("msg", "already");
			
			return mav;
		}
		
		else if(pwdLength == false) {
			mav.addObject("msg", "minPasswordlength");
			
			return mav;
		}
		
		else {
			mav.addObject("msg","fail");
			
			return mav;
		}
		
	}
	
	@GetMapping("/ChoiceSignupForm.do")
	public String ChoiceSignupForm() {
		return "sample/choiceSignup";
	}
	
	@GetMapping("/ChoiceLoginForm.do")
	public String ChoiceLoginForm() {
		return "sample/choiceLogin";
	}
	
	@GetMapping("/LoginForm.do")
	public String LoginFormView() {
		return "sample/LoginForm";
	}
	
	@PostMapping("/LoginForm.do")
	public ModelAndView LoginForm(HttpServletRequest request,String email, String password) {
		
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView jsonView = new MappingJackson2JsonView();
		mav.setView(jsonView);
		
		UserVO user = loginserviceimpl.findByemail(email);
		HttpSession session = request.getSession();
		
		if (user == null) {
			mav.addObject("msg", "noUser");
			return mav;
		}
		else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			boolean checkpwd = encoder.matches(password, user.getPassword());
			

			if (checkpwd) {
				session.setAttribute("email", user.getEmail());
				session.setAttribute("name", user.getName());
				session.setAttribute("user_id", user.getUser_id());
				session.setAttribute("is_admin", user.getIsAdmin());
				
				mav.addObject("msg", "success");
				mav.addObject("name",user.getName());
				return mav;
				
			}
			mav.addObject("msg","noPassword");
			return mav;
			
		}
			
	}

	
	@RequestMapping(value="/auth/kakao/callback.do",method=RequestMethod.GET)
	public String kakaoCallback(HttpServletRequest request ,@RequestParam(value="code") String code) {
		
		String AuthorizeCode = code;
		String AccessToken = loginserviceimpl.getAccessToken(code);
		Map<String,Object> kAccount = loginserviceimpl.getUserInfo(AccessToken);
		
		String email = (String) kAccount.get("email");
		@SuppressWarnings("unchecked")
		Map<String,String> profile = (Map<String, String>) kAccount.get("profile");
		String name = (String)profile.get("nickname");
		
		UserVO user = loginserviceimpl.findByemail(email);
		
		// user 정보가 없을 경우
		if (user==null) {
			UserVO vo = new UserVO();
			HttpSession session = request.getSession();
			vo.setEmail(email);
			vo.setName(name);
			vo.setLoginMethod("kakao");
			vo.setCreated(new Date());
			loginserviceimpl.SignupOauthUser(vo);
			session.setAttribute("email", vo.getEmail());
			session.setAttribute("name", vo.getName());
			session.setAttribute("user_id", vo.getUser_id());
			session.setAttribute("is_admin", vo.getIsAdmin());
			
			return"redirect:/home.do";
		}
			
		// user 정보가 있을 경우 (즉, 카카오회원가입 방식이 아닌 다른 방식으로 회원가입한 유저인 경우)	
		else {
			String loginMethod = loginserviceimpl.findLoginMethod(user);
			
			// 다른 로그인 방식으로 
			if (loginMethod == "email" || loginMethod.equals("email")) {
				return null;
			}
			else if (loginMethod == "kakao" || loginMethod.equals("kakao")) {
				
				HttpSession session = request.getSession();
				session.setAttribute("email", user.getEmail());
				session.setAttribute("name", user.getName());
				session.setAttribute("user_id", user.getUser_id());
				session.setAttribute("is_admin", user.getIsAdmin());
				return "redirect:/home.do";
			}
		}
		
		
		
		
		return "redirect:/home.do";
	}
	
	@GetMapping("/Logout.do")
	public String LogoutForm(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if (session != null) {
		        session.removeAttribute("email");
		        session.removeAttribute("name");
		        session.removeAttribute("user_id");
		        session.removeAttribute("is_admin");
		    }
		return "redirect:/home.do";
	}
}
