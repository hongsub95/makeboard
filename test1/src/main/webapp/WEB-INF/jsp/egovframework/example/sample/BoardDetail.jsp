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
		canUpdateOrDelete();	
	});
	
	canUpdateOrDelete = function(){
		var user_id =  "<%=session.getAttribute("user_id") %>";
		if(${board.user_id}==user_id){
			return;
		}
		else{
			$(".boarddetailtitle").attr("readonly","readonly");
			$(".boarddetailcontent").attr("readonly","readonly");
			$("button").remove();
		}
	};
	


</script>
</head>
<body>
	<div class="boarddetail">
		<form method="post" action="">
		<input name="id" type="hidden" value="${board.id}"><br>
		제목:<input name="title" class="boarddetailtitle" value="${board.title}"><br>
		내용:<input name="content" class="boarddetailcontent" value="${board.content}"><br>
		작성자:<input name="user_name" readonly="readonly" value="${board.user_name}"><br>
		생성일:<fmt:formatDate value="${board.created}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
		수정일:<fmt:formatDate value="${board.updated}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
		
		<button type="submit" formaction="boardupdate.do" class="boardupdatebtn">수정</button>
		<button type="submit" formaction="boarddelete.do" class="boarddeletebtn">삭제</button>
		</form>
	</div>
	
</body>
</html>