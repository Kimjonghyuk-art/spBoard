package com.board.app.web;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.board.app.service.BoardService;
import com.board.app.vo.BoardVO;


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
	public ModelAndView upsert(@RequestBody BoardVO boardVO) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");
		boardService.upsertAction(boardVO);
		return mav;
	}
	
}
