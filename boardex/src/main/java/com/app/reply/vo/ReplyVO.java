package com.app.reply.vo;

import lombok.Data;

@Data
public class ReplyVO {

	private int replyNo;
	private int boardNo;
	private String parentNo;
	private int depth;
	private String content;
	private String replyDate;
	private String writer;
	
	
}
