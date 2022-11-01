package com.board.app.web;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.board.app.service.BoardService;
import com.board.app.vo.BoardVO;
import com.fasterxml.jackson.databind.ObjectMapper;


@RestController
@RequestMapping("/board/json")
public class BoardRestController {

	@Resource(name="boardService")
	private BoardService boardService;
	
	//삭제
	@RequestMapping("/del.ajax")
	public ModelAndView del(@RequestBody BoardVO boardVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		boardService.delBoard(boardVO);
		return mav;
	}
	
	//등록 및 수정
	@RequestMapping("/upsert.ajax")
	public ModelAndView upsert(@RequestBody BoardVO boardVO, @RequestParam MultipartFile uploadData) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		
		
		//boardService.upsertAction(boardVO);
		return mav;
	}
	
	//게시판 페이징 이동
	@RequestMapping("/list.ajax")
	public ModelAndView list(@RequestBody BoardVO boardVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		ObjectMapper mapper = new ObjectMapper();
		
		int totalCnt = boardService.getBoardsCnt(boardVO);
		boardVO.setTotalCnt(totalCnt);
		
		mav.addObject("list",mapper.writeValueAsString(boardService.findAllBoards(boardVO)));
		mav.addObject("page",mapper.writeValueAsString(boardVO));
		return mav;
	}
	
}
