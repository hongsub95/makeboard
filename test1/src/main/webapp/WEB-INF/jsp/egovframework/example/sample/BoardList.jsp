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
<div class="all_board_list">
	<div class="board_list">
	    <table border="1" class="board_table">
	    <thead>
		    <tr>
				<th>NO</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>생성일</th>
			</tr>
		</thead>
		<c:forEach var="row" items="${boardlist}">
			<tbody>
				<tr>
				
				 	<td> ${row.id}</td>
					<td><a href="BoardDetail.do?id=${row.id}">${row.title}</a></td>
					<td>${row.content}</td>
					<td>${row.user_name}</td>
					<td>
						<fmt:formatDate value="${row.created}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>	
				</tr>
			</tbody>
		</c:forEach>
	    </table>
   	</div>
   	<div class="page_btn" style="display:flex; justify-content:center; margin-top:30px">
   		<c:if test="${pages.existPrePage}">
   			<a href="BoardList.do?page=${pages.nowPage - 1}">Previous</a>
   		</c:if>
   		<c:forEach var="num" begin="${pages.startPage}" end="${pages.endPage}">
   			
   			<a href="BoardList.do?page=${num}">${num}</a>
   		</c:forEach>
   		<c:if test="${pages.existNextPage}">
   			<a href="BoardList.do?page=${pages.nowPage + 1}">Next</a>
   		</c:if>
   	</div>
</div> 	
</body>
</html>