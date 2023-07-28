package egovframework.example.sample.board.service;

import java.util.List;

import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.PagingVO;


public interface BoardService {
	
	// 게시물 전부 가져오기
	public List<BoardVO> findall(PagingVO pagingvo);
	
	// 게시물 수정권한
	public void canUpdate(BoardVO vo);
	
	// 게시물 삭제권한
	public void canDelete(int BoardID);
	
	// 게시물 쓰기권한
	public void canPost(BoardVO vo,String email);
	
	public BoardVO canSelect(int BoardID);
	
	public int getPageTotal();
	
}
