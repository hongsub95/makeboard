<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	$(document).ready(function(){
		alert("세션기한이 만료되었습니다.");
		location.href="/home.do";
	});

</script>
</head>
<body>
	
</body>
</html>