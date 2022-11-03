package com.app.board.vo;

import com.app.board.common.Pagination;

import lombok.Data;

@Data
public class BoardVO extends Pagination{

	private int idx;
	private String writer;
	private String title;
	private String content;
	private String createDate;
	private int hit;
	private int likeNo;
	private int fileNo;
	
	
	
	
}
