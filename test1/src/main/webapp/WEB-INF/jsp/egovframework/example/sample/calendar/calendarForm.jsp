<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/egovframework/example/sample/common.jsp" %>
<!DOCTYPE html>
<html>
<head>


<style>
	
	.fade {
		display:none;
	}
	
	.d--flex {
		display:flex;
	}
	
	.form-group{
	margin-top:10px;
	}
	
	.insertModal{
		display:flex;
		justify-content:center;
		align-items:center;
		position:absolute;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		z-index:999;
		background-color : rgb(255,255,255);
		opacity : 1;
		width:20%;
		border:1px solid black;
		padding:10px;
	}
	
	@media screen and (max-width:500px){
	  body {
	    margin: 40px 10px;
	    padding: 30px;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	    font-size: 11px;
	    height:100%;
	  }
	  .fc-toolbar-title{
	  	font-size: 10px !important;
	  }
  }
  @media screen and (min-width:501px){
  	  body {
	    margin: 40px 10px;
	    padding: 0;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	    font-size: 14px;
	    height:100%;
	  }
  }
  #calendar {
    max-width: 1400px;
    min-height: 500px;
    margin:0 auto ;
    margin-top:40px;
  }
  
  .scheduleContainer{
  	display:flex;
  	position:absolute;
  	right:20%;
  	margin-top:30px;
  }
  
  .scheduleBox{
  	border: 1px solid white;
    width: 100px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor:pointer;
    
  }
  
  .addSchedule{
   background:#4B89DC;
   color:white;
  }
  
  .addVacation{
  	margin-left:20px;
  	background:#ffd9e5;
  	color:black;
  }
	
	
	

</style>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 	
 
