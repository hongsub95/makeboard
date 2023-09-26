<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.4.2/css/all.css">
<link href="css/egovframework/board.css" rel="stylesheet"/>
<script type="text/javascript" src="<c:url value='/js/com/jquery-3.7.0.min.js' />"></script>
<%-- <script type="text/javascript" src="<c:url value='/smarteditor/js/service/HuskyEZCreator.js'/>" charset='utf-8'></script>
 --%>
<%-- <script type="text/javascript" src="<c:url value='/ckeditor/ckeditor.js'/>"></script> --%>

<!--  ckeditor5 editor -->
<%-- <script type="text/javascript" src="<c:url value='/ckeditor2/ckeditor.js'/>"></script>
<script type="text/javascript" src="<c:url value='/ckeditor2/ko.js'/>"></script>  --%>

<!-- tinymce  -->
<%-- <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
<script src="https://cdn.jsdelivr.net/npm/@tinymce/tinymce-jquery@2/dist/tinymce-jquery.min.js"></script>
<script src="<c:url value='tiny/langs/ko_KR.js'/>"></script> --%>
 <!-- summernote  -->
<link href="summernote/summernote-lite.css" rel="stylesheet"/>
<script type="text/javascript" src="<c:url value='summernote/summernote-lite.js'/>"></script>
<script type="text/javascript" src="<c:url value='summernote/lang/summernote-ko-KR.js'/>"></script> 
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script> -->


 

<title>Board For Everyone</title>


	<script>
	$(document).ready(function() {
		
		
		$(".logout").click(function(event){
			var result = confirm("로그아웃 하시겠습니까?");
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