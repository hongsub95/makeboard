package egovframework.example.sample.login.service.impl;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import egovframework.example.sample.login.dao.LoginDAO;
import egovframework.example.sample.login.service.LoginService;
import egovframework.example.sample.user.model.UserVO;


@Service
public class LoginServiceimpl implements LoginService{
	
	@Autowired
	private LoginDAO logindao;
	
	@Override
	public void pwdEncoding(UserVO vo) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(vo.getPassword());
		vo.setPassword(securePw);
		vo.setCreated(new Date());
		vo.setLoginMethod("email");
		
		logindao.insertUser(vo);
		
	}
	@Override
	public void SignupOauthUser(UserVO vo) {
		logindao.insertOauthUser(vo);
	}
	
	@Override
	public boolean lengthPwd(String pwd) {
		
		
		if (8 <= pwd.length()) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@Override
	public UserVO findByemail(String email) {
		return logindao.selectUserForemail(email);
		}
	
	@Override
	public String findLoginMethod(UserVO vo) {
		return logindao.selectLoginMethod(vo);
	}
	
	
	@Override
	public String getAccessToken(String code) {
	
		String RestAPIKey = "&client_id=b5a3afb094585ae6bd3ad90921e1b7c0";
		String RedirectURI = "&redirect_uri=http://localhost:8080/auth/kakao/callback.do";
		String TokenRequest = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code"+RestAPIKey+RedirectURI+"&code="+code;
		
		
		// header 객체에 content-type = application/x-www-form-urlencoded을 담아서 보냄
		HttpHeaders headers = new HttpHeaders();
		headers.add("content-type", "application/x-www-form-urlencoded");
		
		// 바디를 만들 객체 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		
		// 헤더와 바디를 합칠 수 있는 하나의 오브젝트로 만들기
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params);
		
		// http 통신할수 있는 RestTemplate 모듈 이용
		RestTemplate restTemplate = new RestTemplate();
		
		// exchange(통신할 url,통신 방법,통신보낼 entity,return 받을 타입)
		ResponseEntity<Map> response = restTemplate.exchange(TokenRequest, HttpMethod.POST,entity,Map.class);
	
		Map<String,String> ResponseBody = response.getBody();
		
		// ResponseBody에 error 가 있으면 에러메세지 보내기
		
		if(ResponseBody.containsKey("error")) {
			return null;
		}
		String AccessToken = ResponseBody.get("access_token");
		
		return AccessToken;
		
		
	}
	
	@Override
	public Map<String,Object> getUserInfo(String AccessToken){
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Authorization","Bearer "+AccessToken);
		HttpEntity<Object> request = new HttpEntity<Object>(headers);
		ResponseEntity<Map> response = restTemplate.exchange(
				"https://kapi.kakao.com/v2/user/me",
				HttpMethod.GET,
				request,
				Map.class);
		Map<String,Object> ResponseBody = response.getBody();
		@SuppressWarnings("unchecked")
		Map<String,Object> kAccount = (Map<String,Object>)ResponseBody.get("kakao_account");
		
		
		return kAccount;
		
	}
}