<script>

 	var g_arg;
 	var timeList = ["오전 8:00","오전 8:30","오전 9:00","오전 9:30","오전 10:00","오전 10:30","오전 11:00","오전 11:30","오후 12:00","오후 12:30","오후 1:00","오후 1:30","오후 2:00","오후 2:30","오후 3:00","오후 3:30","오후 4:00","오후 4:30","오후 5:00","오후 5:30","오후 6:00","오후 6:30","오후 7:00","오후 7:30","오후 8:00","오후 8:30"]
 	var calendar;
	var date = new Date();
	var holidayKey = "bEtdsUkGD4SskNSGyRbXH8jkkwVexF7F4cfhZjxjmahKlKvZtTB0o+o2RayO3b/Yo0cTYciKKANLOIT+GMqauA==";
	var lunarKey = "bEtdsUkGD4SskNSGyRbXH8jkkwVexF7F4cfhZjxjmahKlKvZtTB0o+o2RayO3b/Yo0cTYciKKANLOIT+GMqauA=="
	var pageNo = "1";
	var numOfRows = "50";
	var solYear = date.getFullYear();
	var solMonth = '';
 	var calHolidayDict1 = {};
 	var calHolidayDict2 = {};
 	$(document).ready(function(){
 		for(i=parseInt(solYear)-20;i<=parseInt(solYear)+20;i++){
 		 	var ajaxYear = i;
 		 	if (ajaxYear > solYear){
 		 		ajaxYear = solYear;
 		 	}
 		 	
 		 	$.ajax({
		 		url:'<c:url value="/fullCalendar/hdYear.do" />',
		 		data:{
		 			"year":i
		 		},
		 		async:false,
		 		type:"GET",
		 		success:function(result){
		 			var hdYear = result.hdYear;
		 			if(hdYear == null || hdYear === 'undefined'){
		 				setHolidayYear(ajaxYear,i);
		 				
		 			}
		 			else{ 
		 				getHolidayFromDb(i); 
		 			}
		 		},
		 		error:function(result){
		 			
		 		}
		 		
		 	})
 		 	
 			
 		}
 		
 		$(".fc-button-primary").on("click",function(){
 			setHoliday();	
 		})
 		
 		$("#vacation").on('change',function(){
 			var vacationYn = $("#vacation").is(":checked");
 			if (vacationYn){
 				$("#title").attr("disabled","disabled");
 				$("#startTime").attr("disabled","disabled");
 				$("#endTime").attr("disabled","disabled");
 				$("#content").attr("disabled","disabled");
 				
 			}
 			else{
 				$("#title").removeAttr("disabled");
 				$("#startTime").removeAttr("disabled");
 				$("#endTime").removeAttr("disabled");
 				$("#content").removeAttr("disabled");
 			}
 		})
 		
 		
 		
 		
 		$("#datepicker01, #datepicker02").datepicker({
			dateFormat: 'yy-mm-dd',	//날짜 포맷이다. 보통 yy-mm-dd 를 많이 사용하는것 같다.
			prevText: '이전 달',	// 마우스 오버시 이전달 텍스트
			nextText: '다음 달',	// 마우스 오버시 다음달 텍스트
			closeText: '닫기', // 닫기 버튼 텍스트 변경
			currentText: '오늘', // 오늘 텍스트 변경
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더중 월 표시를 위한 부분
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더 중 월 표시를 위한 부분
			dayNames: ['일', '월', '화', '수', '목', '금', '토'],	//한글 캘린더 요일 표시 부분
			dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],	//한글 요일 표시 부분
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],	// 한글 요일 표시 부분
			showMonthAfterYear: true,	// true : 년 월  false : 월 년 순으로 보여줌
			yearSuffix: '년',	//
			showButtonPanel: true,	// 오늘로 가는 버튼과 달력 닫기 버튼 보기 옵션
			// timepicker 설정
			timeFormat:'HH:mm:ss',
			controlType:'select',
			oneLine:true,
		});	
 		setAddTime();
 		
 		$("#allDayYn").on("change",function(){
 			chkAllday();
 		})
 		
 	})
 	
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = $("#calendar")[0];
        calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        timeZone:'Asia/Seoul',
        expandRows: true, // 화면에 맞게 높이 재설정
        /* slotMinTime: '08:00', // Day 캘린더에서 시작 시간        
		slotMaxTime: '21:00', */
          headerToolbar: {
        	  
              left: 'prevYear,prev,next,nextYear today',
              center: "title",
              right: 'dayGridMonth,timeGridWeek,timeGridDay',
          },
          views: {
        	    timeGridFourDay: {
        	      type: 'timeGrid',
        	      duration: { days: 4 }
        	    }
          },
          locale:"ko",
          height:800,
          navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크        
          editable: false, // 수정 가능?        
       	  selectable: true, // 달력 일자 드래그 설정가능        
       	  nowIndicator: false, // 현재 시간 마크        
       	  dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)      
       	  select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다. 
   		  var viewType = arg.view.type;
   		  $("#insertTitle").removeClass('fade');
		  $("#editTitle").addClass('fade');
       	  if (viewType == 'dayGridMonth'){
       		openModal('monthGridInsert',arg)
       	  }
       	  else if (viewType == 'timeGridWeek'){
       		openModal('weekGridInsert',arg)  
       	  }
       	 
       		 
       	 },
       	 contentHeight:function(){
       		if(screen.width<800){
       			return 500;
       		} else{
       			return 850;
       		}
       	 },
       	  eventClick:function(arg){
       		$("#insertTitle").addClass('fade');
   		    $("#editTitle").removeClass('fade');
       		if (arg.event.allDay == true){
       			openModal('allDayTrue',arg)
       		}
       		else if (arg.event.allDay == false){
       			openModal('allDayFalse',arg)
       		}
       	 }
        });
        calendar.render();
      });
 	
 function setHoliday(){
	 $.each($("td"),function(index,item){
		 
		 var holiday = $(item).attr("data-date");
		 
		 if (calHolidayDict1[holiday] != null && calHolidayDict1[holiday] != 'undefined'){
			 var hdHtml = "<span id=holiday_"+holiday+">";
			 hdHtml += calHolidayDict1[holiday];
			 hdHtml += "</span>";
			 
			 $("td[data-date="+holiday+"] .fc-daygrid-day-top #holiday_"+holiday+"").remove();
			 $("td[data-date="+holiday+"] .fc-daygrid-day-top").attr("style","color:red;display:flex;align-items:center;");
			 $("td[data-date="+holiday+"] .fc-daygrid-day-top").append(hdHtml);	 
		 }
		 
	 })
	 
 }
 
 function setHolidayYear(ajaxYear,year){
	 $.ajax({
		 url:"<c:url value='/fullCalendar/insert/hdYear.do'/>",
		 data:{
			 "year":year
		 },
		 type:"POST",
		 async:false,
		 success:function(result){
			 var yearId = result.hMap.yearId;
			 getHolidayFromApi(ajaxYear,year,yearId);
		 },
		 error:function(result){
			 
		 }
	 })
 }
 
 function getHolidayFromDb(year){
	 $.ajax({
		 url:"<c:url value= '/fullCalendar/hd.do'/>",
		 data:{
			 "year":year
		 },
		 type:"GET",
		 success:function(result){
			 var holidayList = result.holiday;
			 holidayList.forEach(function(item){
				 calHolidayDict1[item.HOLIDAY_DATE] = item.NAME;
			 });
			 setHoliday();
			 
		 },
		 error:function(result){
			 alert("데이터베이스에서 공휴일 가져오기 에러");
		 }
		 
	 })
 }
 
 function chkDecLastDays(lunDay,lunMonth,lunYear,itemName,yearId){
	 $.ajax({
		 url:'<c:url value="http://apis.data.go.kr/B090041/openapi/service/LrsrCldInfoService/getSolCalInfo"/>',
		 data:{
			 "ServiceKey":lunarKey,
			 "lunYear":lunYear,
			 "lunMonth":lunMonth,
			 "lunDay":lunDay
		 },
		 async:false,
		 type:"GET",
		 success:function(result){
			 var item = $(result).find("item");
			 
			 if (item.length == 0){
				 getLunToSolDay(lunYear,'12','29',itemName,yearId);
			 }
			 else{
				 getLunToSolDay(lunYear,'12','30',itemName,yearId);
			 }
			
		}
	 }); 
 }
 
 function getLunToSolDay(lunYear,lunMonth,lunDay,itemName,yearId){
	 
	 $.ajax({
		 url:'<c:url value="http://apis.data.go.kr/B090041/openapi/service/LrsrCldInfoService/getSolCalInfo"/>',
		 data:{
			 "ServiceKey":lunarKey,
			 "lunYear":lunYear,
			 "lunMonth":lunMonth,
			 "lunDay":lunDay
		 },
		 async:false,
		 type:"GET",
		 success:function(result){
			 var item = $(result).find("item");
			 var solyear = $(item).find("solYear").text();
			 var solMonth = $(item).find("solMonth").text();
			 var solDay = $(item).find("solDay").text();
			 var itemYear = solyear + "-" + solMonth + "-" + solDay;
			 
			 $.ajax({
					url:'<c:url value="/fullCalendar/insert/hd.do"/>',
					data:{
						"name":itemName,
						"date":itemYear,
						"type":0,
						"yearId":yearId
					},
					type:"POST",
					async:false,
					success:function(result){
					},
					error:function(result){
						
					}
				})  
				calHolidayDict1[itemYear] = itemName; 
		 },
		 error:function(result){
			 
		 }
	 })
 }
 
 function getHolidayFromApi(year,realYear,yearId){
	 $.ajax({
			url:"http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo",
			data:{
				"ServiceKey":holidayKey,
				"pageNo":pageNo,
				"numOfRows":numOfRows,
				"solYear":year,
				"solMonth":solMonth
			},
			type:"GET",
			success:function(result){
				var cnt1=0;
				var cnt2=0;
				$.each($(result).find("item"),function(index,item){
					var itemYear = realYear.toString() +"-"+$(item).find('locdate').text().substring(4,6)+"-"+$(item).find('locdate').text().substring(6,8);
					var itemName = $(item).find('dateName').text();
					
					if (itemName == '1월1일'){
						itemName = '신정';
					}
					if (itemName == '기독탄신일'){
						itemName='성탄절';
					} 
					if (parseInt(realYear) > parseInt(year) ){
						
						if((itemName.substring(0,5) == "대체공휴일" || itemName.substring(0,4) == "국회의원" || itemName.substring(0,3) == '대통령')){
							
						}
						else if (itemName == '설날'){
							var lunYear = realYear;
							if(cnt1 % 3 == 0){
								var chkDay = chkDecLastDays('30','12',parseInt(lunYear)-1,itemName,yearId);
								cnt1 ++;
								}
							else if (cnt1 % 3 == 1){
								getLunToSolDay(lunYear,'01','01',itemName,yearId);
								cnt1 ++;
							}
							else{
								getLunToSolDay(lunYear,'01','02',itemName,yearId)
								cnt1 = 0;
							}
							
						}
						else if (itemName == '추석'){
							var lunYear = realYear;
							if (cnt2 % 3 == 0){
								getLunToSolDay(lunYear,'08','14',itemName,yearId);
								cnt2++;
							}
							else if (cnt2 % 3 == 1){
								getLunToSolDay(lunYear,'08','15',itemName,yearId);
								cnt2++;
							}
							else{
								getLunToSolDay(lunYear,'08','16',itemName,yearId);
								cnt2 = 0;
							}
							
						}
						else{
							$.ajax({
								url:'<c:url value="/fullCalendar/insert/hd.do"/>',
								data:{
									"name":itemName,
									"date":itemYear,
									"type":0,
									"yearId":yearId
									
								},
								type:"POST",
								async:false,
								success:function(result){
								},
								error:function(result){
									
								}
							})  
							calHolidayDict1[itemYear] = itemName;
						}
					}
					else{
						
						$.ajax({
							url:'<c:url value="/fullCalendar/insert/hd.do"/>',
							data:{
								"name":itemName,
								"date":itemYear,
								"type":0,
								"yearId":yearId
								
							},
							type:"POST",
							async:false,
							success:function(result){
							},
							error:function(result){
								
							}
						})  
						calHolidayDict1[itemYear] = itemName;
					}
					});
					
					
				setHoliday();
			},
			error:function(){
				
			}
		})
 }
 	
 function setAddTime(){
	 var id = $(this).attr("id");
		var timeHtml = "";
		var timeIdx = 0;
		for(var i = 0; i<timeList.length;i++){
				if (timeList[i].substring(0,2) == '오전'){
					timeHtml +="<option timeIdx="+timeIdx+" value=0"+timeList[i].substring(3,timeList.length)+":00>"+timeList[i]+"</option>";	
				}
				else{
					if (timeList[i].substring(3,timeList.length).split(':')[0] == '12'){
						timeHtml +="<option timeIdx="+timeIdx+" value="+timeList[i].substring(3,timeList.length)+":00>"+timeList[i]+"</option>";	
					}else{
						var timeSplit = timeList[i].substring(3,timeList.length).split(':');
						var pmTime = parseInt(timeSplit[0])+12;
						timeHtml +="<option timeIdx="+timeIdx+" value="+pmTime+":"+timeSplit[1]+":00>"+timeList[i]+"</option>";		
				}
			}
			timeIdx++;
		}
		
		$("#startTime").empty();
		$("#startTime").append(timeHtml);
		$("#startTime option[timeIdx='0']").attr("selected","true");
	
		$("#endTime").empty();
		$("#endTime").append(timeHtml);
		$("#endTime option[timeIdx='1']").attr("selected","true");
 }
 


