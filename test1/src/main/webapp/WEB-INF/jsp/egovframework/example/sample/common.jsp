<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/egovframework/board.css" rel="stylesheet"/>
<script type="text/javascript" src="<c:url value='/js/com/jquery-3.7.0.min.js'/>"></script>
<title>Insert title here</title>
	<script>


	$(document).ready(function() {
		nav_btn();
	});
	
	nav_btn = function(){
		var user_id =  "<%=session.getAttribute("user_id") %>";

		
		if(user_id == "null"){
			$(".logout").attr("style","display:none");
			
			$(".Userinfo").attr("style","display:none");
			
			$(".boardpost").attr("style","display:none");
			
		}
		else{
			$(".login").attr("style","display:none");
			
			$(".signup").attr("style","display:none");
			
			$(".logout").removeAttr("style");
			
			$(".Userinfo").removeAttr("style");
			
			$(".boardpost").removeAttr("style");
			
			
		}
		
	};

		
	
	</script>
</head>
<body>

	<header>
		<div class="header-nav">
			<a href="home.do">홈</a>
			<a href ="ChoiceSignupForm.do" class="signup">회원가입</a>
			<a href="LoginForm.do" class="login">로그인</a>
			<a href="Logout.do" class="logout">로그아웃</a>
			<a href="UserInfo.do" class="Userinfo">회원정보</a>
			<a href="BoardForm.do" class="boardpost">게시판글쓰기</a>
			<a href="BoardList.do?page=1" class="boardlist">게시판 목록</a>
		</div>
	</header>
	

</body>
</html>