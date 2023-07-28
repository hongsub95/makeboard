package egovframework.example.sample.board.dao;

import java.util.Date;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.example.sample.board.model.BoardVO;
import egovframework.example.sample.board.model.PagingVO;


@Repository
public class BoardDAO implements BoardMapper{
	
	@Autowired
	protected SqlSessionTemplate sqlsession;
	
	//게시물 전체 조회
	@Override
	public List<BoardVO> BoardList(PagingVO pagingvo){
		
		return sqlsession.selectList("Board.boardlist",pagingvo);
	}
	
	// 게시물 생성(post)
	@Override
	public void insertBoard(BoardVO vo) {
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
	public int selectPageTotal() {
		return sqlsession.selectOne("Board.totalpage");
	}
	
}
