package egovframework.example.sample.admin.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO implements AdminMapper {
	@Autowired
	protected SqlSessionTemplate sqlsession;
	
	public void deleteBoardReason(Map<String,Object> map) {
		sqlsession.update("Board.deleteReason",map);
	}
}
