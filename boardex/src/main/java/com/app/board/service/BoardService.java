package com.app.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.app.board.dao.BoardDAO;
import com.app.board.vo.BoardFileVO;
import com.app.board.vo.BoardLikeVO;
import com.app.board.vo.BoardVO;
import com.app.login.service.LoginService;


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
	
	public BoardFileVO fileUpsert(BoardFileVO boardFileVO) throws Exception {
		BoardFileVO vo = new BoardFileVO();
		if(boardFileVO.getFileNo() != 0) {
			vo = boardDAO.getFile(boardFileVO.getIdx());
		}
			return vo;
	}
	
	//수정 및 등록 처리
	public BoardVO upsertAction(BoardVO boardVO) {
		if(boardVO.getIdx() == 0) {
			System.out.println("####신규등록####");
			boardVO.setIdx(boardDAO.getMaxIdx() + 1);
		}
		boardDAO.upsert(boardVO);
		return boardVO;
	}
	//파일 수정 및 등록 처리
	public BoardFileVO fileUpsertAction(BoardFileVO boardFileVO) {
		if(boardFileVO.getFileNo() == 0) {
			System.out.println("####file신규등록####");
			boardFileVO.setFileNo(boardDAO.getMaxIdx() + 1);
		}
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
	
	//좋아요 숫자 조회
	public int getLikeCnt(int BoardIdx) {
		return boardDAO.getLikeCnt(BoardIdx);
	}

	//파일 가져오기
	public BoardFileVO getFile(int idx) {
		return boardDAO.getFile(idx);
	}
	//파일 삭제
	public int delFile(int fileNo) {
		return boardDAO.delFile(fileNo);
	}
	//파일 최대번호 조회
	public int getMaxFileNo() {
		return boardDAO.getMaxFileNo();
	}
	//조회수 증가
	public int boardHitUp(BoardVO boardVO) {
		return boardDAO.boardHitUp(boardVO);
		
	}
	
	

	
}
