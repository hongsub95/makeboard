package egovframework.example.sample.board.service.impl;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.sample.board.dao.BoardDAO;
import egovframework.example.sample.board.model.BoardFileVO;
import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.HeartVO;
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
	
	// 게시물 전부 가져오기(추천순)
	@Override
	public List<BoardVO> findallByHeart(PagingVO pagingvo){
		
		return boarddao.BoardListByHeart(pagingvo);
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
	public void postFile(BoardVO vo,MultipartFile[] uploadFile) throws Exception {
		List<BoardFileVO> list =fileutils.parseInsertFileInfo(vo,uploadFile);
		int size = list.size();
		for(int i = 0; i<size; i++) {
			
			boarddao.insertFile(list.get(i));
		}
	}
	
	@Override
	public void canFileUpdate(BoardVO vo,MultipartFile[] uploadFile) throws Exception{
		List<BoardFileVO> list =fileutils.parseInsertFileInfo(vo,uploadFile);
		int size = list.size();
		for(int i = 0; i<size; i++) {
			
			boarddao.insertFile(list.get(i));
		}
	}
	
	@Override
	public List<BoardFileVO> getFiles(int board_id){
		return boarddao.selectFiles(board_id);
	}
	
	@Override
	public Map<String,Object> getfileInfoForDownload(Map<String, Object> map) {
		return boarddao.fileDownload(map);
	}
	
	@Override
	public void DeleteAllFiles(int board_id) {
		boarddao.deleteAllFile(board_id);
	
	}
	@Override
	public void DeleteFile(int file_id) {
		boarddao.deleteFile(file_id);
	}
	
	@Override
	public int findAllHeart(int board_id) {
		return boarddao.selectAllHeart(board_id);
	}
	@Override
	public boolean checkUserdoOrNot(int user_id,int board_id) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_id",user_id);
		map.put("board_id", board_id);
		
		int isCheck = boarddao.selectUserId(map);
		
		if (isCheck >= 1) {
			return false;
		}
		else {
			return true;
		}
		
	}
	
	@Override
	public void pushHeart(int user_id,int board_id) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("user_id", user_id);
		map.put("board_id", board_id);
		boarddao.insertHeart(map);
	}
	
	@Override
	public void removeHeart(int user_id, int board_id) {
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("user_id", user_id);
		map.put("board_id", board_id);
		boarddao.deleteHeart(map);;
	}
	
	@Override
	public List<HeartVO> findAllHeart(){
		return boarddao.selectAllHeart();
	}
	
	@Override
	public List<BoardVO> findSearchBoard(PagingVO pagingvo, String word){
		Map<String, Object> map = new HashMap<String, Object>();
		String trim_word = word.trim();
		map.put("pagingvo",pagingvo);
		map.put("word", trim_word);
		return boarddao.selectSearchWord(map);
	}
	
	@Override
	public int searchWordPage(BoardVO boardvo,String word) {
		Map<String, Object> map = new HashMap<String, Object>();
		String trim_word = word.trim();
		map.put("word",trim_word);
		map.put("board",boardvo);
		return boarddao.selectSearchwordPage(map);
	}
}
