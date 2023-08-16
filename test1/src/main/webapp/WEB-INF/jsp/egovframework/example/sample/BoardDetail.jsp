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
				var file = $("input[name='file']");
				var board_id = $("#id").val();
				
				var files = file[0].files;
				var formData = new FormData();
				formData.append("title",title);
				formData.append("board_id",board_id);
				formData.append("content",content);
				for(var i = 0; i<files.length; i++){
					formData.append("uploadFile",files[i])
				}
				$.ajax({
					url:'<c:url value="/boardupdate.do" />',
					data:formData,
					processData: false,
				    contentType: false,
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
	
	function fn_fileDown(file_id){
		var formObj = $("form[name='readForm']");
		$("#file_id").attr("value", file_id);
		formObj.attr("action", "/fileDownload.do");
		formObj.submit();
	}
	
	function fileDelete(file_id){
		
		$.ajax({
			url : '<c:url value="/fileDelete.do" />',
			data:{
				file_id:file_id
			},
			type:"POST",
			success:function(result){
				location.reload();
			}
			
		});
		
	}
	
	function InsertOrDeleteHeart(user_id){
		
		var BoardUserID = $(".board_user_id").val();
		var board_id = $("#id").val();
		
		if (user_id == '' || user_id == ' ' )
		{
			alert("로그인 후 이용가능하십니다.");
			location.reload();
		}
		
		// request user와 좋아요 누른 user의 id가 같을경우
		else if (user_id == BoardUserID)
		{
			alert("자기 게시물에는 좋아요를 누를수 없습니다.");
			location.reload();
		}
		else 
		{	
			$.ajax({
				url : '<c:url value="/checkUserHeart.do" />',
				data:{
					user_id:user_id,
					board_id:board_id
				},
				async:false,
				type:"get",
				success:function(result){
					
					if (result == "fail"){
						$.ajax({
							url : '<c:url value="/heartdelete.do" />',
							data:{
								user_id:user_id,
								board_id:board_id
							},
							type:"POST",
							success:function(result){
								location.reload();
							}
							
						});
					}
					else if(result == "success")
					{
						$.ajax({
							url : '<c:url value="/plusHeart.do" />',
							data:{
								user_id:user_id,
								board_id:board_id
							},
							type:"POST",
							success:function(result){
								location.reload();
							}
						});
					}  
				}
				
			});
		}
	}
		
	


</script>
</head>
<body>
	<form name="readForm" role="form" method="post">
		<input type="hidden" id="file_id" name="file_id" value=""> 
	</form>
	<div class="boarddetail" style="display:flex; flex-direction:column; align-items:center;">
		<form method="post" action="">
		<input id="id" name="id" type="hidden" value="${board.id}"><br>
		<input class="board_user_id" name="board_user_id" type="hidden" value="${board.user_id}"><br>
		
		<table style="width:80%;">
			<tr>
			
			<c:choose>
				<c:when test="${!empty sessionScope.user_id && sessionScope.user_id == board.user_id}">
					<td ><input style="width:500px; border:none; font-size:large; outline:none; font-size: x-large;" name="title" class="boarddetailtitle" value="${board.title}"></td>
				</c:when>
				<c:otherwise>
					<td><input style="width:500px; border:none;font-size:large; outline:none; font-size:x-large;"readonly="readonly" name="title" class="boarddetailtitle" value="${board.title}"></td>
				</c:otherwise>
			</c:choose>	
				
				<td style=" display:flex; justify-content:flex-end;">
					<div>
						작성자 : ${board.user_name}
					</div>
				</td>
				<td style=" display:flex; justify-content:flex-end;">
					<div>
						작성일 : <fmt:formatDate value="${board.created}" pattern="yyyy-MM-dd HH:mm"/>
					</div>
				</td>
			</tr>
			<tr>
			<c:choose>
				<c:when test="${!empty sessionScope.user_id && sessionScope.user_id == board.user_id}">
					<td colspan = "3" style="color:white">
						<textarea style="resize:none; border:none; width:800px; height:60vh; font-size:x-large; outline:none;" name="content" class="boarddetailcontent">${board.content}</textarea>
					</td>
				</c:when>
				<c:otherwise>
					<td colspan = "3" style="color:white">
						<textarea style="resize:none; border:none; width:800px; height:60vh; font-size:x-large; outline:none;" readonly="readonly" name="content" class="boarddetailcontent">${board.content}</textarea>
					</td>
				</c:otherwise>
			</c:choose>	
			</tr>
			<tr>
				<td colspan = "3" >
					<div style="display:flex; flex-direction:column; justify-content:center; align-items:center;">
						<input type="hidden" class="checkuserheart" value=${checkUserHeart }/>
							<div>
								<button type="button" id="heartBtn" onClick="InsertOrDeleteHeart('${sessionScope.user_id}');"><img class="heartimgbtn" src="https://cdn-icons-png.flaticon.com/512/6326/6326226.png" style="width:40px; padding:0px 30px 0px 30px; background-color:white; "/></button>
							</div>
							
							<div style="display:flex; margin-top:5px; justify-content:flex-end;">
								추천 : + <c:out value="${heart}"/>
							</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan = "3">
				<div>
					<div>
						<h4>첨부파일</h4>
					</div>
					<c:if test="${!empty sessionScope.user_id && sessionScope.user_id == board.user_id}">
						<input type="file" name="file" multiple/>
					</c:if>
					<div style="display:flex; flex-direction:column;">
						<c:forEach var="file" items="${files}" varStatus="status">
							<span style="margin-right:10px;">
								<a href ="#" onClick ="fn_fileDown('${file.file_id}'); return false;" ><c:out value="${file.originalFileName }"/></a>
								(<fmt:formatNumber value="${file.fileSize / 1024}" pattern=".00" />KB)
								<c:if test="${!empty sessionScope.user_id && sessionScope.user_id == board.user_id}">
									<button type="button" id="fileDeleteBtn" onClick="fileDelete('${file.file_id}'); return false;">❌</button>
								</c:if>
							</span>
						</c:forEach>
					</div>
					
				</div>
				 
				</td>
			</tr>
		</table>
		
		</form>
		<c:if test="${!empty sessionScope.user_id && sessionScope.user_id == board.user_id}">
			<div style="display:flex; justify-content:space-evenly; margin-top:20px;">
				<button style="width:100px; border-color:blue;  background-color:blue; color:white; border-radius:1.2rem; margin-right:15px;" type="submit" class="boardupdatebtn">수정</button>
				<button style="width:100px; border-color:red; background-color:red; color:white;border-radius:1.2rem; margin-left:15px;" type="submit"  class="boarddeletebtn">삭제</button>
			</div>
		</c:if>
	</div>
	
</body>
</html>