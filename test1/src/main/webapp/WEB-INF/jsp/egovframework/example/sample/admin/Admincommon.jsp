<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/egovframework/board.css?after" rel="stylesheet"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
<script type="text/javascript" src="<c:url value='/js/com/jquery-3.7.0.min.js'/>"></script>

<title>Board For Admin</title>
	<script>


	$(document).ready(function() {
		
		
		$("#logout").click(function(event){
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
		var sessionAdminId = $("#sessionAdminId").val();
		
		if (sessionAdminId == '' || sessionAdminId == ' '){
			location.href="/AdminLoginForm.do";
		}
		else if (sessionAdminId == 0){
			location.href="/AdminLoginForm.do";
		}
	});
	
	/* AdminuserBtn = function(){
		$.ajax({
			url:'<c:url value="/AdminUserList.do"/>',
			data:{"page":"1"},
			type:"get",
			success:function()
		})
		
		
	} */

		
	
	</script>
</head>
<body>
	<input type="hidden" id="sessionAdminId" value="${sessionScope.is_admin }"/>
	
	<header>
		<div class="header-nav menu_effect">
			<a style="text-decoration:none; color:black; font-size:large;" href="Adminhome.do" id="home">Home</a>
			<a style="text-decoration:none; color:black; font-size:large;" href="AdminLoginForm.do" id="logout">로그아웃</a>
			<a style="text-decoration:none; color:black; font-size:large;" href="AdminBoardList.do?page=1" id="adminboard">게시물관리</a>
			<a style="text-decoration:none; color:black; font-size:large;" href="AdminUserList.do"  id="adminuser">회원관리</a>
		</div>
	</header>
	
	<div>
	
		
	
	</div>
	

</body>
</html>