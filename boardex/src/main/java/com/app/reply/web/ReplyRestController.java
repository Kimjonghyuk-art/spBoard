package com.app.reply.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.app.reply.service.ReplyService;
import com.app.reply.vo.ReplyVO;

@RestController
@RequestMapping("/reply/json")
public class ReplyRestController {

	@Resource(name="replyService")
	private ReplyService replyService;
	
	//댓글 등록
	@RequestMapping("/insertreply.ajax")
	public ModelAndView insertReply(@RequestBody ReplyVO replyVO) {
		ModelAndView mav = new ModelAndView("jsonView");
		
		replyService.insertReply(replyVO);
		return mav;
	}

	//댓글 조회
	@RequestMapping("/findallreply.ajax")
	public ModelAndView findallReply(@RequestBody ReplyVO replyVO) {
		ModelAndView mav = new ModelAndView("jsonView");
		//replyService.findAllReply(replyVO);
		mav.addObject("reply",replyService.findAllReply(replyVO));
		return mav;
	}

	//댓글 삭제
	@RequestMapping("/delreply.ajax")
	public ModelAndView delReply(@RequestBody ReplyVO replyVO) {
		ModelAndView mav = new ModelAndView("jsonView");
			replyService.delReply(replyVO);
		return mav;
	}



}