function initModal(arg){
	$("#title").val('');
	$("#myModal").addClass("fade");
	$("#myModal").removeClass("insertModal");
	$("#startTime option[timeIdx='0']").prop('selected');
	$("#endTime option[timeIdx='1']").prop('selected');
	arg = null;
}
 	
function stringFormat(p_val){
	if(p_val < 10)
		return p_val = '0'+p_val;
	else
		return p_val;
  }

function openModal(mode,arg){
	// fullcalendar 월 단위 일 때 스케줄 입력
	if (mode == 'monthGridInsert'){
		 var endStrSplit = arg.endStr.split("-");
		  var newEndDate = new Date(endStrSplit[0],endStrSplit[1]-1,endStrSplit[2]-1);
		  
		  arg.end = newEndDate;
		  arg.endStr = newEndDate.getFullYear() + '-' + stringFormat(newEndDate.getMonth()+1) +'-'+  stringFormat(newEndDate.getDate())
		  
		  $("#datepicker01").val(arg.startStr);
		  $("#datepicker02").val(arg.endStr);
		  $("#myModal").removeClass("fade");
		  $("#myModal").addClass("insertModal");
		  g_arg = arg;
	 }
	// fullcalendar 주 단위 일 때 스케줄 입력
	else if (mode == 'weekGridInsert'){
		  var weekStartSplit = arg.startStr.split("T");
		  var weekEndSplit = arg.endStr.split("T");
		  var weekStartDay = weekStartSplit[0];
		  var weekStartTime = weekStartSplit[1];
		  var weekEndDay = weekEndSplit[0];
		  var weekEndTime = weekEndSplit[1];
		  
		  $("#datepicker01").val(weekStartDay);
		  $("#datepicker02").val(weekEndDay);
		  $("#startTime option[value='"+weekStartTime+"']").attr("selected","true");
		  $("#endTime option[value='"+weekEndTime+"']").attr("selected","true");
		  $("#myModal").removeClass("fade");
		  $("#myModal").addClass("insertModal");
		  g_arg = arg;
	}
	
	
	
	// allDay가 false일때
	else if (mode == 'allDayTrue'){
		
		var endStrSplit = arg.event.endStr.split("-");
	    var newEndDate = new Date(endStrSplit[0],endStrSplit[1]-1,endStrSplit[2]-1);
		  
	    arg.end = newEndDate;
	    arg.endStr = newEndDate.getFullYear() + '-' + stringFormat(newEndDate.getMonth()+1) +'-'+  stringFormat(newEndDate.getDate())
	    
	    $("#datepicker01").val(arg.event.startStr);
	    $("#datepicker02").val(arg.event.endStr);
	    
	    $("#myModal").removeClass("fade");
	    $("#myModal").addClass("insertModal");
	    g_arg = arg.event;
	}
	
	else if (mode == 'allDayFalse'){
		  var weekStartSplit = arg.event.startStr.split("T");
		  var weekEndSplit = arg.event.endStr.split("T");
		  var weekStartDay = weekStartSplit[0];
		  var weekStartTime = weekStartSplit[1];
		  var weekEndDay = weekEndSplit[0];
		  var weekEndTime = weekEndSplit[1];
		  
		  $("#datepicker01").val(weekStartDay);
		  $("#datepicker02").val(weekEndDay);
		  $("#startTime option[value='"+weekStartTime+"']").attr("selected","true");
		  $("#endTime option[value='"+weekEndTime+"']").attr("selected","true");
		  $("#myModal").removeClass("fade");
		  $("#myModal").addClass("insertModal");
		  g_arg = arg.event;
	}
	  
}

