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
		const urlParams = new URL(location.href).searchParams;
		const page = urlParams.get("page");
		
		$("#orderByselect").change(function(){
			var selected = $("#orderByselect").val();
			
			if (selected == "orderBycreated"){
				$.ajax({
					url:'<c:url value="/AsyncBoardListData.do?page=1" />',
					data:{page:page},		
					type:"get",
					success:function(result){
						$("tbody").empty();
						$(".page_btn").empty();
						var boardlist = result.boardlist;
						var pages = result.pages;
						
						for(var i=0;i<boardlist.length;i++){
							$("tbody").append(orderByCommon(boardlist[i],pages,i));
						}
						$(".page_btn").append(orderByBtn(pages));
						
						
							
					}
				});
			}
			else if (selected == "orderByheart"){
				$.ajax({
					url:'<c:url value="/AsyncBoardListHeartData.do?page=1" />',
					type:"get",
					data:{page:page},
					success:function(result){
						$("tbody").empty();
						$(".page_btn").empty();
						var boardlist = result.boardlist;
						var pages = result.pages;
						
						for(var i=0;i<boardlist.length;i++){
							
							$("tbody").append(orderByCommon(boardlist[i],pages,i));
							
						}
						
						$(".page_btn").append(orderByHeartBtn(pages));
						
							
					}
				});
				
			}
		}); 
	});
	
	
	orderByCommon = function(board,pages,i){
		
		var orderBycommon ="";
		orderBycommon +="<tr>";
		orderBycommon +="<td>"+(pages.total- ((pages.nowPage -1) * pages.perPage)-i)+"</td>";
		orderBycommon += "<td><a href='BoardDetail.do?id="+board.id+"'>";
		if (board.title.length >15){
			orderBycommon += board.title.slice(0,15);
		}
		else{
			orderBycommon += board.title;
		}
		orderBycommon += "</a></td>";
		orderBycommon +="<td>";
		if (board.content.length > 20){
			orderBycommon += board.content.slice(0,20);
		}
		else{
			orderBycommon += board.content;
		}
		orderBycommon +="</td>";
		orderBycommon +="<td>"+board.user_name+"</td>";
		orderBycommon +="<td>";
		orderBycommon += timestampTodate(board.created);
		orderBycommon +="</td>";
		orderBycommon += "</tr>";
		
		return orderBycommon;
	}
	
	nextOrPrePageBtn = function(page){
		$.ajax({
			url : '<c:url value="/AsyncBoardListData.do" />',
			data : {page:page},
			type: "get",
			success:function(result){
				$("tbody").empty();
				$(".page_btn").empty();
				var boardlist = result.boardlist;
				var pages = result.pages;
				for(var i=0;i<boardlist.length;i++){
					
					$("tbody").append(orderByCommon(boardlist[i],pages,i));
					
				}
				$(".page_btn").append(orderByHeartBtn(pages));
				
			}
			
		
		
		})
	}
	
	orderByBtn = function(pages){
		var btn = "";
		
		if (pages.existPrePage){
			btn += "<a style='font-size:large; cursor:pointer;' onClick='nextOrPrePageBtn("+(pages.nowPage-1)+")'>Previous</a>";
			
		}
		for(var i = pages.startPage; i<=pages.endPage;i++){
			btn+="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrePageBtn("+i+")'>"+i+"</a>";
		}
		if (pages.existNextPage){
			btn +="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrePageBtn("+(pages.nowPage+1)+")'>Next</a>";
			
		}
		return btn
		
	}
	
	nextOrPrePageHeartBtn = function(page){
		$.ajax({
			url : '<c:url value="/AsyncBoardListHeartData.do" />',
			data : {page:page},
			type: "get",
			success:function(result){
				$("tbody").empty();
				$(".page_btn").empty();
				var boardlist = result.boardlist;
				var pages = result.pages;
				for(var i=0;i<boardlist.length;i++){
					
					$("tbody").append(orderByCommon(boardlist[i],pages,i));
					
				}
				$(".page_btn").append(orderByHeartBtn(pages));
				
			}
			
		
		
		})
	}
	
	orderByHeartBtn = function(pages){
		var btn = "";
		
		if (pages.existPrePage){
			btn += "<a style='font-size:large; cursor:pointer;' onClick='nextOrPrePageHeartBtn("+(pages.nowPage-1)+")'>Previous</a>";
			
		}
		for(var i = pages.startPage; i<=pages.endPage; i++){
			btn+="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrePageHeartBtn("+i+")'>"+i+"</a>";
		}
		if (pages.existNextPage){
			btn +="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrePageHeartBtn("+(pages.nowPage+1)+")'>Next</a>";
			
		}
		return btn
		
	}
	
	
	
	timestampTodate = function(timestamp){
		var date = new Date(timestamp);
		
		var result = 
			(date.getFullYear()+"-"+
			((date.getMonth()+1)>=10 ? (date.getMonth()+1):("0"+(date.getMonth()+1)))+"-"+
			((date.getDate()+1)>=10 ? (date.getDate()):("0"+(date.getDate())))+" "+
			(date.getHours()>=10 ? date.getHours():("0"+date.getHours()))+":"+
			(date.getMinutes()>=10 ? date.getMinutes():("0"+date.getMinutes())))
			
		
		
		return result;
	}
	
	function SearchBtn(){
		var word = $("#search-bar").val();
		location.href="/SearchBoard.do?page=1&word="+word;
		
	}
		
	
	
