package egovframework.example.sample.admin.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.admin.model.GradelogVO;
import egovframework.example.sample.board.model.PagingVO;

@Repository
public class AdminDAO implements AdminMapper {
	@Autowired
	protected SqlSessionTemplate sqlsession;
	
	@Override
	public void deleteBoardReason(Map<String,Object> map) {
		sqlsession.update("Board.deleteReason",map);
	}
	
	@Override
	public void insertGradeLog(GradelogVO logvo) {
		sqlsession.insert("Gradelog.insertGradeLog",logvo);
	}
	
	@Override
	public int selectGradelogCnt() {
		return sqlsession.selectOne("Gradelog.GradelogTotalcnt");
	}
	
	@Override
	public List<GradelogVO> selectGradeLog(PagingVO pagingvo){
		return sqlsession.selectList("Gradelog.selectGradelog",pagingvo);
	}
}
