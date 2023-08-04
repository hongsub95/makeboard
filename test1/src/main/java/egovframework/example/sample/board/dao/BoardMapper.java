package egovframework.example.sample.board.dao;


import java.util.List;
import java.util.Map;

import egovframework.example.sample.board.model.BoardVO;
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
	
	public void insertFile(Map<String,Object> list);
}
