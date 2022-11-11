package com.app.board.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.security.Principal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.board.service.BoardService;
import com.app.board.vo.BoardFileVO;
import com.app.board.vo.BoardVO;
import com.app.reply.service.ReplyService;
import com.app.reply.vo.ReplyVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysema.commons.lang.URLEncoder;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@Resource(name="replyService")
	private ReplyService replyService;
	
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
	public String read(Model model,BoardVO boardVO, Principal principal) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		String userId = principal.getName();
		//조회수 증가
		boardService.boardHitUp(boardVO);
		BoardVO vo = boardService.getBoard(boardVO);
		ReplyVO replyVO = new ReplyVO();
		replyVO.setBoardNo(boardVO.getIdx());
		;
		model.addAttribute("reply", mapper.writeValueAsString(replyService.findAllReply(replyVO)));
		model.addAttribute("userId", mapper.writeValueAsString(userId));
		model.addAttribute("board",mapper.writeValueAsString(vo));
		model.addAttribute("file",mapper.writeValueAsString(boardService.getFile(boardVO.getIdx())));
		
		return "board/read.tiles";
	}
	
	//글쓰기 페이지 이동
	@RequestMapping("/upsert.do")
	public String upsert(@ModelAttribute BoardVO boardVO, Model model,Principal principal) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		BoardFileVO boardFileVO = boardService.getFile(boardVO.getIdx());
		String userName = principal.getName();
		model.addAttribute("userName", mapper.writeValueAsString(userName));
		model.addAttribute("board",mapper.writeValueAsString(boardService.upsert(boardVO)));
		model.addAttribute("file",mapper.writeValueAsString(boardFileVO));
		return "board/upsert.tiles";
	}
	
	@RequestMapping("/downloadtest.do")
	public void downloadTest(HttpServletResponse response,@RequestParam int idx) throws Exception {
		
		System.out.println(idx);
		BoardFileVO boardFileVO = boardService.getFile(idx);
		
		//String path = "C:/Temp/349bc87c15ba490b868eb8d0364470b8계약현황.xlsx";
		String path = boardFileVO.getFilePath();
		File file = new File(path);
		
		String fileName = URLEncoder.encodeURL(boardFileVO.getFileOriginalName());
		fileName = fileName.replaceAll("\\+", "%20");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName +"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Type", boardFileVO.getFileContentType());
		
		
		FileInputStream fileInputStream = new FileInputStream(path); // 파일 읽어오기
		OutputStream out = response.getOutputStream();

		int read = 0;
		byte[] buffer = new byte[1024];
		while ((read = fileInputStream.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이
																// 없음
			out.write(buffer, 0, read);
		}
	}
	
	
	
}
