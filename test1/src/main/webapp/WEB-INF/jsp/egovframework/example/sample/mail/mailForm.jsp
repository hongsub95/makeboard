<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/common.jsp" %>
<!DOCTYPE html>

<html>
<head>
	<style>
		.mailTb{
			display:flex;
			justify-content:center;
			border-collapse: collapse;
   			border: 1px solid #EDEDED;
			
		}
		
		.mt20{
			margin-top:20px;
		}
		
		tr{
			border:1px solid black;
		}
		
		th{
		background: #EDF0F4;
	    border: 1px solid #ddd;
	    text-align: center;
	    height: 45px;
	    text-transform: uppercase;
	    font-weight: 500;
	    font-size: 13px;
	    letter-spacing: -0.02em;
	    color: #5E6C84;
	    padding: 7px 25px;
		}
		td{
		  border: 1px solid #ddd;
		  text-align: center;
		  padding: 7px 25px;
		  height: 45px;
		  font-weight: 350;
		  font-size: 13px;
		  letter-spacing: -0.02em;
		  color: #495568;
		  background: #fff;
		
		}
		
		.t_left{
		
			text-align:left;
		
		}
		
		td .toAddress{
			height:100%;
			display:flex;
		}
		
		td .ccAddress{
			height:100%;
			display:flex;
		}
		
		td .bccAddress{
			height:100%;
			display:flex;
		}
		
		td div #toAddressList{
		height:100%;
		font-size:14px;
		
		}
		
		td div #ccAddressList{
		height:100%;
		font-size:14px;
		}
		
		td #titleTxt{
		height:100%;
		font-size:16px;
		
		}
		
		td div #bccAddressList{
			height:100%;
			font-size:14px;
		
		}
		
		.ypurple--btn{
			padding: 0px 24px;
		    height: 39px;
		    background: #535B76;
		    border-radius: 5px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    font-weight: 400;
		    font-size: 14px;
		    text-align: center;
		    letter-spacing: -0.03em;
		    text-transform: uppercase;
		    color: #fff;
		}
		
		input[type='file']{
			position: absolute;
		    width: 1px!important;
		    height: 1px!important;
		    padding: 0;
		    margin: -1px;
		    overflow: hidden;
		    clip: rect(0, 0, 0, 0);
		    border: 0 none;
		
		}
		
		input[type='text']{
		border:none;
		}
		.mailTb tbody tr td div input[type='text']{
		border:none;
		outline: 0;
		  border-width: 0 0 2px;
		}
		
		.mailTb tbody tr td div input[type='text']:focus {
		  border-bottom:2px solid green;
		}
		
		div[id='mailNameBox']{
		    margin: 5px 0 0 10px;
		    display: flex;
		    height: 90%;
		    justify-content: center;
		    align-items: center;
		    background: #4DA7BC;
		    padding: 0px 5px 0px 5px;
		    border-radius: 0.8rem;
		    margin-right:10px;
		    width:200px;
		}
		
		button[id='mailDeleteBtn']{
			margin-left: 8px;
		    color: white;
		    font-size: 10px;
		    border: none;
		    background: #4DA7BC;
		}
		
		.d--flex{
			display:flex;
		}
	
	</style>
