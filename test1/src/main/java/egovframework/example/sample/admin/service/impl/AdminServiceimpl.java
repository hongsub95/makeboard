package egovframework.example.sample.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.sample.admin.dao.AdminDAO;
import egovframework.example.sample.admin.model.GradelogVO;
import egovframework.example.sample.admin.service.AdminService;
import egovframework.example.sample.board.model.PagingVO;

@Service
public class AdminServiceimpl implements AdminService{
	
	@Autowired
	private AdminDAO admindao;
 	
	@Override
	public void AdmindeleteBoard(Long Board_id, String checked_str) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("id",Board_id);
		map.put("deleteReason", checked_str);
		admindao.deleteBoardReason(map);
	}
	
	@Override
	public int findallGradeLogcnt() {
		return admindao.selectGradelogCnt();
	}
	
	@Override
	public List<GradelogVO> findallGradeLog(PagingVO pagingvo){
		return admindao.selectGradeLog(pagingvo);
	}
}
