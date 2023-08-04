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
		$(".signupsubmitbtn").click(function(){
			var result = confirm("회원가입을 하시겠습니까?");
			if(result){
				var user_id = $(".user_id").val();
				var email = $(".email").val();
				var password = $(".password").val();
				var name = $(".name").val();
				var form = {
					user_id:user_id,
					email:email,
					password:password,
					name:name
				}
				
				$.ajax({
					url : '<c:url value="/SignupForm.do" />',
					data:form,
					type:"POST",
					success:function(result){
						var msg = result.msg;
						if (msg=="success"){
							alert("성공적으로 회원가입이 되셨습니다.");
							location.href="/home.do";
						}
						else if (msg == "already"){
							alert("이미 회원가입된 회원입니다.");
							location.href="/ChoiceLoginForm.do";
						}
						else if (msg == "minPasswordlength"){
							alert("비밀번호는 최소8자리 최대13자리입니다.");
							location.reload();
						}
						else if (msg == "fail"){
							alert("회원가입이 실패하셨습니다.");
							location.reload();
						}
					}
				})
			}
		});
	});

</script>
</head>
<body>
	<div class="signupform" style="display:flex; flex-direction:column;">
		<form action="" method="post"  style="width:400px;">
		
			<div style="display:flex; justify-content:center;">
				<h1>회원가입</h1>
			</div>
			<hr>
			<input type="hidden" class="user_id" name="user_id"/>
			<div style="display:flex; flex-direction:column;">
				<label >이메일</label>
				<input style="height:2vh; border-color:black;" type="text" class="email" name="email" placeholder="이메일"/>
			</div>
			<div style="display:flex; flex-direction:column;">	
				<label style="margin-top:40px;">비밀번호</label>
				<input style="height:2vh;border-color:black;" type="password" class="password" placeholder="패스워드" maxlength=13 name="password"/>
			</div>
			<div style="display:flex; flex-direction:column;">	
				<label style="margin-top:40px;">이름</label>
				<input style="height:2vh;border-color:black;" type="text" class="name" placeholder="이름" name="name"/>
			</div>
		
		<div style="display:flex; justify-content:center; margin-top:50px;">
			<button style="width:100px; border-color:black; background-color:white; color:black; margin-left:10px;" class="signupsubmitbtn" type=button>회원가입</button>
		</div>
		</form>
	</div>
</body>
</html>