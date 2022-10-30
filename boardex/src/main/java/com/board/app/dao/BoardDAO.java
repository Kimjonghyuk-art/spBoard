package com.board.app.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
}
