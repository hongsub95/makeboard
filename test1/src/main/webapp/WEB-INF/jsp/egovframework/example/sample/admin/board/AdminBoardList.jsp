<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/admin/Admincommon.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	
	$(document).ready(function(){
		
		
		
		selectOnchange = function(){
			var select = $("#orderByselect").val();

			location.href="/AdminBoardList.do?page=1&order="+select;
		}
		
		
	});
	
	function deletebtn(board_id){
		var checkboxpage ="<div id='checkBox' style='position:fixed; width:100%; height:100%; background-color:rgba( 255, 255, 255, 0.5 ); z-index:1;'>" 
		checkboxpage +="<div style='position:absolute; right:25%; top:30%; background-color:white; width:800px; height:600px; border:2px solid; z-index:2;'>";
		checkboxpage+="<div style='display:flex; flex-direction:column; justify-content:center; align-items:center;'>";
		checkboxpage+="<div style='margin-top:30px;'>";
		checkboxpage+="<label><input type='checkbox' name='checkedValue' value='부적절한 단어 및 문장 사용' />부적절한 단어 및 문장 사용</label>";
		checkboxpage+="</div>";
		checkboxpage+="<div style='margin-top:30px;'>";
		checkboxpage+="<label><input type='checkbox' name='checkedValue' value='의도적인 비하' />의도적인 비하</label>";
		checkboxpage+="</div>";
		checkboxpage+="<div style='margin-top:30px;'>";
		checkboxpage+="<label><input type='checkbox' name='checkedValue' value='도배 및 홍보성 게시글' />도배 및 홍보성 게시글</label>";
		checkboxpage+="</div>";
		checkboxpage+="<div style='margin-top:30px;'>";
		checkboxpage+="<label><input type='checkbox' name='checkedValue' value='부적절한 첨부파일' />부적절한 첨부파일</label>";
		checkboxpage+="</div>";
		checkboxpage+="<div style='margin-top:30px;'>";
		checkboxpage+="<label><input type='checkbox' name='checkedValue' value='저격성 게시글' />저격성 게시글</label>";
		checkboxpage+="</div>";
		checkboxpage+="<div style='margin-top:30px;'>";
		checkboxpage+="<label><input type='checkbox' name='checkedValue' value='내 마음' />내 마음</label>";
		checkboxpage+="</div>";
		checkboxpage+="<div style='margin-top:30px;'>";
		checkboxpage+="<textarea style='resize:none; outline:none; ' rows='10' cols='40' name='checkedValue' value='기타' placeholder='기타'></textarea>";
		checkboxpage+="</div>";
		checkboxpage+="<div style='margin-top:30px'>";
		checkboxpage+="</div >";
		checkboxpage+="<div style='display:flex;'>";
		checkboxpage+="<button type='button' style='margin-right:25px;' onClick='cancelBtn();'>취소</button>";
		checkboxpage+="<button type='button' onClick='submitBtn("+board_id+");'>삭제</button>";
		checkboxpage+="</div >";
		checkboxpage+="</div >";
		checkboxpage+="</div>";
		checkboxpage+="</div>"
		$(".board_list").append(checkboxpage);
		
	}
	
	cancelBtn = function(){
		$("#checkBox").remove();
	}
	
	submitBtn = function(board_id){
		var checkList = [];
		if ($("textarea[name='checkedValue']").val() != ''){
			checkList.push($("textarea[name='checkedValue']").val());
		}
		 $("input[name='checkedValue']").each(function (index){
			if ($(this).is(":checked")==true){
				checkList.push($(this).val());
			}
			
			})
		/* var checkStr = checkList.join(","); */
		var res = confirm("삭제 하시겠습니까?");
			if (res){
				$.ajax({
					url:'<c:url value="/AdminDeleteBoard.do" />',
					data:{
						"id":board_id,
						"checkedValue":checkStr
					},
					type:"POST",
					success:function(result){
						console.log(result);
						if (result == "fail"){
							
							alert("삭제 사유를 1개 이상 체크해 주세요.");
							return false;
						}
						
						else if (result == "success"){
							alert("성공적으로 삭제하였습니다.");
							location.reload();
						}
					
							
					}
							
				});
			}
			
				
	}
		 


		
	
	
