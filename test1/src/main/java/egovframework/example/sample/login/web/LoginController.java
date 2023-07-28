package egovframework.example.sample.login.web;

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
	public String SignupForm(UserVO vo) {
		boolean pwdLength = loginserviceimpl.lengthPwd(vo.getPassword());
		boolean has_email = loginserviceimpl.has_email(vo);
		
		if (pwdLength && has_email ) {
			loginserviceimpl.pwdEncoding(vo);
			return "redirect:/home.do";
			
		}
		else {
			return "sample/failedLogin";
		}
		
	}
	
	@GetMapping("/ChoiceSignupForm.do")
	public String ChoiceSignupForm() {
		return "sample/choiceSignup";
	}
	
	@GetMapping("/LoginForm.do")
	public String LoginFormView() {
		return "sample/LoginForm";
	}
	
	@PostMapping("/LoginForm.do")
	public String LoginForm(HttpServletRequest request,String email, String password) {

		UserVO user = loginserviceimpl.findByemail(email);
		HttpSession session = request.getSession();
		
		if (user == null) {
			return "sample/failedLogin";
		}
		else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			boolean checkpwd = encoder.matches(password, user.getPassword());
			

			if (checkpwd) {
				session.setAttribute("email", user.getEmail());
				session.setAttribute("name", user.getName());
				session.setAttribute("user_id", user.getUser_id());
				session.setAttribute("is_admin", user.getIs_admin());
				
				return"redirect:/home.do";
			}
			
			return "sample/failedLogin";
		}
			
	}
	
	@GetMapping("/auth/kakao.do")
	public String kakaoLogin(@RequestParam(value="code") String code) {
		String a = code;
		String REST_API_KEY = "&client_id=b5a3afb094585ae6bd3ad90921e1b7c0";
		String REDIRECT_URI = "&redirect_uri=http://localhost:8080/auth/kakao/callback";
		String callback_url = "https://kauth.kakao.com/oauth/authorize?response_type=code";
		
		
		return "redirect:"+callback_url+REDIRECT_URI+REST_API_KEY;
	}
	
	@RequestMapping(value="/auth/kakao/callback.do",method=RequestMethod.GET)
	public String kakaoCallback(@RequestParam(value="code") String code) {
		String AUTHORIZE_CODE = code;
		/*String REST_API_KEY = "e95cabe4ba5b71792e1b75c513ddc4a8";
		String REDIRECT_URI = "http://localhost:8080/auth/kakao/callback";
		String token_request = "https://kauth.kakao.com/oauth/token?grant_type=authorization_";*/
		
		return null;
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
