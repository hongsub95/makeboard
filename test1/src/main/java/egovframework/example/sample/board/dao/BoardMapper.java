package egovframework.example.sample.board.dao;


import java.util.List;
import java.util.Map;

import egovframework.example.sample.board.model.BoardFileVO;
import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.HeartVO;
import egovframework.example.sample.board.model.PagingVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;


@Mapper
public interface BoardMapper {
	
	//전체 게시물 조회
	
	public List<BoardVO> BoardList(PagingVO pagingvo);
	
	// 게시물 생성(post)
	public void insertBoard(BoardVO vo);

	// 게시물 조회 (get)
	public BoardVO selectBoard(int BoardID);
	
	
	public void updateBoard(BoardVO vo);
	
	public void deleteBoard(int BoardID);
	
	public int selectPageTotal();
	
	public List<BoardVO> selectMyPostBoard(Map<String,Object> map);
	
	public int selectPagemyTotal(Long user_id);
	
	public void insertFile(BoardFileVO fileVO);
	
	public void updateFile(BoardFileVO fileVO);
	
	public List<BoardFileVO> selectFiles(int board_id);
	
	public Map<String,Object> fileDownload(Map<String,Object> map);
	
	public void deleteAllFile(int board_id);
	
	public void deleteFile(int file_id);
	
	public int selectAllHeart(int board_id);
	
	public int selectUserId(Map<String, Integer> map);
	
	public void insertHeart(Map<String,Integer> map);
	
	public void deleteHeart(Map<String,Integer> IdMap);
	
	public List<BoardVO> BoardListByHeart(PagingVO pagingvo);
	
	public List<HeartVO> selectAllHeart();
	
	public List<BoardVO> selectSearchWord(Map<String, Object> map);
	
	public int selectSearchwordPage(Map<String, Object> map);
}
