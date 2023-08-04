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
		
		$(".boardupdatebtn").click(function(){
			var result = confirm("수정하시겠습니까?");
			if(result){
				var title=$(".boarddetailtitle").val();
				var content = $(".boarddetailcontent").val();
				
				$.ajax({
					url:'<c:url value="/boardupdate.do" />',
					data:{
						title:title,
						content:content
					},
					type:"POST",
					success:function(result){
						alert("수정이 완료되었습니다");
						
					}
				});
			}
			else{
				event.preventDefault();
				location.reload();
			}
		});
		
		$(".boarddeletebtn").click(function(){
			var result = confirm("삭제하시겠습니까?");
			if(result){
				var board_id = $("#id").val();
				$.ajax({
					url:'<c:url value="/boarddelete.do" />',
					data:{
						id:board_id
					},
					type:"POST",
					success:function(result){
						alert("삭제되었습니다.");
						location.href='<c:url value="/BoardList.do?page=1" />';
						
					}
				});
			}
			else{
				event.preventDefault();
				location.reload();
			}
		});
	});
	
	
	


</script>
</head>
<body>
	<div class="boarddetail" style="display:flex; flex-direction:column;">
		<form method="post" action="">
		<input id= "id" name="id" type="hidden" value="${board.id}"><br>
		<input class="board_user_id" name="board_user_id" type="hidden" value="${board.user_id}"><br>
		
		<table style="width:900px; background-color:#aef5ff;">
		<tr>
			<td><input style="width:500px; border:none; height:3vh; font-size:large; outline:none;" name="title" class="boarddetailtitle" value="${board.title}"></td>
			<td style="display:flex; justify-content:flex-end;">작성자 : ${board.user_name}</td>
			<td style="display:flex; justify-content:flex-end;" >작성일:<c:choose>
					<c:when test="${empty board.updated }">
						<fmt:formatDate value="${board.created}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:when>
					<c:otherwise>
						<fmt:formatDate value="${board.updated}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:otherwise>	
				</c:choose>
			</td>
		</tr>
		<tr>
			<td colspan = "3" style="color:white"><textarea style="resize:none; border:none; width:800px; height:60vh; font-size:x-large; outline:none;" name="content" class="boarddetailcontent">${board.content}</textarea></td>
		</tr>
		</table>
		
		</form>
		<c:if test="${!empty sessionScope.user_id && sessionScope.user_id == board.user_id}">
			<div style="display:flex; justify-content:space-evenly; margin-top:30px;">
				<button style="width:100px; border-color:blue;  background-color:blue; color:white; border-radius:1.2rem; margin-right:15px;" type="submit" class="boardupdatebtn">수정</button>
				<button style="width:100px; border-color:red; background-color:red; color:white;border-radius:1.2rem; margin-left:15px;" type="submit"  class="boarddeletebtn">삭제</button>
			</div>
		</c:if>
	</div>
	
</body>
</html>