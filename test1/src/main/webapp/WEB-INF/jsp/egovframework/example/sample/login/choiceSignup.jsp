<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class ="signupbtn" style="margin:100px 35% 100px 35%;" >
		<div class="common_signupbtn" style="display:flex; justify-content:center; margin-top:30px; ">
			<a style="display:flex; justify-content:center; align-items:center; text-align: center;width:400px; height:5vh;border:2px solid; border-color:black; border-radius:1.2rem;font-weight:bold; font-size:x-large;text-decoration:none;" href="SignupForm.do">일반 회원가입</a>
		</div>
		<div class="kakao_signupbtn" style="display:flex; justify-content:center; margin-top:50px; margin-bottom:30px; padding-rigth:50px;">
			<a style="display:flex; justify-content:center; align-items:center;text-align:center;width:400px;height:5vh;border:2px solid;border-radius:1.2rem; border-color:#964b00; background-color:#F7E600; color:#964b00; font-weight:bold;font-size:x-large; text-decoration:none;" href="https://kauth.kakao.com/oauth/authorize?response_type=code&redirect_uri=http://localhost:8080/auth/kakao/callback.do&client_id=b5a3afb094585ae6bd3ad90921e1b7c0">카카오톡
				<i class="fas fa-comment mr-2 fa-lg"></i>
			</a>
		</div>
	</div>
</body>
</html>