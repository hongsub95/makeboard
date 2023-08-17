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
		
		$(".OauthUpdateArea").hide();
		$(document).on("click",".userupdatebtn",function(){
			var result = confirm("수정을 하시겠습니까?")
			if(result){
				alert("수정이 완료되었습니다.");
				$(".userdetailform").attr("action","<c:url value='/userupdate.do'/>")
				$(".userdetailform").submit();
				
				return true;
			}
			else{
				location.reload();
				return false;
			}
		});
		
		
		$(document).on("click",".usersetpasswordbtn",function(){
			
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
		
		$(document).on("cilck",".myPostBoardbtn",function(){
			var user_id = $(".user_id").val();
			location.href="/myPostBoard.do";
		});
		
		
		
		
	});
	
</script>
</head>
<body>
	<div class="userdetail" style="display:flex; flex-direction:column;">
	<form method="post"  class="userdetailform" style="width:400px;">
		<div style="display:flex; justify-content:center;">
			<h1 class="myInfo">내 정보</h1>
        </div>
        <hr>
        
        <input class="loginMethod" name="loginMethod" type="hidden" readonly = "readonly" value="${user.loginMethod}">
		<input class="user_id" name="user_id" type="hidden" readonly = "readonly" value="${user.user_id}">
		<input name="password" type="hidden" readonly = "readonly" value="${user.password}">
			
			<div style="margin-bottom:3px; display:flex; flex-direction:column; margin-top:30px;">
				<label for="email" style="margin-bottom:4px;">이메일</label>
				<input name="email" id="email" readonly="readonly" style="height:1.8vh;font-size:large; "value="${user.email}">
			</div>	
			
			<div style="margin-bottom:3px; display:flex; flex-direction:column;margin-top:20px;">	
				<label for="name" style="margin-bottom:4px;">이름</label>
				<input name="name" id="name" style="height:1.8vh;font-size:large;" value="${user.name}">
			</div>	
			<div style="margin-bottom:3px; display:flex; flex-direction:column; margin-top:20px;">	
				<label style="margin-bottom:4px;">생성일</label>
				<div style="font-size:x-large; font-weight:bold;">
					<fmt:formatDate value="${user.created}" pattern="yyyy-MM-dd"/>
				</div>
			</div>	
			<div style="margin-bottom:3px; display:flex; flex-direction:column; margin-top:20px;">	
				<label style="margin-bottom:4px;">수정일</label>
				<div style="font-size:x-large; font-weight:bold;">
					<fmt:formatDate value="${user.updated}"  pattern="yyyy-MM-dd"/>
				</div>
			</div>
			
			<c:if test="${user.loginMethod == 'email' }">
			<div style="margin-bottom:3px; display:flex; flex-direction:column; margin-top:20px;">	
				<label for="old_password" style="margin-bottom:4px;">현재 비밀번호</label>
				<input class="old_password" id="old_password" name="old_password" style="height:1.8vh;font-size:large;" type="password">
			</div>
			
			<div style="margin-bottom:3px; display:flex; flex-direction:column; margin-top:20px;">
				<label for="new_password" style="margin-bottom:4px;" >새로운 비밀번호</label> 
				<input class = "new_password" id="new_password" name="new_password" style="height:1.8vh;font-size:large;" type="password">
			</div>
			</c:if>	
			
		</form>
		
		<div style="display:flex; \margin-top:30px;">
		
		<c:choose>
		<c:when test="${user.loginMethod == 'email'  }">
			<button style="width:100px; border-color:black; background-color:white; color:black; margin-right:10px;" type="submit" class="userupdatebtn">수정하기</button>
			<button style="width:100px; border-color:black; background-color:white; color:black; margin-left:10px;" type="submit" class="usersetpasswordbtn">비밀번호 변경</button>
		</c:when>
		
		<c:otherwise>
			<a href="https://accounts.kakao.com/weblogin/account/info" style="color:black; font-weight:bold; text-decorator:none;"> 카카오 계정 관리</a>
		</c:otherwise>
		
		</c:choose>
			<a href="/myPostBoard.do?user_id=${user.user_id}&page=1" style="width:100px; color:black; font-weight:bold; margin-left:20px; text-decorator:none;" class="myPostBoardbtn">내가 쓴 글</a>
		</div>
		
			
	</div>
	<script>
	
	 /* function setPassword(){
			var newpw = $(".new_password").val();
			var oldpw = $(".old_password").val();
			var user_id = $(".user_id").val();
			var form = {
					user_id:user_id,
					new_password:newpw,
					old_password:oldpw
				};
			$.ajax({
				url:'<c:url value="/setpassword.do" />',
				data:form,
				type:"POST",
				dataType:"JSON",
				success:function(result){
					
					if (newpw.length == 0){
						$(".passwordNo").css("display","none");
						$(".passwordOk").css("display","none");
					} 
					
					
					else if(result.setpassword=="success"){
						$(".passwordOk").css({"display":"inline-block","color":"blue","font-size":"small"});
						$(".passwordNo").css("display","none");
						
						
					}
					else if(result.setpassword="fail"){
						$(".passwordNo").css({"display":"inline-block","color":"red","font-size":"small"});
						$(".passwordOk").css("display","none");
						
						
					} 
				},
				error:function(error){
					console.log(error);
				}
				
			});
	    };*/
	
	
	</script>
</body>
</html>