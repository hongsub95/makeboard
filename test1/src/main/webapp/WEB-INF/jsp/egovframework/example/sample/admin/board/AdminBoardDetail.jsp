<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/admin/Admincommon.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>

	$(document).ready(function(){
		
	
		function fn_fileDown(file_id){
			var formObj = $("form[name='readForm']");
			$("#file_id").attr("value", file_id);
			formObj.attr("action", "/fileDownload.do");
			formObj.submit();
		}
		
	});
	
	function deletebtn(board_id){
		
		var checkboxpage="<div style='position:absolute; right:34%; top:25%; background-color:white; width:800px; height:600px; border:2px solid; z-index:2;'>";
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
		checkboxpage+="</div>";
		checkboxpage+="</div >";
		checkboxpage+="</div>";
		$(".boarddetail").append(checkboxpage);
		
	}
	
	cancelBtn = function(){
		location.reload();
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
		
		var res = confirm("삭제 하시겠습니까?");
			if (res){
				$.ajax({
					url:'<c:url value="/AdminDeleteBoard.do" />',
					data:{
						"id":board_id,
						"checkedValue":checkList
					},
					type:"POST",
					success:function(result){
						console.log(result);
						if (result == "fail"){
							
							alert("삭제 사유를 1개 이상 체크해 주세요.");
							location.reload();
						}
						
						else if (result == "success"){
							alert("성공적으로 삭제하였습니다.");
							location.href = "/AdminBoardList.do"
						}
					
							
					}
							
				});
			}
			
				
	}
	
	AdminBtn = function(){
		
		alert("관리자 모드에서는 첨부파일 및 추천기능 등을 이용할 수 없습니다.");
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
			
			<td><input style="width:500px; border:none;font-size:large; outline:none; font-size:x-large;"readonly="readonly" name="title" class="boarddetailtitle" value="${board.title}"></td>
				
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
			<td colspan = "3" style="color:white">
				<textarea style="resize:none; border:none; width:800px; height:60vh; font-size:x-large; outline:none;" readonly="readonly" name="content" class="boarddetailcontent">${board.content}</textarea>
			</td>	
			</tr>
			<tr>
				<td colspan = "3" >
					<div style="display:flex; flex-direction:column; justify-content:center; align-items:center;">
						<input type="hidden" class="checkuserheart" value=${checkUserHeart }/>
							<div>
								<button type="button" id="heartBtn" onClick="AdminBtn();"><img class="heartimgbtn" src="https://cdn-icons-png.flaticon.com/512/6326/6326226.png" style="width:40px; padding:0px 30px 0px 30px; background-color:white; "/></button>
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
					
					<div style="display:flex; flex-direction:column;">
						<c:forEach var="file" items="${files}" varStatus="status">
							<span style="margin-right:10px;">
								<a href ="#" onClick ="fn_fileDown('${file.file_id}'); return false;" ><c:out value="${file.originalFileName }"/></a>
								(<fmt:formatNumber value="${file.fileSize / 1024}" pattern=".00" />KB)
								<c:if test="${!empty sessionScope.user_id && sessionScope.user_id == board.user_id}">
									<button type="button" id="fileDeleteBtn" onClick="AdminBtn();">❌</button>
								</c:if>
							</span>
						</c:forEach>
					</div>
					
				</div>
				 
				</td>
			</tr>
		</table>
		
		</form>
		
		<div style="display:flex; justify-content:space-evenly; margin-top:20px;">
			<button style="width:100px; border-color:red; background-color:red; color:white;border-radius:1.2rem; margin-left:15px;" type="button" onClick="deletebtn(${board.id});">삭제</button>
		</div>
		
	</div>
	
</body>
</html>
</body>
</html>