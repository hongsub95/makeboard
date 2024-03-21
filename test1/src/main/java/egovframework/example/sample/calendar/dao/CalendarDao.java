package egovframework.example.sample.calendar.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CalendarDao {
	
	@Autowired
	protected SqlSessionTemplate sqlsession;
	
	public int insertCalnedarHd(HashMap<String,Object> hMap){
		
		return sqlsession.insert("Calendar.calendarHdInsert",hMap);
	}
	
	public int insertCalnedarHdYear(HashMap<String,Object> hMap){
		
		return sqlsession.insert("Calendar.calendarHdYearInsert",hMap);
	}
	
	public HashMap<String,Object> selectCalnedarHdYear(HashMap<String,Object> hMap){
		
		return sqlsession.selectOne("Calendar.calendarHdYearSelect",hMap);
	}
	
	public List<HashMap<String,Object>> selectCalnedarHd(HashMap<String,Object> hMap){
		
		return sqlsession.selectList("Calendar.calendarHdSelect",hMap);
	}
	
}
