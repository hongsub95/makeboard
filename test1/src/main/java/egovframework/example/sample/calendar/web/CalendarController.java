package egovframework.example.sample.calendar.web;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import egovframework.example.sample.calendar.service.impl.CalendarSerivce;

@Controller
public class CalendarController {
	
	@Autowired
	private CalendarSerivce calendarService;
	
	@RequestMapping(value="/fullCalendar.do")
	public ModelAndView calendarDetail(ModelAndView mav) {
		
		mav.setViewName("sample/calendar/calendarForm");
		
		return mav;
	}
	
	@RequestMapping(value="/mFullCalendar.do")
	public ModelAndView mobileCalendarDetail(ModelAndView mav) {
		
		mav.setViewName("sample/calendar/mCalendarForm");
		
		return mav;
	}
	
	@RequestMapping(value="/fullCalendar/hdYear.do")
	public ModelAndView calendarHdYear(ModelAndView mav,@RequestParam HashMap<String,Object> hMap) {
		mav.addObject("hdYear",calendarService.CalendarHdYear(hMap));
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value="/fullCalendar/hd.do")
	public ModelAndView calendarHd(ModelAndView mav,@RequestParam HashMap<String,Object> hMap) throws Exception {
		try {
			mav.addObject("holiday",calendarService.CalendarHd(hMap));
			mav.setViewName("jsonView");
			return mav;
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
		
	}
	
	@RequestMapping(value="/fullCalendar/insert/hdYear.do")
	public ModelAndView insertCalendarHdYear(ModelAndView mav,@RequestParam HashMap<String,Object> hMap) {
		
		mav.addObject("hMap",calendarService.insertCalendarHdYear(hMap));
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	
	
	@RequestMapping(value="/fullCalendar/insert/hd.do")
	public ModelAndView insertCalendarHd(@RequestParam HashMap<String,Object> hMap) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			
			mav.addObject("hMap",calendarService.insertCalendarHd(hMap));
			mav.setViewName("jsonView");
			
			return mav;
		}
		catch (Exception e){
			System.out.println(e.getMessage());
			return null;
		}
		
	}
	
	
}
