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
	<div class="signupform">
		<form action="" method="post" >
			<input type="hidden" name="user_id"/>
			<input type="text" name="email" placeholder="이메일"/>
			<input type="password" placeholder="패스워드" maxlength=13 name="password"/>
			<input type="text" placeholder="이름" name="name"/>
			<input type=submit>
		</form>
	</div>
</body>
</html>