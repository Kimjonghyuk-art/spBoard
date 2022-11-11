package com.app.reply.vo;

import lombok.Data;

@Data
public class ReplyVO {

	private int replyNo;
	private int boardNo;
	private int parentNo;
	private int dept;
	private String content;
	private String replyDate;
	private String writer;
	
	
}