function setSchedule(){
	
}

function ajaxSchedule(type,title,startDate,endDate,allDay,content){
	
}

function approvalSch(mode,arg){
	var vacation = $("#vacation").is(":checked");
	if (mode == 'insertTitle'){
		if (vacation){
			calendar.addEvent({
				title:"휴가",
				start : $("#datepicker01").val()+'T'+$("#startTime").val(),
				end : $("#datepicker02").val()+'T'+$("#endTime").val(),
				allDay:true,
				color:"#7bd3f7"
			})		
		}
		else{
			calendar.addEvent({
				title:$("#title").val(),
				start : $("#datepicker01").val()+'T'+$("#startTime").val(),
				end : $("#datepicker02").val()+'T'+$("#endTime").val(),
				allDay:false,
				color:"#fa8ee5"
			})			
		}

	}
	else if (mode == 'editTitle'){
		if (vacation){
			arg.setProp('title', "휴가");
			arg.setAllDay(true);
			arg.setStart($("#datepicker01").val()+'T'+$("#startTime").val());
			arg.setEnd($("#datepicker02").val()+'T'+$("#endTime").val());
			arg.setProp('color',"#7bd3f7")
		}
		else{
			arg.setProp('title', $("#title").val());
			arg.setAllDay(false);
			arg.setStart($("#datepicker01").val()+'T'+$("#startTime").val());
			arg.setEnd($("#datepicker02").val()+'T'+$("#endTime").val());	
			arg.setProp('color',"#fa8ee5")
		}
		
	}
	
	initModal(arg);
}

