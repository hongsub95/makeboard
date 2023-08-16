<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	$(document).ready(function(){
		$(document).on("click",".loginbtn",function(){
			$.ajax({
				url:'<c:url value="/LoginForm.do" />',
				data:{
					email:$("#email").val(),
					password:$("#password").val()
				},
				type:"POST",
				success:function(result){
					
					if(result.msg == "success"){
						alert(result.name+"님 환영합니다.");
						location.href="/home.do";
					}
					else if (result.msg == "noUser"){
						$(".noUser").removeAttr('display');
						$(".noUser").css({"display":"inline-block","color":"red","font-size":"small"})
					}
					else if (result.msg == "noPassword"){
						$(".noPassword").removeAttr('display');
						$(".noPassword").css({"display":"inline-block","color":"red","font-size":"small"});
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
<div class="loginform" style="display:flex; flex-direction:column; ">
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
</div>
</body>
</html>