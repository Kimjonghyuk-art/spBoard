package com.board.app.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.board.app.dao.BoardDAO;
import com.board.app.vo.BoardFileVO;
import com.board.app.vo.BoardLikeVO;
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
	
	public BoardFileVO fileUpsertAction(BoardFileVO boardFileVO) {
		boardDAO.fileUpsert(boardFileVO);
		return boardFileVO;
		
	}
	

	//게시판 목록 갯수 조회
	public int getBoardsCnt(BoardVO boardVO) {
		return boardDAO.getBoardsCnt(boardVO);
	}
	
	//게시글 최대번호 조회
	public int getMaxIdx() {
		return boardDAO.getMaxIdx();
	}
	
	//좋아요 눌렀는지 확인 여부
	public int findLike(BoardLikeVO boardLikeVO) {
		int result = boardDAO.findLike(boardLikeVO);
		return result;
	}

	//좋아요 등록
	public BoardLikeVO insertLike(BoardLikeVO boardLikeVO) {
		boardDAO.insertLike(boardLikeVO);
		return boardLikeVO;
	}
	//좋아요 삭제
	public BoardLikeVO deleteLike(BoardLikeVO boardLikeVO) {
		boardDAO.deleteLike(boardLikeVO);
		return boardLikeVO;
	}

	//파일 가져오기
	public BoardFileVO getFile(int idx) {
		return boardDAO.getFile(idx);
	}
	

	
}