</script>
</head>
<body>
<div class="all_board_list">
	<input type="hidden" id="searchwordmsg" value="${msg }"/>
	<div class="board_list" style="position:relative; margin-top:30px;" >
	    <table border="1"  class="board_list_table" >
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
				<c:forEach var="row" items="${boardlist}" varStatus="status">
						<tr>
						 	<td>${pages.total- ((pages.nowPage -1) * pages.perPage) - status.index }</td>
							<td><a style="text-decoration:none;" href="BoardDetail.do?id=${row.id}">
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
	    
	    <div style="position:absolute; right:15%; bottom:-40px;">
			<select style="width:80px; text-align:center; height:2vh; border-radius:1.2em;" id="orderByselect">
				<option  id="orderBycreated" value="orderBycreated">최신순</option>
				<option id="orderByheart" value="orderByheart" >인기순</option>
			</select>
		</div>
		
		<div style="position:absolute; display:flex; bottom:-70px;">
			
			<input style="width:500px; border-color:black;" id="search-bar" placeholder="검색어를 입력해  주세요."/>
			<button style="width:70px; border-color:black; cursor:pointer; background-color:white; color:black; border-left:none;" type="button" onClick="SearchBtn();">
				<img style="width:30px;" src="https://cdn-icons-png.flaticon.com/512/71/71403.png"/>
			</button>
			
		</div>
		
		<div class="page_btn" style="position:absolute; bottom:-130px;">
			<c:choose>
				<c:when test="${!empty param.word }">
			   		<c:if test="${pages.existPrePage}">
			   			<a style="font-size:large;" href="SearchBoard.do?page=${pages.nowPage - 1}&word=${param.word}">Previous</a>
			   		</c:if>
			   		<c:forEach var="num" begin="${pages.startPage}" end="${pages.endPage}">
			   			
			   			<a style="margin-left:10px;font-size:large;" href="SearchBoard.do?page=${num}&word=${param.word}">${num}</a>
			   		</c:forEach>
			   		<c:if test="${pages.existNextPage}">
			   			<a style="margin-left:10px;font-size:large;" href="SearchBoard.do?page=${pages.nowPage + 1}&word=${param.word}">Next</a>
			   		</c:if>
	   			</c:when>
	   			<c:otherwise>
	   				<c:if test="${pages.existPrePage}">
			   			<a style="font-size:large;" href="BoardList.do?page=${pages.nowPage - 1}">Previous</a>
			   		</c:if>
			   		<c:forEach var="num" begin="${pages.startPage}" end="${pages.endPage}">
			   			
			   			<a style="margin-left:10px; font-size:large;" href="BoardList.do?page=${num}">${num}</a>
			   		</c:forEach>
			   		<c:if test="${pages.existNextPage}">
			   			<a style="margin-left:10px; font-size:large;" href="BoardList.do?page=${pages.nowPage + 1}">Next</a>
			   		</c:if>
	   			</c:otherwise>
	   		</c:choose>
	   		
	   		
   		</div>
   	</div>
   	
</div> 	
</body>
</html>