</script>
</head>
<body>
<div class="all_board_list">
	
	<div class="board_list" style="position:relative; display:flex; justify-content:flex-end; right:5%; margin-top:30px; z-index:0;" >
		<div style="position:absolute; left:10%; top:0%; height:45vh; width:17%; border:2px solid;">
	   			
	   		
	   	</div>
	    <table border="1"  class="board_list_table" >
		    <thead class="board_list_thead">
			    <tr>
					<th style="width:5%;">NO</th>
					<th style="width:15%;">제목</th>
					<th>내용</th>
					<th style="width:10%;">작성자</th>
					<th style="width:17%;">작성일</th>
					<th style="width:4%">추천</th>
					<th style="width:3%">삭제</th>
				</tr>
			</thead>
			
			<tbody class="board_list_tbody">
				<c:forEach var="row" items="${boardlist}" varStatus="status">
					
						<tr>
						 	<td>${pages.total- ((pages.nowPage -1) * pages.perPage) - status.index }</td>
							<td><a style="text-decoration:none;" href="AdminBoardDetail.do?id=${row.id}">
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
							<td>
							${row.count }
							</td>	
							<td>
								<button type="button" onClick="deletebtn('${row.id }');" >❌</button>
							</td>
						</tr> 
					</c:forEach>
			</tbody>
	    </table>
	    	
	    	<c:choose>
	    		<c:when test="${param.order == 'heart' }">
			    	<div style="position:absolute; bottom:-40px;">
						<select style="width:80px; text-align:center; height:2vh; border-radius:1.2em;" onChange="selectOnchange();" name="order" id="orderByselect">
							<option id="orderByheart" value="heart">인기순</option>
							<option  id="orderBycreated" value="create" >최신순</option>
						</select>
					</div>
				</c:when>
				<c:otherwise>
					<div style="position:absolute; bottom:-40px;">
						<select style="width:80px; text-align:center; height:2vh; border-radius:1.2em;" onChange="selectOnchange();" name="order" id="orderByselect">
							<option id="orderByheart" value="create" >최신순</option>
							<option  id="orderBycreated" value="heart">인기순</option>
						</select>
					</div>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${param.order == 'heart' }">
					<div style="position:absolute; bottom:-80px; right:30%;">
			   			<c:if test="${pages.existPrePage}">
					   		<a style="font-size:large;" href="AdminBoardList.do?page=${pages.nowPage - 1}&order=heart">Previous</a>
					   	</c:if>
					   	<c:forEach var="num" begin="${pages.startPage}" end="${pages.endPage}">
					   		<a style="margin-left:10px;font-size:large;" href="AdminBoardList.do?page=${num}&order=heart">${num}</a>
					   	</c:forEach>
					    <c:if test="${pages.existNextPage}">
					   		<a style="margin-left:10px;font-size:large;" href="AdminBoardList.do?page=${pages.nowPage + 1}&order=heart">Next</a>
						</c:if>
					</div>
				</c:when>
				<c:otherwise>
					<div style="position:absolute; bottom:-80px; right:30%;">
			   			<c:if test="${pages.existPrePage}">
					   		<a style="font-size:large;" href="AdminBoardList.do?page=${pages.nowPage - 1}&order=create">Previous</a>
					   	</c:if>
					   	<c:forEach var="num" begin="${pages.startPage}" end="${pages.endPage}">
					   		<a style="margin-left:10px;font-size:large;" href="AdminBoardList.do?page=${num}&order=create">${num}</a>
					   	</c:forEach>
					    <c:if test="${pages.existNextPage}">
					   		<a style="margin-left:10px;font-size:large;" href="AdminBoardList.do?page=${pages.nowPage + 1}&order=create">Next</a>
						</c:if>
					</div>
				</c:otherwise>
			</c:choose>
   		</div>
	</div> 	
</body>
</html>
