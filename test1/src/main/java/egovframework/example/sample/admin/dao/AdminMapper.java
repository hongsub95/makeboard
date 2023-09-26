package egovframework.example.sample.admin.dao;

import java.util.List;
import java.util.Map;

import egovframework.example.sample.admin.model.GradelogVO;
import egovframework.example.sample.board.model.PagingVO;

public interface AdminMapper {
	public void deleteBoardReason(Map<String,Object> map);
	
	public void insertGradeLog(GradelogVO logvo);
	
	public int selectGradelogCnt();
	
	public List<GradelogVO> selectGradeLog(PagingVO pagingvo);
}
