<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>

	$(document).ready(function(){
		$(".boardformbtn").click(function(event){
			var result = confirm("게시글을 등록하시겠습니까?");
			if (result){
				var title = $(".boardtitle").val();
				var content = $(".boardcontent").val();
				var file = $("input[name='file']");
				var files = file[0].files;
				var formData = new FormData();
				formData.append("title",title);
				formData.append("content",content);
				for(var i = 0; i<files.length; i++){
					formData.append("uploadFile",files[i])
				}
				$.ajax({
					url:'<c:url value="/BoardForm.do" />',
					data:formData,
					processData: false,
				    contentType: false,
					type:"POST",
					success:function(result){
						console.log(result);
						if (result.msg == "sessionExpired"){
							alert("만료된 세션입니다.");
							location.href='<c:url value="/home.do" />';
						}
						else if (result.msg == "shortTitle"){
							alert("제목을 5글자 이상 써주시길 바라겠습니다.");
							location.reload();
						}
						else if (result.msg == "shortContent"){
							alert("내용을 5글자 이상 써주시길 바라겠습니다.");
							location.reload();
						}
						else if (result.msg == "success"){
							alert("게시글 등록에 성공하셨습니다.");
							location.href='<c:url value="/BoardList.do?page=1" />';
						}
						
					}
				});
			}
			else{
				event.preventDefault();
				location.reload();
			}
		});
	});

</script>
<body>
<div class="boardDetailForm" style="display:flex; flex-direction:column;" >
	<form action="" method="post" enctype="multipart/form-data" >
		<table style="width:900px; margin-top:20px; background-color:#bbdefb; ">
		<tr>
			<td><input style="width:800px; height:3vh; border-color:black; font-size:large; outline:none; border:none;" type="text" name="title" class="boardtitle"placeholder="제목을 입력해주세요."/></td>
		</tr>
		<tr >	 
			<td><textarea style="resize:none; width:800px; height:60vh; outline:none; border:none; font-size:x-large;" name="content" class="boardcontent" rows="20" cols="50" placeholder="내용을 입력해주세요." ></textarea></td>
		</tr>
		<tr>
			<td>
				<div>
					<input type="file" name="file" multiple/>	
				</div>
			</td>
		</tr> 
		</table>
		<!-- <input type="submit"/>  -->
	</form>
	<div style="display:flex; margin-top:30px; align-items:flex-end;">
		<div style="margin-right:30px;">
			<button style="width:100px; border-color:black; cursor:pointer; background-color:white; color:black;" type="submit" class="boardformbtn">등록하기</button>
		</div>
	</div> 
</div>

</body>
</html>