function chkAllday(){
	var allDayYn = $("#allDayYn").is(":checked");
	if (allDayYn){
		$("#startTime").attr("disabled","true");
		$("#endTime").attr("disabled","true");
	}
	else{
		$("#startTime").removeAttr("disabled");
		$("#endTime").removeAttr("disabled");	
	}
}


/* function setAppendTime(){
	 $("#startTime").append("<option value='08:00:00'>오전 8:00</option>");
	 $("#endTime").append("<option value='08:00:00'>오전 8:00</option>");
} */
    </script>
    
</head>
<body>
	
	<div id='calendar'></div>
	
	<div class="scheduleContainer">
		<div class="addSchedule scheduleBox" onClick="openModal('monthGridInsert',g_arg)">
			방문등록
		</div>
		<div class="addVacation scheduleBox">
			휴가등록
		</div>
	
	</div>
	
	
	
	<div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
	         <div class="d--flex" style="justify-content:space-between;">
	        	<h4 class="modal-title">방문 등록</h4>
	        	<button style="border:none;cursor:pointer; font-size:20px; " type="button" class="closeBtn" onclick="initModal(g_arg)">X</button>
	         </div>
        </div>
       
        
        <div class="modal-body">
          
          <div class="form-group">
			<label for="title">일정제목:</label>
			<input type="text" class="form-control" style="margin-left:5px;" placeholder="" id="title">
		  </div>
		  <div class="form-group" style="display:flex;">
			<label for="title">일정내용:</label>
			<textarea class="form-control" placeholder="" id="content" style="margin-left:10px;"></textarea>
		  </div>
		  <div class="form-group d--flex">
			<label for="start">시작시간:</label>
			<div class="d--flex" style="margin-left:10px;">
				<input type="text" id="datepicker01" style="width:170px" class="date"  style="cursor: pointer;" readonly>
			</div>
			<div>
				<select class="form-control" id="startTime">
					
				</select>
			</div>
		  </div>
		   <div class="form-group d--flex">
			<label for="end">종료시간:</label>
			<div class="d--flex" style="margin-left:10px;">
				<input type="text" id="datepicker02" style="width:170px" class="date" style="cursor: pointer;" readonly>
			</div>
			<div>
				<select class="form-control" id="endTime">
					
				</select>
			</div>
		  </div>
		  <div class="form-group d--flex">
			<label for='allDayYn'>휴가</label>
			<input type='checkbox' id='vacation' style="margin-left:10px"/>
			</div>
        </div>
        <div class="modal-footer form-group">
		  <button type="button" class="btn btn-success fade approvalBtn" id="insertTitle" onclick="approvalSch('insertTitle',g_arg)">등록</button>
		  <button type="button" class="btn btn-success fade approvalBtn" id="editTitle" onclick="approvalSch('editTitle',g_arg)">편집</button>
		  <!-- <button type="button" class="btn btn-danger rejectBtn" onclick="rejectSch('insertModal', g_arg)">반려</button>
		  
		  <button type="button" class="btn btn-dark  float-right deleteBtn" onclick="deleteSch('insertModal', g_arg)">취소</button>
		  <button type="button" class="btn btn-warning float-right insertBtn" onclick="insertSch('insertModal', g_arg)">보내기</button> -->
        </div>
        
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="myModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
	         <div class="d--flex" style="justify-content:space-between;">
	        	<h4 class="modal-title">휴가 등록</h4>
	        	<button style="border:none;cursor:pointer; font-size:20px; " type="button" class="closeBtn" onclick="initModal(g_arg)">X</button>
	         </div>
        </div>
       
        
        <div class="modal-body">
          
		  <div class="form-group d--flex">
			<label for="start">시작시간:</label>
			<div class="d--flex" style="margin-left:10px;">
				<input type="text" id="datepicker01" style="width:170px" class="date"  style="cursor: pointer;" readonly>
			</div>
		  </div>
		   <div class="form-group d--flex">
			<label for="end">종료시간:</label>
			<div class="d--flex" style="margin-left:10px;">
				<input type="text" id="datepicker02" style="width:170px" class="date" style="cursor: pointer;" readonly>
			</div>
		  </div>
        </div>
        <div class="modal-footer form-group">
		  <button type="button" class="btn btn-success fade approvalBtn" id="insertTitle" onclick="approvalSch('insertTitle',g_arg)">등록</button>
		  <button type="button" class="btn btn-success fade approvalBtn" id="editTitle" onclick="approvalSch('editTitle',g_arg)">편집</button>
		  <!-- <button type="button" class="btn btn-danger rejectBtn" onclick="rejectSch('insertModal', g_arg)">반려</button>
		  
		  <button type="button" class="btn btn-dark  float-right deleteBtn" onclick="deleteSch('insertModal', g_arg)">취소</button>
		  <button type="button" class="btn btn-warning float-right insertBtn" onclick="insertSch('insertModal', g_arg)">보내기</button> -->
        </div>
        
      </div>
    </div>
  </div>
 
	
</body>
</html>