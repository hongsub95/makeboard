package egovframework.example.sample.board.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.board.model.BoardFileVO;
import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.HeartVO;
import egovframework.example.sample.board.model.PagingVO;


@Repository
public class BoardDAO implements BoardMapper{
	
	@Autowired
	protected SqlSessionTemplate sqlsession;
	
	//게시물 전체 조회
	@Override
	public List<BoardVO> BoardList(PagingVO pagingvo){
		
		return sqlsession.selectList("Board.boardlistOrderCreated",pagingvo);
	}
	
	// 게시물 생성(post)
	@Override
	public void insertBoard(BoardVO vo) {
		System.out.println(vo.getContent());
		sqlsession.insert("Board.insertboard",vo);
	}
	
	// 게시물 조회 (get)
	@Override
	public BoardVO selectBoard(int BoardID) {
		return sqlsession.selectOne("Board.selectboard", BoardID);
	}
	
	@Override
	public void updateBoard(BoardVO vo) {
		sqlsession.update("Board.updateboard",vo);
	}
	
	@Override
	public void deleteBoard(int BoardID) {
		sqlsession.delete("Board.deleteboard",BoardID);
	}
	
	@Override
	public void softdeleteBoard(BoardVO vo) {
		sqlsession.update("Board.softdeleteboard",vo);
	}
	
	@Override
	public int selectPageTotal() {
		return sqlsession.selectOne("Board.totalpage");
	}
	
	@Override
	public List<BoardVO> selectMyPostBoard(Map<String,Object> map) {
		return sqlsession.selectList("Board.selectMyPostBoard",map);
	}
	
	@Override
	public int selectPagemyTotal(Long user_id) {
		return sqlsession.selectOne("Board.mytotalpage",user_id);
	}
	
	
	@Override
	public void insertFile(BoardFileVO fileVO) {
		sqlsession.insert("Board.insertFile",fileVO);
	}
	
	@Override
	public List<BoardFileVO> selectFiles(int board_id){
		return sqlsession.selectList("BoardFile.fileselect",board_id);
	}
	
	@Override 
	public Map<String,Object> fileDownload(Map<String,Object> map){
		return sqlsession.selectOne("BoardFile.filedownload",map);
	}
	
	@Override
	public void updateFile(BoardFileVO fileVO) {
		sqlsession.update("BoardFile.updatefile",fileVO);
	}
	
	@Override
	public void deleteAllFile(Long board_id) {
		sqlsession.delete("BoardFile.deleteAllfile",board_id);
	}
	
	@Override
	public void deleteFile(int file_id) {
		sqlsession.delete("BoardFile.deletefile",file_id);
	}
	
	@Override
	public int selectAllHeart(int board_id) {
		return sqlsession.selectOne("Heart.countAllHeart",board_id);
	}
	
	@Override
	public int selectUserId(Map<String, Integer> map ) {
		return sqlsession.selectOne("Heart.checkIsUser",map);
	}
	
	@Override
	public void insertHeart(Map<String,Integer> map) {
		sqlsession.insert("Heart.insertHeart",map);
	}
	
	@Override
	public void deleteHeart(Map<String,Integer> IdMap) {
		
		sqlsession.delete("Heart.deleteHeart",IdMap);
	}
	
	@Override
	public List<BoardVO> BoardListByHeart(PagingVO pagingvo){
		return sqlsession.selectList("Board.boardlistOrderHeart",pagingvo);
	}
	
	@Override
	public List<HeartVO> selectAllHeart(){
		return sqlsession.selectList("Heart.selectAllHeart");
	}
	
	@Override
	public List<BoardVO> selectSearchWord(Map<String, Object> map){
		
		return sqlsession.selectList("Board.selectSearchword",map);
	}
	
	@Override
	public int selectSearchwordPage(Map<String, Object> map) {
		return sqlsession.selectOne("Board.selectSearchwordpage",map);
	}
	
	@Override
	public String selectfileId(String savedFileName) {
		return sqlsession.selectOne("BoardFile.selectfile",savedFileName);
	}
	
	
}
