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
</head>
<body>

	<div id="Admingradelog" style='position:fixed; top:5%; width:100%; height:100%; background-color:rgba( 255, 255, 255, 0.5 ); z-index:1;'>
		<div id="gradeloglist" style='position:absolute; right:35%; top:8%; background-color:white; width: 70%; height:1000px; border:2px solid; z-index:2;'>
		<table style="width:100%; height:100%;" border="1"  >
		    <thead>
			    <tr>
					<th style="width:10%;">NO</th>
					<th>내용</th>
					<th style="width:20%;">날짜</th>
					
				</tr>
			</thead>
			
			<tbody >
				
					
				
			</tbody>
	    </table>
	    
	   	<div class="page_btn" style="position:absolute; bottom:-130px;">
	   	</div>
   		</div>
	</div>
</body>
</html>