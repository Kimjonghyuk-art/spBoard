package com.board.app.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.board.app.dao.BoardDAO;
import com.board.app.vo.BoardVO;


@Service("boardService")
public class BoardService {

	@Resource(name="boardDAO")
	private BoardDAO boardDAO;
	
	//전체 조회
	public List<BoardVO> findAllBoards(BoardVO boardVO) {
		 return boardDAO.findAllBoards(boardVO);
	}
	
	//상세 조회
	public BoardVO getBoard(BoardVO boardVO) {
		return boardDAO.getBoard(boardVO);
	}
	
	//삭제
	public int delBoard(BoardVO boardVO) {
		return boardDAO.delBoard(boardVO);
	}
	
	public BoardVO upsert(BoardVO boardVO) throws Exception {
		BoardVO vo = new BoardVO();
		if(boardVO.getIdx() != 0) {
			vo = boardDAO.getBoard(boardVO);
		}
		return vo;
	}
	
	//수정 및 등록 처리
	public BoardVO upsertAction(BoardVO boardVO) {
		if(boardVO.getIdx() == 0) {
			boardVO.setIdx(boardDAO.getMaxIdx() + 1);
		}
		boardDAO.upsert(boardVO);
		return boardVO;
	}

	//게시판 목록 갯수 조회
	public int getBoardsCnt(BoardVO boardVO) {
		return boardDAO.getBoardsCnt(boardVO);
	}

	
}
