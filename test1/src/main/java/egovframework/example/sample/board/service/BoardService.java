package egovframework.example.sample.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.board.model.BoardFileVO;
import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.HeartVO;
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

	public void postFile(BoardVO vo,MultipartFile[] uploadFile) throws Exception;
	
	public void canFileUpdate(BoardVO vo,MultipartFile[] uploadFile) throws Exception;
	
	public List<BoardFileVO> getFiles(int board_id);
	
	public Map<String,Object> getfileInfoForDownload(Map<String, Object> map);
	
	public void DeleteAllFiles(Long board_id);
	
	public void DeleteFile(int file_id);
	
	public int findAllHeart(int board_id);
	
	public boolean checkUserdoOrNot(int user_id,int board_id);
	
	public void pushHeart(int user_id,int board_id);
	
	public void removeHeart(int user_id, int board_id);
	
	public List<BoardVO> findallByHeart(PagingVO pagingvo);
	
	public List<HeartVO> findAllHeart();
	
	public List<BoardVO> findSearchBoard(PagingVO pagingvo,String word);
	
	public int searchWordPage(BoardVO boardvo,String word);
	
	public void boardSoftdelete(BoardVO vo);
	
}
