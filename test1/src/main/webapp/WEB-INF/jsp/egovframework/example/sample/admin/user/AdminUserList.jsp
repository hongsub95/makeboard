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
		
		userListajax();
		console.log("${se}")
		
		$("#orderByselect").change(function(){
			var selected = $("#orderByselect").val();
			
			if (selected == "created"){
				userListajax();
			}
			else if (selected == "grade"){
				userListajaxBygrade();
			}
		});
		
		
		
	});
	
	userListajax = function(){
		$.ajax({
			url:'<c:url value="/AdminUserListdata.do"/>',
			data:{"page":"1"},
			type:"GET",
			success:function(result){
				$(".user_list_tbody").empty();
				$(".page_btn").empty();
				var userlist = result.userlist;
				var pages = result.pages;
				for (var i=0; i<userlist.length;i++){
					$(".user_list_tbody").append(userList(userlist[i],pages,i));
				}
				$(".page_btn").append(userListbtn(pages));
			}
		});
	}
	
	userListajaxBygrade = function(){
		$.ajax({
			url:'<c:url value="/AdminUserListdataBygrade.do"/>',
			data:{"page":"1"},
			type:"get",
			success:function(result){
				$(".user_list_tbody").empty();
				$(".page_btn").empty();
				var userlist = result.userlist;
				var pages = result.pages;
				for (var i=0; i<userlist.length;i++){
					$(".user_list_tbody").append(userList(userlist[i],pages,i))
				}	
				$(".page_btn").append(userListbtnBygrade(pages));
			}
		});
	}
	
	
	userList = function(user,pages,i){
		var gradeAuthroization = $("#sessionGrade").val();
		var userlist ="";
		userlist +="<tr>";
		userlist +="<td>"+(pages.total- ((pages.nowPage -1) * pages.perPage)-i)+"</td>";
		userlist += "<td><a href='BoardDetail.do?id="+user.user_id+"'>";
		userlist += user.email;
		userlist += "</a></td>";
		userlist +="<td>";
		userlist += user.name;
		userlist +="</td>";
		userlist +="<td>";
		userlist += timestampTodate(user.created);
		userlist +="</td>";
		userlist +="<td>"+user.loginMethod+"</td>";
		userlist +="<td>";
		if (user.grade == 3){
			userlist += "마스터";	
		}
		else if (user.grade == 2){
			userlist += "운영자";	
		}
		else if (user.grade == 1){
			userlist += "스태프";	
		}
		else if (user.grade == 0){
			userlist += "일반";	
		}
		userlist +="</td>"
		userlist +="<td>";
		if (gradeAuthroization > 1){
			userlist += "<button type='button' onClick='UserManageBtn("+user.user_id+","+user.grade+");' >관리</button>"
		}
		userlist +="</td>";
		userlist += "</tr>";
		
		return userlist;
	}
	
	userListbtn = function(pages){
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
	
	userListbtnBygrade = function(pages){
		var btn = "";
		
		if (pages.existPrePage){
			btn += "<a style='font-size:large; cursor:pointer;' onClick='nextOrPrePageGradeBtn("+(pages.nowPage-1)+")'>Previous</a>";
			
		}
		for(var i = pages.startPage; i<=pages.endPage; i++){
			btn+="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrePageGradeBtn("+i+")'>"+i+"</a>";
		}
		if (pages.existNextPage){
			btn +="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrePageGradeBtn("+(pages.nowPage+1)+")'>Next</a>";
			
		}
		return btn
		
	
	}
	
	
	nextOrPrePageBtn = function(page){
		$.ajax({
			url:'<c:url value="/AdminUserListdata.do"/>',
			data:{"page":page},
			type:"get",
			success:function(result){
				$(".user_list_tbody").empty();
				$(".page_btn").empty();
				var userlist = result.userlist;
				var pages = result.pages;
				for (var i=0; i<userlist.length;i++){
					$(".user_list_tbody").append(userList(userlist[i],pages,i))
				}	
				$(".page_btn").append(userListbtnBygrade(pages));
			}
		});
	}
	
	nextOrPrePageGradeBtn = function(page){
		$.ajax({
			url:'<c:url value="/AdminUserListdataBygrade.do"/>',
			data:{"page":"1"},
			type:"get",
			success:function(result){
				$(".user_list_tbody").empty();
				$(".page_btn").empty();
				var userlist = result.userlist;
				var pages = result.pages;
				for (var i=0; i<userlist.length;i++){
					$(".user_list_tbody").append(userList(userlist[i],pages,i))
				}	
				$(".page_btn").append(userListbtnBygrade(pages));
			}
		});
	}
	
	
	UserManageBtn = function(user_id,grade){
		var gradeAuthroization = $("#sessionGrade").val();

		var manageboxpage ="<div id='manageBox' style='position:fixed; top:5%; width:100%; height:100%; background-color:rgba( 255, 255, 255, 0.5 ); z-index:1;'>" 
		manageboxpage+="<div style='position:absolute; right:35%; top:8%; background-color:white; width:800px; height:600px; border:2px solid; z-index:2;'>";
		manageboxpage+="<div style='display:flex; flex-direction:column; justify-content:center; align-items:center;'>";
		manageboxpage+="<div style='margin-top:30px;'>";
		manageboxpage+="<label><input type='checkbox' name='checkedValue' value='a' />욕설 및 비하적인 단어 자주 사용</label>";
		manageboxpage+="</div>";
		manageboxpage+="<div style='margin-top:30px;'>";
		manageboxpage+="<label><input type='checkbox' name='checkedValue' value='b' />패드립</label>";
		manageboxpage+="</div>";
		manageboxpage+="<div style='margin-top:30px;'>";
		manageboxpage+="<label><input type='checkbox' name='checkedValue' value='c' />도배 및 홍보성 게시글 자주 올림</label>";
		manageboxpage+="</div>";
		manageboxpage+="<div style='margin-top:30px;'>";
		manageboxpage+="<label><input type='checkbox' name='checkedValue' value='d' />다른 사용자에게 불쾌감을 자주 줌</label>";
		manageboxpage+="</div>";
		manageboxpage+="<div style='margin-top:30px;'>";
		manageboxpage+="<label><input type='checkbox' name='checkedValue' value='e' />다른 사용자로 부터 신고 다수</label>";
		manageboxpage+="</div>";
		manageboxpage+="<div style='margin-top:30px;'>";
		manageboxpage+="<label><input type='checkbox' name='checkedValue' value='f' />내 마음</label>";
		manageboxpage+="</div>";
		manageboxpage+="<div style='margin-top:30px;'>";
		manageboxpage+="<textarea style='resize:none; outline:none; ' rows='10' cols='40' name='checkedValue' value='기타' placeholder='기타'></textarea>";
		manageboxpage+="</div>";
		manageboxpage+="<div style='margin-top:30px'>";
		manageboxpage+="</div >";
		manageboxpage+="<div style='display:flex;'>";
		manageboxpage+="<button type='button' style='margin-right:25px;' onClick='cancelBtn();'>취소</button>";
		manageboxpage+="<button type='button' style='margin-right:25px;'  onClick='submitBtn("+user_id+","+grade+");'>추방</button>";
		if (gradeAuthroization == 3){
			
			manageboxpage+="<button type='button' onClick='gradebtn("+user_id+","+grade+");'>등급 조정</button>";
			manageboxpage +="<div style='margin-left:25px;'>";
			manageboxpage +="<div>";
			manageboxpage +="<select id='gradeselect'>";
			manageboxpage +="<option id='gradeoption0' value='0' label='일반'></option>";
			manageboxpage +="<option id='gradeoption1' value='1'label='스태프'></option>";
			manageboxpage +="<option id='gradeoption2' value='2' label='운영자'></option>";
			manageboxpage +="</select>";
			manageboxpage +="</div>";
			manageboxpage +="</div>";
		}
		manageboxpage+="</div >";
		manageboxpage+="</div >";
		manageboxpage+="</div>";
		manageboxpage+="</div>";
		$(".user_list").append(manageboxpage);
			
		
		
	}
	
	gradebtn = function(user_id,grade){
		var gradeAuthroization = $("#sessionGrade").val();
		var userId = $("#sessionUserid").val();
		var selectVal = $("#gradeselect").val();
		
		if (selectVal == grade){
			alert("이전 등급과 같은 등급입니다.");
			return false;
		}
		else{
			$.ajax({
				url:'<c:url value="/AdminGradeUpdate.do"/>',
				data:{
					"user_id1":userId,
					"user_id2":user_id,
					"grade1":grade,
					"grade2":selectVal
				},
				type:"POST",
				success:function(result){
					var gradeName = gradeNamefunc(result.grade1);
					var gradeName2 = gradeNamefunc(result.grade2);
					
					alert(result.name + "님을 "+gradeName+"에서 "+gradeName2+"로 등급 변경하였습니다.");
					location.reload();
				}
			});
			
		}
		
		
	}
	
	cancelBtn = function(){
		$("#manageBox").remove();
		$("#Admingradelog").remove();
		
	}
	
	submitBtn = function(user_id,grade){
		var gradeAuthroization = $("#sessionGrade").val();
		var userId = $("#sessionUserid").val();
		var checkList = [];
		if ($("textarea[name='checkedValue']").val() != ''){
			checkList.push($("textarea[name='checkedValue']").val());
		}
		 $("input[name='checkedValue']").each(function (index){
			if ($(this).is(":checked")==true){
				checkList.push($(this).val());
			}
			
			})
		var checkStr = checkList.join(",");
		if (user_id == userId){
			alert("자기자신을 추방할 수 없습니다.");
			return false;
		}
		else if (grade >= gradeAuthroization){
			alert("자신보다 높거나 같은 등급의 유저를 삭제할 수 없습니다.")
			return false;
		}
		
		else {
			var res = confirm("추방 하시겠습니까?");
				if (res){
					$.ajax({
						url:'<c:url value="/AdminUserDelete.do" />',
						data:{
							"user_id":user_id,
							"deleteReason":checkStr
						},
						type:"POST",
						success:function(result){
							console.log(result.msg);
							if (result.msg == "noReason"){
								
								alert("삭제 사유를 1개 이상 체크해 주세요.");
								return false;
							}
							
							else if (result.msg == "success"){
								alert("성공적으로 삭제하였습니다.");
								location.reload();
							}
						
								
						}
								
					});
				}
		}
			
				
	}
	
	gradelog = function(log,pages,i){
		var gradelogpage = "";
		gradelogpage +="<tr>";
		gradelogpage +="<td>"+(pages.total- ((pages.nowPage -1) * pages.perPage)-i)+"</td>";
		gradelogpage +="<td>";
		gradelogpage += log.qualify_email+"님이 "+log.qualified_email+"님의 등급을 "+"<span style='color:red;'>"+gradeNamefunc(log.qualify_grade) +"</span>"+" -> "+"<span style='color:blue;'>"+gradeNamefunc(log.qualified_grade)+"</span>"+"로 변경하였습니다.";
		gradelogpage +="</td>";
		gradelogpage +="<td>";
		gradelogpage += timestampTodate(log.created);
		gradelogpage +="</td>";
		gradelogpage +="</tr>";
		
		$("#gradelogtbody").append(gradelogpage);
		
	}
	
	gradelogbtn = function(user){
		$.ajax({
			url:'<c:url value="/AdminGradelog.do"/>',
			data:{
				"page":"1"
			},
			type:"get",
			success:function(result){
				var loglist = result.gradeloglist;
				var pages = result.pages;
				$("#gradelogtbody").empty();
				$(".logPageBtn").empty();
				for (var i=0;i<loglist.length;i++){
					gradelog(loglist[i],pages,i)
				}
				$(".logPageBtn").append(logpaginator(pages));
				$("#Admingradelog").clone().appendTo(".user_list");
			}
		
		
		})
	}
	
	logpaginator = function(pages){
		var btn = "";
		
		if (pages.existPrePage){
			btn += "<a style='font-size:large; cursor:pointer;' onClick='nextOrPrelogPageBtn("+(pages.nowPage-1)+")'>Previous</a>";
			
		}
		for(var i = pages.startPage; i<=pages.endPage; i++){
			btn+="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrelogPageBtn("+i+")'>"+i+"</a>";
		}
		if (pages.existNextPage){
			btn +="<a style='margin-left:10px;font-size:large; cursor:pointer;' onClick='nextOrPrelogPageBtn("+(pages.nowPage+1)+")'>Next</a>";
			
		}
		return btn
	}
	
	nextOrPrelogPageBtn = function(page){
		$.ajax({
			url:'<c:url value="/AdminGradelog.do"/>',
			data:{"page":page},
			type:"get",
			success:function(result){
				$("#gradelogtbody").empty();
				$(".logPageBtn").empty();
				var loglist = result.gradeloglist;
				var pages = result.pages;
				for (var i=0; i<loglist.length;i++){
					$(".gradelogtbody").append(gradelog(loglist[i],pages,i))
				}	
				$(".logPageBtn").append(logpaginator(pages));
			}
		});
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
	
	gradeNamefunc = function(name){
		if (name==0){
			return "일반";
		}
		else if (name == 1){
			return "스태프";
		}
		else if (name == 2){
			return "운영자";
		}
	}

</script>
</head>
<body>
<input type="hidden" id="sessionUserid" value="${sessionScope.user_id }"/>
<input type="hidden" id="sessionGrade" value="${sessionScope.grade }"/>
<input type="hidden" id="sessionAdmin" value="${sessionScope.is_admin }"/>
<div class="all_user_list" style="z-index:0;">
	<div class="user_list" style="position:relative; display:flex; justify-content:center;margin-top:30px; z-index:0;" >
	    <table border="1"  class="user_list_table" >
		    <thead class="user_list_thead">
			    <tr>
					<th style="width:5%;">NO</th>
					<th>아이디</th>
					<th style="width:13%;">이름</th>
					<th style="width:20%;">생성일</th>
					<th style="width:7%">생성 경로</th>
					<th style="width:5%">등급</th>
					<th style="width:5%">관리</th>
				</tr>
			</thead>
			
			<tbody class="user_list_tbody">
				
			</tbody>
	    </table>
	    
	    <div style="position:absolute; right:15%; bottom:-40px;">
			<select style="width:100px; text-align:center; height:2vh; border-radius:1.2em;" id="orderByselect">
				<option  id="orderBycreated" value="created">최신 가입순</option>
				<option id="orderByheart" value="grade" >등급순</option>
			</select>
		</div>
		<c:if test="${sessionScope.grade == 3 }">
			<div style="position:absolute; left:15%; bottom:-38px; ">
				<button type="button" style="cursor:pointer; border-radius:1rem; background-color:white; border:1px solid; width:100px;"onClick='gradelogbtn();'>등급 로그</button>
			</div>
		</c:if>
	   	<div class="page_btn" style="position:absolute; bottom:-130px;">
	   	</div>
   		</div>
	</div> 
	
	<div hidden>
		<div id="Admingradelog" style='position:fixed;   top:5%; width:100%; height:100%; background-color:rgba( 255, 255, 255, 0.5 ); z-index:1;'>
			<div id="gradeloglist" style='display:flex; flex-direction:column; align-items:flex-end; position:absolute; right:5%; background-color:white; width: 90%; height:1000px; border:2px solid; z-index:2;'>
				<table style="width:100%; height:100%;table-layout: fixed;" border="1"  >
				    <thead>
					    <tr>
							<th style="width:10%;">NO</th>
							<th>내용</th>
							<th style="width:20%;">날짜</th>
							
						</tr>
					</thead>
					
					<tbody id="gradelogtbody" >
						
					</tbody>
			    </table>
			    <div style="display:flex;">
			    	<div style="position:absolute;right:50%; margin-top:5px;" class="logPageBtn">
		   			</div>
				    <div>
			    		<button style="width:130px; height:40px; margin-top:15px;" type="button" onClick="cancelBtn();">나가기</button>
			    	</div>
	   			</div>
	   		</div>
		</div>
	</div>
		
</body>
</html>
