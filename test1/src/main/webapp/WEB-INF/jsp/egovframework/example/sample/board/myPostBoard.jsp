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
	    <table border="1" class="board_list_table">
	    <thead class="board_list_thead">
		    <tr>
				<th style="width:5%;">NO</th>
					<th style="width:17%;">제목</th>
					<th>내용</th>
					<th style="width:10%;">작성자</th>
					<th style="width:20%;">작성일</th>
			</tr>
		</thead>
			<tbody class="board_list_tbody">
				<c:forEach var="row" items="${myboard}" varStatus="status">
					<tr>
					 	<td>${pages.total- ((pages.nowPage -1) * pages.perPage) - status.index }</td>
						<td><a href="BoardDetail.do?id=${row.id}">
							<c:choose>
								<c:when test="${fn:length(row.title)>15}">
									<c:out value="${fn:substring(row.title,0,14)}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${row.title}"/>
								</c:otherwise>
							</c:choose>
						</a></td>
						<td>
							<c:choose>
								<c:when test="${fn:length(row.content)>20}">
									<c:out value="${fn:substring(row.content,0,19)}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${row.content}"/>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${row.user_name}</td>
						<td>
							<fmt:formatDate value="${row.created}" pattern="yyyy-MM-dd HH:mm"/>
						</td>	
					</tr>
				</c:forEach>
			</tbody>
	    </table>
   	</div>
   	<div class="page_btn" style="display:flex; justify-content:center; margin-top:30px; ">
   		<c:if test="${pages.existPrePage}">
   			<a style="font-size:large;" href="myPostBoard.do?user_id=${user_id}&page=${pages.nowPage - 1}">Previous</a>
   		</c:if>
   		<c:forEach var="num" begin="${pages.startPage}" end="${pages.endPage}">
   			
   			<a style="margin-left:10px;font-size:large;" href="myPostBoard.do?user_id=${user_id}&page=${num}">${num}</a>
   		</c:forEach>
   		<c:if test="${pages.existNextPage}">
   			<a style="margin-left:10px;font-size:large;" href="myPostBoard.do?user_id=${user_id}&page=${pages.nowPage + 1}">Next</a>
   		</c:if>
   	</div>
</div>
</body>
</html>