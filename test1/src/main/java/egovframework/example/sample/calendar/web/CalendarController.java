package egovframework.example.sample.calendar.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CalendarController {
	
	@RequestMapping(value="/fullCalendar.do")
	public ModelAndView calendarDetail(ModelAndView mav) {
		
		mav.setViewName("sample/calendar/calendarForm");
		
		return mav;
	}
	
}