<script type="text/javascript">
	var fileSize = 50 * 1024 * 1024;
	var uploadSn = 10000000000;
	var mailSn = 0;
	var possibleExten = ["jpg", "jpeg", "png", "gif", "hwp", "xlsx", "xls", "pdf", "pptx", "ppt", "doc", "txt", "zip", "hwpx", "docx"]
	const dataTransfer = new DataTransfer();
	var toAddList = [];
	var ccAddList = [];
	var bccAddList = [];
	$(document).ready(function() {
		$("#btnWrite").on("click",function(){
			fnSave();
		})
		
		var fontList = ['맑은 고딕','궁서','바탕','굴림', '돋움', "Arial"];
		
		$('#summernote').summernote({
			  width: "100%",
			  minHeight: 700,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  lang: "ko-KR",					// 한글 설정
			  fontNames:fontList,
			  fontNamesIgnoreCheck: [],
		      toolbar: [
		         // [groupName, [list of button]]
		    	 ['fontname',['fontname']], // 글자 스타일 설정 옵션
	             ['fontsize', ['fontsize']], // 글꼴 크기 설정 옵션
	             ['font', ['bold', 'underline', 'clear']], // 글자 굵게, 밑줄, 포맷 제거 옵션
	             ['color', ['color']], // 글자 색상 설정 옵션
	             ['para', ['ul', 'ol', 'paragraph']], // 문단 스타일, 순서 없는 목록, 순서 있는 목록 옵션
	             ['table', ['table']], // 테이블 삽입 옵션
	             ['height', ['height']], // 에디터 높이 조절 옵션
	             ['insert', ['picture'/* ,'video','link' */]], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
	             ['view', ['codeview']], // 코드 보기,  도움말 옵션
	          ],
	          
			fontSizes: ['8','9','10','11','12','13','14','16','18','20','22','24','28','30','36','50','72'],
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
			    		   ['remove', ['imgModify','removeMedia']]
		    		],
		      },
		      
		     
		    		
		    callbacks: {
		    	onImageUpload: function(files) {
			        // upload image to server and create imgNode..
			    		for (var i=0; i<files.length; i++){
			   
			    			sendFile(files[i],this);
			    			
			    		}
			    	
			    },
		    	
			    onPaste: function (e) {
			    	var bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('text/html');
			    	if (bufferText == ''){
			    		bufferText = ((e.originalEvent || e).clipboardData || window.clipboardData).getData('text');
			    		
			    		$("#summernote").summernote("code",bufferText);
			    	}
			    	
			    	var $html = $($.parseHTML(bufferText));
			    	$html.find("*").addBack().each(function(idx,val){
			    		var $item = $(val);
			    		
			    		if ($item[0].localName == 'b'){
			    			$item.removeAttr("style");
			    		}
			    		
			    		else if ($item[0].localName == 'p'){
			    			if($item[0].innerHTML == "&nbsp;"){
			    				$item[0].innerHTML = "<br>";
			    			}
			    		}
			    		else if ($item[0].localName == 'img'){
			    			var imgStyle= $($item[0]).attr("style");
			    			$($item[0]).attr("style","display:block; margin:auto;"+imgStyle);
			    			$($item[0]).attr("class","summernoteUrlImage");
			    		}
			    		
			    		/* else if ($item[0].localName == 'span'){
			    			$item.removeAttr("style");
			    			$item.attr("style","font-size:18px; font-family:맑은 고딕;");
			    		} */
			    	});
			    	e.preventDefault();
			    	
			    	var pasteText ="";
			    	for(var i = 0; i<$html.length;i++){
			    		var markupText = $html[i].outerHTML;
			    		
			    		if($html[i].nodeValue != null){
			    			if ($html[i].nodeValue == "StartFragment" || $html[i].nodeValue == "EndFragment"){
			    				continue
			    			}
			    			else{
			    				pasteText +=$html[i].nodeValue
			    			}
			    		}
			    		else if (markupText == null ){
			    			continue
			    		}
			    		else{
			    			pasteText+=markupText;
			    		}
			    	}
			    	$("#summernote").summernote("pasteHTML",pasteText);
		        },
		        onChangeCodeview : function(e){
		        	var $html = $($.parseHTML(e));
			    	$html.find("*").addBack().each(function(idx,val){
			    		var $item = $(val);
			    		
			    		if ($item[0].localName == 'b'){
			    			$item.removeAttr("style");
			    		}
			    		
			    		else if ($item[0].localName == 'p'){
			    			if($item[0].innerHTML == "&nbsp;"){
			    				$item[0].innerHTML = "<br>";
			    			}
			    		}
			    		/* else if ($item[0].localName == 'span'){
			    			$item.removeAttr("style");
			    			$item.attr("style","font-size:18px; font-family:맑은 고딕;");
			    		} */
			    	});
			    	
			    	var pasteText ="";
			    	for(var i = 0; i<$html.length;i++){
			    		var markupText = $html[i].outerHTML;
			    		if (markupText == null ){
			    			continue
			    		}
			    		else{
			    			pasteText+=markupText;
			    		}
			    	}
			    	
			    	$('#summernote').summernote('code',pasteText);
		        },
		        
		        onImageLinkInsert: function(url) {
		        	var imgtitle = $(".img-title-form").val();
			    	var imgalt = $(".img-alt-form").val();
		            $("#summernote").summernote('editor.insertImage',url,function($image){
		            	$image.css({"margin":"auto","display":"block","padding-bottom":"5px"});
						$image.attr("class","summernoteUrlImage");
						$image.attr("alt",imgalt);
						$image.attr("title",imgtitle);
		            });
		            $(".img-title-form").val('');
		            $(".img-alt-form").val('');
		          }
	    }
		  
	});
	
		$(".note-group-image-url").hide();
		
		$(".note-editable").css("text-align","left");
		
		// 폰트 기본단위()
		$('#summernote').summernote('fontName', '맑은 고딕');
		
		$('#summernote').summernote('fontSize', 13);
		
		$('#summernote').summernote('fontSizeUnit', 'px');
		
		$("input[type='checkbox']").attr('checked',false);
		
		$("button[aria-label='가운데 정렬']").on("click",function(){
	    	floatCenter();
	 })
	 	 
	 	$("button[aria-label='왼쪽 정렬']").on("click",function(){
	    	floatLeft();
	 })
	 	 
	 	$("button[aria-label='오른쪽 정렬']").on("click",function(){
	    	floatRight();
	 })
		
		$("#toAddressList, #ccAddressList, #bccAddressList").on("keyup",function(key){
			if(key.keyCode == 13){
				var inputId = $(this).attr("id");
				insertMailHtml($(this).val(),mailSn,inputId);
				$(this).val('');
			}
		})
		
	const fileUpload = document.getElementById("file01");
		
		fileUpload.addEventListener('change', function () {
			var files = fileUpload.files
			var fileCnt = $("#cnt").val();
			for (var i=0;i<files.length;i++){
				const selectedFile = fileUpload.files[i];
				$("#size").val(parseInt($("#size").val())+parseInt(selectedFile.size ));
				
				if (fileCnt > 4){
					alert("첨부파일은 최대 5개까지 등록할 수 있습니다.");
					return false;
				}
				
				else if (parseInt($("#size").val()) > fileSize){
					$("#size").val(parseInt($("#size").val())-parseInt(selectedFile.size ));
					alert("첨부 파일 용량이 50MB를 초과하여 업로드 할 수 없습니다.");
					return false;
				}
				else if (!(possibleExten.includes(selectedFile.name.split(".")[selectedFile.name.split(".").length - 1].toLowerCase()))){
					alert("가능한 확장자가 아닙니다.");
					return false;
				}
				else{
					insertUploadHtml(selectedFile.name,uploadSn,selectedFile.size);
					dataTransfer.items.add(files[i]);
					$("#cnt").val(parseInt($("#cnt").val())+1);
					uploadSn+=1;
				}
				
			}
			fileUpload.files=dataTransfer.files;
		});
	})
	
	insertMailHtml =function(name,sn,id){
		var mailHtml = "<div id='mailNameBox' class='mailNameBox_"+sn+"'>";
		mailHtml+="<span id='mailNameSpan_"+sn+"' style='font-weight:bold;color:white;'>";
		mailHtml+= "<input type='hidden' value="+name+" class='mailNameInput_"+sn+"' />";
		mailHtml+=name;
		mailHtml+="</span>";
		mailHtml+="<button type='button' id='mailDeleteBtn' onClick='fnmailDeleteBtn("+sn+","+id+");'>✖</button>";
		mailHtml+="</div>";
		if(id == "toAddressList"){
			$(".toAddressBox").append(mailHtml);
			toAddList.push(name)
		}
		else if (id == "ccAddressList"){
			$(".ccAddressBox").append(mailHtml);
			ccAddList.push(name)
		}
		else{
			$(".bccAddressBox").append(mailHtml);
			bccAddList.push(name)
		}
		mailSn+=1;
		}
	
	fnmailDeleteBtn = function(sn,id){
		var inputId = $(id).attr("id");
		if (inputId == "toAddressList"){	
			for(var i = 0; i < toAddList.length;i++){
				if(toAddList[i] === $(".mailNameInput_"+sn+"").val())  {
					toAddList.splice(i, 1);
				    i--;
				    break
				}
			}
		}
		else if (inputId == "ccAddressList"){
			for(var i = 0; i < ccAddList.length;i++){
				if(ccAddList[i] === $(".mailNameInput_"+sn+"").val())  {
					ccAddList.splice(i, 1);
				    i--;
				    break
				}
			}
		}
		else{
			for(var i = 0; i < bccAddList.length;i++){
				if(bccAddList[i] === $(".mailNameInput_"+sn+"").val())  {
					bccAddList.splice(i, 1);
				    i--;
				    break
				}
			}
		}
		
		$(".mailNameBox_"+sn+"").remove()	
	}
	
	insertUploadHtml =function(name,sn,file_size){
		var uploadHtml = "<div style='margin:5px 0 0 10px;' id='uploadNameBox' class='uploadNameBox_"+sn+"'>";
		uploadHtml+="<span id='uploadNameSpan_"+sn+"' style='font-weight:bold;color:#868686;'>";
		uploadHtml+= "<input type='hidden' value="+file_size+" class='uploadNameInput_"+sn+"' />";
		uploadHtml+=name;
		uploadHtml+="</span>";
		uploadHtml+="<button style='margin-left:8px;color:#564b4b;font-size:14px; border:none;' type='button' id='uploaddeleteBtn' onClick='uploadDeleteBtn("+sn+");'>✖</button>";
		uploadHtml+="</div>";
		$("#uploadBox").append(uploadHtml);	
		}
	
	function fnSave(){
		var form_data = new FormData();
		if(toAddList.length == 0 ){
			alert("최소 한명이상의 받는 사람의 주소를 적어주세요.");
			return false;
		}
		var toAddressList = toAddList.join(";");
		if(ccAddList.length > 0){
			var ccAddressList = ccAddList.join(";");
			form_data.append("ccAddressList",ccAddressList);
		}
		
		if(bccAddList.length > 0){
			var bccAddressList = bccAddList.join(";");	
			form_data.append("bccAddressList",bccAddressList);
		}
		if (dataTransfer.files.length > 0){
			for(var i = 0 ; i<dataTransfer.files.length; i++){
				form_data.append("attchFileList1",dataTransfer.files[i]);
			}
		}
		
		var contentTxt = $('.mailFormContent').html()
		var cleanedHtml = contentTxt.replace(/\uFEFF/g, '');
		$(".mailFormContent").html(cleanedHtml);
		var title = $("#titleTxt").val();
		var content = $('.mailFormContent').html();
		form_data.append("toAddressList",toAddressList);
		form_data.append("title",title);
		form_data.append("content",content);
		$.ajax({
			url:"<c:url value='/mailform.do' />",
			data:form_data,
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			type:"POST",
			success:function(result){
				if(result.msg == 'success'){
					alert("메일 테스트 작성 성공");
				}
				else{
					alert("메일 테스트 작성 실패");
				}
			},
			error : function(){
            	alert("ajax 실행 실패");
        	}
		})
	}
	uploadDeleteBtn = function(uploadSn){
		
		if (dataTransfer.files.length>=1){
			for(var i = 0; i < dataTransfer.files.length; i++) {
				  if(dataTransfer.files[i].name === $("#uploadNameSpan_"+uploadSn+"").text())  {
					$("#size").val($("#size").val()-parseInt(dataTransfer.files[i].size));
				    dataTransfer.items.remove(i);
				    i--;
				    break
				  }
				}
		}
		else{
			var fileKeyList = Object.keys(fileTempDict);
			for (var i = 0; i<fileKeyList.length; i++){
				if(fileKeyList[i] === $(".uploadNameBox_"+uploadSn+"").text()){
					$("#size").val($("#size").val()-parseInt(fileTempDict[fileKeyList[i]]));
				}
			}
			
		}
		$(".uploadNameBox_"+uploadSn+"").remove();
		
		if (uploadSn < 1000000000){
			$("#pressFrm").append("<input type='hidden' id=fileDelete"+fileIdx+" name=fileDelete"+fileIdx+" value="+uploadSn+">");
			fileIdx+=1;
		};
		$("#cnt").val(parseInt($("#cnt").val())-1)
		
	}
	
	// summernote (가운데 정렬)
	function floatCenter(){
		$(".note-float-center").attr("style","margin:auto; display:block")
		$(".note-float-center").parent("figure").attr("style","width:100%; margin-bottom:3px;");
	}
	
	// summernote (왼쪽 정렬)
	function floatLeft(){
		$(".note-float-left").parent("figure").attr("style","width:100%; margin-bottom:3px;overflow:hidden;");
	}
	
	// summernote (오른쪽 정렬)
	function floatRight(){
		$(".note-float-right").parent("figure").attr("style","width:100%; margin-bottom:3px; overflow:hidden;");
	}
	
	

