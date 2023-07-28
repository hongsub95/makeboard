<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="boardDetailForm">
	<form action="" method="post"  >
		제목 : <input type="text" name="title" class="boardtitle"placeholder="제목을 입력해주세요."/><br>
		내용 : <textarea name="content" class="boardcontent" rows="20" cols="50" ></textarea><br>
		<input type=submit>
	</form>
</div>
</body>
</html>