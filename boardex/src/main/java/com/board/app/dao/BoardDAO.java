package com.board.app.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.board.app.vo.BoardFileVO;
import com.board.app.vo.BoardLikeVO;
import com.board.app.vo.BoardVO;

@Repository("boardDAO")
public class BoardDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sql;
	//전체 조회
	public List<BoardVO> findAllBoards(BoardVO boardVO) {
		return sql.selectList("boardDAO.findAllBoards",boardVO);
	}
	//상세 조회
	public BoardVO getBoard(BoardVO boardVO) {
		return sql.selectOne("boardDAO.getBoard",boardVO);
	}
	//삭제
	public int delBoard(BoardVO boardVO) {
		return sql.delete("boardDAO.delBoard",boardVO);
	}
	
	//글번호 최댓값 조회
	public int getMaxIdx() {
		return sql.selectOne("boardDAO.getMaxIdx");
	}
	
	//등록 및 수정처리
	public int upsert(BoardVO boardVO) {
		return sql.insert("boardDAO.upsert",boardVO);
	}
	//파일 등록 및 수정 처리
	public int fileUpsert(BoardFileVO boardFileVO) {
		return sql.insert("boardDAO.fileUpsert",boardFileVO);
	}
	
	//게시글 목록 갯수
	public int getBoardsCnt(BoardVO boardVO) {	
		return sql.selectOne("boardDAO.getBoardsCnt", boardVO);
	}
	//좋아요 확인 여부
	public int findLike(BoardLikeVO boardLikeVO) {
		return sql.selectOne("boardDAO.findLike",boardLikeVO);
	}
	
	//좋아요 등록
	public int insertLike(BoardLikeVO boardLikeVO) {
		return sql.insert("boardDAO.insertLike", boardLikeVO);
	}
	
	//좋아요 삭제 
	public int deleteLike(BoardLikeVO boardLikeVO) {
		return sql.delete("boardDAO.deleteLike", boardLikeVO);
		
	}
	//파일 가져오기
	public BoardFileVO getFile(int idx) {
		return sql.selectOne("boardDAO.getFile",idx);
	}
	
	
	
	
}
