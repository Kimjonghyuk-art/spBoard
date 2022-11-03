package com.app.board.vo;

import java.util.Date;

import lombok.Data;
@Data
public class BoardFileVO {
	
	// Fields
	private int fileNo;
	private String fileOriginalName;
	private String fileStoredName;
	private String fileContentType;
	private Date fileUploadDate;
	private String filePath;
	private int idx;
	
	
	
}
