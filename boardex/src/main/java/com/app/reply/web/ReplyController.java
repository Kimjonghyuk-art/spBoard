package com.app.reply.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.app.reply.service.ReplyService;

@Controller
@RequestMapping("/users/reply")
public class ReplyController {

	
	@Resource(name = "replyService")
	private ReplyService replyService;
}
