<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/egovframework/board.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
<script type="text/javascript" src="<c:url value='/js/com/jquery-3.7.0.min.js'/>"></script>

<title>Insert title here</title>
	<script>


	$(document).ready(function() {
		
		
		$(".logout").click(function(event){
			var result = confirm("로그아웃 하시겠습니까?");
			console.log(result);
			if (result){
				alert("로그아웃되었습니다.");
				location.href="/Logout.do";
			}
			else{
				event.preventDefault();
				location.reload();
			}
		})
	});
	
	;

		
	
	</script>
	<style>
	
		
	
	</style>
</head>
<body>

	<header>
		<div class="header-nav menu_effect">
		<a style="text-decoration:none; color:black; font-size:large; " href="home.do" id="home">Home</a>
		
		<c:choose>
			<c:when test="${empty sessionScope.user_id }">
				<a style="text-decoration:none; color:black; font-size:large;" href ="/ChoiceSignupForm.do" class="signup">회원가입</a>
				<a style="text-decoration:none; color:black; font-size:large;" href="ChoiceLoginForm.do" class="login">로그인</a>
			</c:when>
			<c:otherwise>
				<a style="text-decoration:none; color:black; font-size:large;" href="Logout.do" class="logout">로그아웃</a>
				<a style="text-decoration:none; color:black; font-size:large;" href="UserInfo.do" class="Userinfo">회원정보</a>
				<a style="text-decoration:none; color:black; font-size:large;" href="BoardForm.do" class="boardpost">게시판글쓰기</a>
			</c:otherwise>
		</c:choose>
		<a style="text-decoration:none; color:black; font-size:large;" href="BoardList.do?page=1&order=created" class="boardlist">게시판 목록</a>
	</div>
	</header>
	
	<div>
	
		
	
	</div>
	

</body>
</html>