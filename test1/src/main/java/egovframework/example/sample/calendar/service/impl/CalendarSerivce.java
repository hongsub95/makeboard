package egovframework.example.sample.calendar.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import egovframework.example.sample.calendar.dao.CalendarDao;

@Service
public class CalendarSerivce {
	
	@Autowired
	private CalendarDao calendarDao;
	
	public HashMap<String,Object> CalendarHdYear(HashMap<String,Object> hMap) {
		
		return calendarDao.selectCalnedarHdYear(hMap);
	}
	
	public List<HashMap<String,Object>> CalendarHd(HashMap<String,Object> hMap) {
		
		return calendarDao.selectCalnedarHd(hMap);
	}
	
	public HashMap<String,Object> insertCalendarHd(HashMap<String,Object> hMap) {
		
		int result = calendarDao.insertCalnedarHd(hMap);
		
		return hMap;
	}
	
public HashMap<String,Object> insertCalendarHdYear(HashMap<String,Object> hMap) {
		
		int result = calendarDao.insertCalnedarHdYear(hMap);
				
		if(hMap.get("yearId") == null) {
			hMap.put("yearId",1);
		}
		return hMap;
	}
}
