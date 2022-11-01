package com.board.app.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.board.app.service.BoardService;
import com.board.app.vo.BoardVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	//전체 조회 페이지
	@GetMapping("/list.do")
	public String list(Model model,BoardVO boardVO) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		
		boardVO.setPerPage(5);
		boardVO.setPagingCnt(3);
		int totalCnt = boardService.getBoardsCnt(boardVO);
		boardVO.setTotalCnt(totalCnt);
		
		model.addAttribute("list", mapper.writeValueAsString(boardService.findAllBoards(boardVO)));
		model.addAttribute("page", mapper.writeValueAsString(boardVO));
		return "board/list.tiles";
	}
	
	//상세 조회 페이지 
	@GetMapping("/read.do")
	public String read(Model model,BoardVO boardVO) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("board",mapper.writeValueAsString(boardService.getBoard(boardVO)));
		return "board/read.tiles";
	}
	
	//글쓰기 페이지 이동
	@RequestMapping("/upsert.do")
	public String upsert(@ModelAttribute BoardVO boardVO, Model model) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		model.addAttribute("board",mapper.writeValueAsString(boardService.upsert(boardVO)));
		return "board/upsert.tiles";
	}
	
}
