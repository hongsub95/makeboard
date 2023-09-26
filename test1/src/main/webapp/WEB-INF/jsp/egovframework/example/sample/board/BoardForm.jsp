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
/* 	 $(document).ready(function(){
		
		 ClassicEditor
        .create( document.querySelector( '#classic' ),{language:'ko'})
        .catch( error => {
            console.error( error );
        } ); 
		
		
		  
	
	 $(".boardformbtn").click(function(){
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);  
	//스마트 에디터 값을 텍스트컨텐츠로 전달
	var content = document.getElementById("smartEditor").value;
	alert(document.getElementById("txtContent").value); 
			// 값을 불러올 땐 document.get으로 받아오기
	return;
}); 
	 });  */
	 
	 
	 
// summernote editor
$(document).ready(function(){
	
/* 	$('#tiny').tinymce({
        height: 500,
        menubar: false,
        plugins: [
           'a11ychecker','advlist','advcode','advtable','autolink','checklist','export',
           'lists','link','image','charmap','preview','anchor','searchreplace','visualblocks',
           'powerpaste','fullscreen','formatpainter','insertdatetime','media','table','help','wordcount'
        ],
        toolbar: 'undo redo | a11ycheck casechange blocks | bold italic backcolor | alignleft aligncenter alignright alignjustify | bullist numlist checklist outdent indent | removeformat | code table help'
      }); */
     
	
	$('#summernote').summernote({
		  width: "100%",
		  minHeight: 1000,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  						//placeholder 설정
	      toolbar: [
	         // [groupName, [list of button]]
	         ['style', ['style']],
	    	 ['fontname',['fontname']], // 글자 스타일 설정 옵션
             ['fontsize', ['fontsize']], // 글꼴 크기 설정 옵션
             ['font', ['bold', 'underline', 'clear']], // 글자 굵게, 밑줄, 포맷 제거 옵션
             ['color', ['color']], // 글자 색상 설정 옵션
             ['table', ['table']], // 테이블 삽입 옵션
             ['para', ['ul', 'ol', 'paragraph']], // 문단 스타일, 순서 없는 목록, 순서 있는 목록 옵션
             ['height', ['height']], // 에디터 높이 조절 옵션
             ['insert', ['picture','video','link']], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
             ['view', ['codeview',  'help']], // 코드 보기,  도움말 옵션
          ],
          
       
		fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		fontNamesIgnoreCheck:['맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		disableResizeEditor: true,
		disableDragAndDrop: true,
	      
	    popover:{
	    	table: [
	    		  ['add', ['addRowDown', 'addRowUp', 'addColLeft', 'addColRight']],
	    		  ['delete', ['deleteRow', 'deleteCol', 'deleteTable']]
	    		  
	    		],
	        image: [
	    		   ['image', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
	    	       ['float', ['floatLeft','floatCenter','floatRight', 'floatNone']],
	    		   ['remove', ['removeMedia']]
	    		],
	    		
	    	
	      },
	      styleTags: [
	    	        'h1', 'h2', 'h3', 'h4', 'h5', 'h6'
	    		],
	    		
	    callbacks: {
	    	onImageUpload: function(files) {
	        // upload image to server and create imgNode..
	    		for (var i=0; i<files.length; i++){
	   
	    			sendFile(files[i],this);
	    			
	    		}
	    	
	    }
	}
	
});
    
      // 기본글꼴(폰트)
      $("#summernote").summernote("fontName","맑은 고딕");
      
      $(".note-group-select-from-video-files").children("label").text("동영상 파일 선택");
      $(".note-group-select-from-files").children("label").text("사진 파일 선택");
      
      // 이미지 정렬 버튼 클릭 시 
      $("button[aria-label='가운데 정렬']").on("click",function(){
    	  floatCenter();
 	 })
 	 
 	  $("button[aria-label='왼쪽 정렬']").on("click",function(){
    	  floatLeft();
 	 })
 	 
 	  $("button[aria-label='오른쪽 정렬']").on("click",function(){
    	  floatRight();
 	 })
 	
   
/* var imgBtn = "<div class='note-btn-group' >"      
	imgBtn+= "<button id='imageBtn' class='note-btn img-dropdown-toggle'; type='button' onClick='dropdown();'>"
  	imgBtn+= "<i class='fa-regular fa-image'></i>"
  	imgBtn+= "<i class='fa-solid fa-caret-down' style='margin-left:3px;''></i>"
  	imgBtn+= "</button>"
  	imgBtn+= "</div>"
    $(".note-toolbar").prepend(imgBtn); */
    
    
    const videoRandInt = inputIdRandInt(16000000000000,17000000000000) 
	   var videoHtml = "<div style='padding-bottom:20px; class='form-group note-form-group note-group-select-from-files'>";
	   videoHtml += "<label for='note-dialog-video-file' class='note-form-video-label'>동영상 파일 선택</label>";
	   videoHtml += "<input id='note-dialog-video-file' class='note-image-input form-control-file note-form-control note-input' type='file' name='video-files' accept='video/mp4,video/mkv, video/x-m4v,video/*' >";
	   videoHtml += "</div>";
	   
	   $(".note-modal-body").children(".row-fluid").before(videoHtml);
	  
    
    // table 크기에 맞게 고정
    $(".note-dimension-picker-mousecatcher").on("click",function(){
    	var rowCnt = parseInt($(".note-dimension-display").text().split("x")[0]);
		$(".table-bordered").children("tbody").children("tr").children("td").css({"width":(100/rowCnt)+"%","word-break":"break-all","word-wrap":"break-word"});	
		$(".table-bordered").children("tbody").children("tr").children("td").append("<div class='column-resizer' style='display:flex; flex-direction:row;'></div>");
		$(".table-bordered").css({"width":"100%","border-collapse":"collapse"});
		$(".table-bordered").attr("border","1");
	})
	
	
	/* // 마우스 누를때
	$(".note-editable").mousedown(function(e){
		x=e.pageX;
		y=e.pageY;
		console.log(x,y);
	})
	
	// 마우스 뗄때
	$(".note-editable").mouseup(function(e){
		x=e.pageX;
		y=e.pageY;
		console.log(x,y);
	}) */
	$(".summernoteImage").on("click",function(){
		clickImage();
	})
	
	
	
	$("#note-dialog-video-file").on("change",function(e){
		var files = e.target.files
		for (var i=0; i<files.length; i++){
			sendVideo(files[i],this);
		}
		
	});
	
	/* $(".note-group-select-from-file").on("change",function(e){
		console.log(e.target.files);
		var files = e.target.files
		for (var i=0; i<files.length; i++){
			sendFile(files[i],this);
		}
		
	}) */
			
 	
	
});
	 var isChanged = false; 
		
		$(window).bind('beforeunload', function(){
			
				if ($("#summernoteImage").val() != null || $("#summernoteVideo").val() != null){
					
					var boardId = $("#boardId").val();
				    //페이지 변경이 있었는지 체크..
				    var isChanged = true; 
				 
				    //출력할 내용을 Return 해주면 확인 창이 뜨게 됩니다.
				    	$.ajax({
				        	url:'<c:url value="/goOutBoard.do"/>',
				        	data:{
				        		"board_id":boardId
				        	},
				        	type:"post",
				      		success:function(result){
				      			alert("저장x");
				      		},
				        	error:function(result){
				        		alert("실패");
				        	}
				        	
				        });
				    //확인 창을 띄우지 않으려면 아무 내용도 Return 하지 마세요!! (Null조차도)
				}
			});
	
	floatCenter = function(){
		$(".note-float-center").attr("style","margin:auto; display:block")
		$(".note-float-center").parent("figure").attr("style","width:100%; margin-bottom:3px;");
	}
	
	floatLeft = function(){
		
		$(".note-float-left").parent("figure").attr("style","width:100%; margin-bottom:3px;overflow:hidden;");
	}
	
	floatRight = function(){
		
		$(".note-float-right").parent("figure").attr("style","width:100%; margin-bottom:3px; overflow:hidden;");
	}
	
	 
	function inputIdRandInt(min,max){
		var randNum = Math.floor(Math.random()*(max-min+1)) + min;
	    return randNum;
	}
	
	var filedict = {} 
	function sendVideo(file,el) {
		var form_data = new FormData();
		var board_id = $("#boardId").val();
		form_data.append("uploadFile",file);
		form_data.append("board_id",board_id);
		form_data.append("type","video");
		$.ajax({
			data: form_data,
			url:'<c:url value="/BoardFile.do" />',
			type : "post",
			cache :false,
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(result) {
				var file = result.file;
				var boardId = result.board_id;
				var file_name = result.file_name;
				var file_id = result.file_id;
				$("#frm").append("<input type='hidden' id='boardId' value="+boardId+"></input>");
				var video = "<figure><iframe id='summernoteVideo' src="+file+" style='display:block; margin:auto; width:600px; height:600px;'></iframe></figure>";
				filedict[file_id]=1;
				
				$('.note-editable').append(video);
				$(".note-modal").hide();
				$(".note-modal-backdrop").hide();
				$("input[name=video-files]").val('');
			}
		});
	} 
	function sendFile(file,el) {
		var form_data = new FormData();
		var board_id = $("#boardId").val();
		form_data.append("uploadFile",file)
		form_data.append("board_id",board_id)
		form_data.append("type","img")
		console.log("board_id: ",board_id);
		$.ajax({
			data: form_data,
			url:'<c:url value="/BoardFile.do" />',
			type : "post",
			cache :false,
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(result) {
				console.log(result);
				var file = result.file;
				var boardId = result.board_id;
				var file_name = result.file_name;
				var file_id = result.file_id;
				filedict[file_id]=1;
				console.log(boardId);
				if (board_id == null){
					$("#boardId").val(boardId);
				}
				var img = "<figure id='summernoteFigure' style=' overflow:hidden; '> <input type='hidden' id='iptImg'><img id='summernoteImage' style='margin:auto; display:block;' src="+file+" ></img></input></figure>"; 
				$(".note-editable").append(img);
				$("#iptImg").focus();
				
			}
		});
	}
	
	function fileListfn(file_name){
		var file_id;
		if (file_name == ''){
			return fileList;
		}
		$.ajax({
			url:'<c:url value="/selectFileId.do" />',
			data:{
				"savedName":file_name
			},
			type:"get",
			async:false,
			success:function(result){
				file_id = result.file_id;
			}
		});
		return parseInt(file_id,10);
	}
	
	boardformbtn = function(){
			$(window).unbind('beforeunload'); 
			var realFileList = [];
			var title = $(".boardtitle").val();
			var content = $('.note-editable').html();
			
			// 내용에서 모든 미디어 파일을 가져옴
			$(".note-editable").find("img").each(function(){
				var file_name = $(this).attr('src').replace("/staticfile/","").trim();
				realFileList.push(fileListfn(file_name));
			});
			$(".note-editable").find("iframe").each(function(){
				var file_name = $(this).attr('src').replace("/staticfile/","").trim();
				realFileList.push(fileListfn(file_name));
			});
			

			/* realFileList.forEach(function(i){
				
				if (filedict[i] == 1){
					delete filedict[i];
				}
			});
			var fileList =[];
			for (var [key, value] of Object.entries(filedict)){
				fileList.push(parseInt(key));
			} */
	
			data = {
					"title":title,
					"content":content
					/* "newFileList":JSON.stringify(fileList) */
			}
			
			$.ajax({
				url:'<c:url value="/BoardForm.do" />',
				data:data,
				type:"POST",
				success:function(result){
					console.log(result);
					if (result.msg == "sessionExpired"){
						alert("만료된 세션입니다.");
						location.href='<c:url value="/home.do" />';
					}
					
					else if (result.msg == "success"){
						alert("게시글 등록에 성공하셨습니다.");
						location.href='<c:url value="/BoardList.do?page=1" />';
					}
					
				},
			error:function(request,status,error){
	      		$console.log($(window));
	      		console.log(request,status,error);
			}
			});
		
	} 
	
	/* dropdown = function(){
		var dropdowns = "<div class='note-dropdown-menu note-check dropdown-fontname'> ";
		dropdowns = "<a class='note-dropdown-item' href='#' data-value='사진'></a>";
		dropdowns="</div>";
		$(".note-btn-group").append(dropdowns);
	} */
	

</script>
<body>
<div class="boardDetailForm" style="display:flex; flex-direction:column;" >
	<input type='hidden' id='boardId'></input>
	<form action="" method="post" id="frm" name="frm" enctype="multipart/form-data" >
		<table style="width:900px; margin-top:20px; background-color:white; ">
		<tr>
			<td><input style="width:800px; height:3vh; border-color:black; font-size:large; outline:none; border:none;" type="text" name="title" class="boardtitle"placeholder="제목을 입력해주세요."/></td>
		</tr>
		 <tr>
		  <td><textarea  id="summernote" name="editordata"></textarea></td>
		</tr>
		<!-- <tr>
		<td><textarea id="tiny" name="tiny"></textarea></td>
		</tr> -->
		<!-- <tr>
			<td><textarea style="resize:none; width:800px; height:60vh; outline:none; border:none; font-size:x-large;" name="content" class="boardcontent" rows="20" cols="50" placeholder="내용을 입력해주세요." ></textarea></td>
		</tr> -->
		 <!-- <tr>
			<td>
				<textarea id="classic"></textarea>
	        
			</td>
		</tr> -->	
			
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
			<button style="width:100px; border-color:black; cursor:pointer; background-color:white; color:black;" type="button" class="boardformbtn" onClick="boardformbtn();">등록하기</button>
		</div>
	</div> 
</div>

</body>
</html>