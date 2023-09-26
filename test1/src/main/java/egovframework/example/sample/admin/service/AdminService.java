package egovframework.example.sample.admin.service;

import java.util.List;

import egovframework.example.sample.admin.model.GradelogVO;
import egovframework.example.sample.board.model.PagingVO;

public interface AdminService {
	public void AdmindeleteBoard(Long Board_id, String checked_str);
	
	public int findallGradeLogcnt();
	
	public List<GradelogVO> findallGradeLog(PagingVO pagingvo);
}
