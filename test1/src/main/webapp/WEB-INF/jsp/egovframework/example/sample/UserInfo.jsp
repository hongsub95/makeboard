<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/common.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>


	$(document).ready(function(){
		
		$(".userupdatebtn").click(function(){
			var result = confirm("수정을 하시겠습니까?")
			if(result){
				$(".userdetailform").attr("action","<c:url value='/userupdate.do'/>")
				$(".userdetailform").submit();
				
				return true;
			}
			else{
				location.reload();
				return false;
			}
		});
		
		
		$(".usersetpasswordbtn").click(function(){
			var result = confirm("비밀번호를 변경 하시겠습니까?")
			if(result){
				var newpw = $(".new_password").val();
				var oldpw = $(".old_password").val();
				var user_id = $(".user_id").val();
				var form = {
						user_id:user_id,
						new_password:newpw,
						old_password:oldpw
					};
				var json_form = JSON.stringify(form);
				
				
				$.ajax({
					url:'<c:url value="/setpassword.do" />',
					data:form,
					type:"POST",
					
					success:function(result){
						
						if(result.setpassword=="success"){
							alert("비밀번호 변경이 성공적으로 이루어졌습니다.");
							location.href="/home.do";
						}
						else if(result.setpassword="fail"){
							alert("비밀번호 변경이 실패하였습니다.");
							location.reload();
						} 
					},
					error:function(error){
						console.log(error);
					}
					
				});
			}
				
			else{
				location.reload();
				return false();
			}
		});
		
	});
	
	
</script>
</head>
<body>
	<div class="userdetail">
		<form method="post"  class="userdetailform">
			
			<input class="user_id" name="user_id" type="hidden" value="${user.user_id}"><br>
			<input name="password" type="hidden" value="${user.password}"><br>
			이메일:<input name="email" readonly="readonly" value="${user.email}"><br>
			이름:<input name="name" value="${user.name}"><br>
			생성일:<fmt:formatDate value="${user.created}" pattern="yyyy-MM-dd"/><br>
			수정일:<fmt:formatDate value="${user.updated}" pattern="yyyy-MM-dd"/><br>
			현재 비밀번호: <input class="old_password" name="old_password" type="password"><br>
			새로운 비밀번호: <input class = "new_password" name="new_password" type="password"><br>
			<button type="button" class="userupdatebtn">수정</button>
			<button type="button"  class="usersetpasswordbtn">패스워드 변경</button>
		</form>
	</div>
</body>
</html>