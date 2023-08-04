package egovframework.example.sample.board.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	
	public List<BoardVO> canMyBoardSelect(Long user_id,PagingVO pagingvo);
	
	public int getPageTotal();
	
	public int getPagemyTotal(Long user_id);
	
	public void postFile(BoardVO vo, MultipartHttpServletRequest mpRequest) throws Exception;
	
}
