package egovframework.example.sample.board.service.impl;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.board.dao.BoardDAO;
import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.PagingVO;
import egovframework.example.sample.board.service.BoardService;
import egovframework.example.sample.board.web.FileUtils;
import egovframework.example.sample.login.dao.LoginDAO;
import egovframework.example.sample.user.model.UserVO;

@Service 
public class BoardServiceimpl implements BoardService{
	
	@Autowired
	private FileUtils fileutils;
	
	@Autowired
	private BoardDAO boarddao;
	
	
	@Autowired
	private LoginDAO logindao;
	
	// 게시물 전부 가져오기
	@Override
	public List<BoardVO> findall(PagingVO pagingvo){
		
		return boarddao.BoardList(pagingvo);
	}
		
	// 게시물 수정제한
	@Override
	public void canUpdate(BoardVO vo) {
		vo.setUpdated(new Date());
		boarddao.updateBoard(vo);
	}
		
	// 게시물 삭제제한
	@Override
	public void canDelete(int BoardID) {
		boarddao.deleteBoard(BoardID);
	}
		
		// 게시물 쓰기제한
	@Override
	public void canPost(BoardVO vo,String email) {
		vo.setCreated(new Date());
		UserVO user_vo = logindao.selectUserForemail(email);
		vo.setUser_id(user_vo.getUser_id());
		boarddao.insertBoard(vo);
	}
	
	@Override
	public BoardVO canSelect(int BoardID) {
		return boarddao.selectBoard(BoardID);
	}
	
	@Override
	public List<BoardVO> canMyBoardSelect(Long user_id,PagingVO pagingvo) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("user_id", user_id);
		map.put("pagingvo", pagingvo);
		
		return boarddao.selectMyPostBoard(map);
	}
	
	@Override
	public int getPageTotal() {
		return boarddao.selectPageTotal();
	}
	
	@Override
	public int getPagemyTotal(Long user_id) {
		return boarddao.selectPagemyTotal(user_id);
	}
	
	@Override
	public void postFile(BoardVO vo, MultipartHttpServletRequest mpRequest) throws Exception {
		List<Map<String,Object>> list =fileutils.parseInsertFileInfo(vo, mpRequest);
		int size = list.size();
		
		for(int i = 0; i<size; i++) {
			boarddao.insertFile(list.get(i));
		}
	}

	
}

