import { Calendar } from '@fullcalendar/core'
import timeGridPlugin from '@fullcalendar/timegrid'

    var g_arg;

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
        	plugins: [timeGridPlugin],
        initialView: 'dayGridMonth',
          headerToolbar: {
              left: 'prev,next today',
              center: "title",
              right: 'dayGridMonth,dayGridWeek,dayGridDay',
          },
          views: {
        	    timeGridFourDay: {
        	      type: 'timeGrid',
        	      duration: { days: 7 }
        	    }
          },
          locale:"ko",
          height:800,
          navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크        
          editable: true, // 수정 가능?        
       	  selectable: true, // 달력 일자 드래그 설정가능        
       	  nowIndicator: true, // 현재 시간 마크        
       	  dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
       	  expandRows: true // 화면에 맞게 높이 재설정
       	
          
          
        });
        calendar.render();
      });
      
      