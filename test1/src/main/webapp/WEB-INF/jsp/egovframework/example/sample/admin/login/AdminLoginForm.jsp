<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/egovframework/board.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
<script type="text/javascript" src="<c:url value='/js/com/jquery-3.7.0.min.js'/>"></script>
<script>

	$(document).ready(function(){
		$(document).on("click",".loginbtn",function(){
			$.ajax({
				url:'<c:url value="/AdminLogin.do" />',
				data:{
					email:$("#email").val(),
					password:$("#password").val()
				},
				type:"POST",
				success:function(result){
					
					if(result.msg == "success"){
						alert(result.name+"님 환영합니다.");
						location.href="/Adminhome.do";
					}
					else if (result.msg == "noUser"){
						$(".noUser").removeAttr('display');
						$(".noUser").css({"display":"inline-block","color":"red","font-size":"small"})
					}
					else if (result.msg == "noPassword"){
						$(".noPassword").removeAttr('display');
						$(".noPassword").css({"display":"inline-block","color":"red","font-size":"small"});
					}
					
					else if(result.msg == "notAccess"){
						alert("접근제한이 없는 계정입니다.");
						location.reload();
					}
				},
				error : function(){
	            	alert("ajax 실행 실패");
	        	}
			});
		});
		
	});

</script>
</head>
<body>
<div class="loginform" style="display:flex; flex-direction:column;">
	
		<form action="" method="post" style="width:400px;">
			<div style="display:flex; justify-content:center;">
				<h1>로그인</h1>
			</div>
			<hr>
			
			<div style="display:flex; flex-direction:column; margin-bottom:40px;">
				<label style="margin-top:30px;">이메일</label>
				<input type="text" style="margin-top:3px;height:2vh;border-color:black;" id="email" name="email" placeholder="이메일"/>
				<span style="display:none;" class="noUser">가입된 회원이 아닙니다.</span>
			</div>
			
			<div style="display:flex; flex-direction:column; margin-bottom:40px;">
				<label style="margin-bottom:4px;">비밀번호</label>
				<input type="password" style="height:2vh;border-color:black;" name="password" id="password" placeholder="비밀번호"/>
				<span style="display:none;" class="noPassword">비밀번호가 일치하지 않습니다.</span>
			</div>
		</form>
		<div style="display:flex; justify-content:center; margin-top:20px;">
				<button style="cursor:pointer; width:100px; border-color:black; background-color:white; color:black; margin-left:10px; " class="loginbtn" type="submit"> 로그인  </button> 
		</div>
		<div class="kakao_Loginbtn" style=" display:flex; justify-content:center; margin-top:50px; margin-bottom:30px; padding-rigth:50px;">
			<a style="display:flex; justify-content:center; align-items:center;text-align:center;width:400px;height:5vh;border:2px solid;border-radius:1.2rem; border-color:#964b00; background-color:#F7E600; color:#964b00; font-weight:bold;font-size:x-large; text-decoration:none;" href="https://kauth.kakao.com/oauth/authorize?response_type=code&redirect_uri=http://localhost:8080/auth/kakao/callback.do&client_id=b5a3afb094585ae6bd3ad90921e1b7c0">카카오톡
				<i class="fas fa-comment mr-2 fa-lg"></i>
			</a>
		</div>
	
</div>
</body>
</html>