</script>
<meta charset="UTF-8">
<title>메일테스트</title>
</head>
<body>
<div>
	<div class="mailTb">
		<table class="mt20" style="width:100%">
			<colgroup>
				<col width="200px">
				<col>
				<col width="200px">
				<col>
			</colgroup>
			<tbody>
			<tr>
				<th class="t_left">받는 사람</th>
				<td class="t_left" colspan="3">
					<div class="toAddress">
					<div class="toAddressBox d--flex"></div>
						<input type="text" id="toAddressList" style="width: 100%;"/>
					</div>
				</td>
			</tr>
			<tr>
				<th class="t_left">참조</th>
				<td class="t_left" colspan="3">
					<div class="ccAddress">
						<div class="ccAddressBox d--flex"></div>
						<input type="text" id="ccAddressList" style="width: 100%;"/>
					</div>
				</td>
			</tr>
			<tr>
				<th class="t_left">숨은 참조</th>
				<td class="t_left" colspan="3">
					<div class="bccAddress d--flex">
						<div class="bccAddressBox d--flex"></div>
						<input type="text" id="bccAddressList" style="width: 100%;"/>
					</div>
				</td>
			</tr>
			<tr>
				<th class="t_left">제목</th>
				<td class="t_left" colspan="3">
					<input type="text" id="titleTxt" style="width: 100%;"/>
				</td>
			</tr>
			<tr>
				<th class="t_left">첨부파일</th>
				<td class="t_left" colspan="3">
					<div class="df--table table--vert--lock touch--swipe text-left" id="uploadBox">
						<div class="form--group d--flex form--responsive">
							<input type="file" id="file01" multiple/>
							<label for="file01" style="max-width:110px; cursor:pointer;" class="ypurple--btn ml10 form--responsive--mt0">파일첨부</label>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th class="t_left">내용</th>
				<td class="t_left" colspan="3">
					<div class="mailFormContent">
						<div style="margin:10px 0px 10px 0px">
							<div>
								<div>
									<img src="http://localhost:8080/images/egovframework/staticfile/softsignal_logo.png" style="background:black;">
								</div>
								<div>
									 <span style="font-size:30px; font-weight:bold;">정기점검 방문 일정 확인 안내</span>
								</div>
								<div>
									<span>10월 ComVoy 정기점검</span>
								</div>
								<div>
									<span>안녕하세요. 지인소프트 신홍섭입니다.<br>10월 컴보이 정기점검 일정 회신 부탁 드립니다.</span>
								</div>
							</div>
							<div style="margin:10px 0px 10px 0px">
								<i style="font-size:23px; font-family:'Noto Sans KR'; font-weight:500;">■ 유지보수 대상</i>
								<div>
									maintain
								</div>
							</div>
							<div style="margin:10px 0px 10px 0px">
								<i style="font-size:23px; font-family:'Noto Sans KR'; font-weight:500;">■ 방문예정 엔지니어 정보</i>
								<div>
									engineer
								</div>
							</div>
							<div style="margin:10px 0px 10px 0px">
								<i style="font-size:23px; font-family:'Noto Sans KR'; font-weight:500;">■ 정기점검 일정</i>
								<div>
									schedule
								</div>
							</div>		
							<div style="margin:10px 0px 10px 0px">
								<i style="font-size:23px; font-family:'Noto Sans KR'; font-weight:500;">■ 담당자 정보</i>
								<div>
								manager
									<!-- <table>
										<tbody>
											<tr>
												<th>
													소속
												</th>
												<td>
													<input type="text" />
												</td>
												<th>
													성명
												</th>
												<td>
													<input type="text"/>
												</td>
											</tr>
											<tr>
												<th>
													전자메일
												</th>
												<td>
													<input type="text"/>
												</td>
												<th>
													전화번호
												</th>
												<td>
													<input type="text"/>
												</td>
											</tr>
											<tr>
												<th >
													요청사항
												</th>
												<td colspan="3">
													<textarea></textarea>
												</td>
											</tr>										
										</tbody>
										
									
									</table> -->
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
	</div>
	<div class="find-btn" style="text-align: center; margin-top: 10px;">
		<button type="button" id="btnWrite" class="blue--bg--btn" style="display :inline-block; width: 100px;">전송</button>
		<button	type="button" id="btnList" class="blue--bg--btn" style="display :inline-block; width: 100px;">목록</button>
	</div>
</div>

<div class="mailTemplateHead" style="display:none">
	<%@ include file="mailTemplate.jsp" %>
</div>
</body>

<script>

$.summernote.dom.walkPoint = (function (_super) {
    return function () {
        var startPoint = arguments[0]
        var endPoint = arguments[1]
        var handler = arguments[2]
        var isSkipInnerOffset = arguments[3]
        let point = startPoint;

        while (point) {
            handler(point);

            if ($.summernote.dom.isSamePoint(point, endPoint)) {
                break;
            }
            const isSkipOffset = isSkipInnerOffset &&
                startPoint.node !== point.node &&
                endPoint.node !== point.node;
            point = $.summernote.dom.nextPoint(point, isSkipOffset);
        }
    };

})($.summernote.dom.walkPoint);

</script>
</html>

