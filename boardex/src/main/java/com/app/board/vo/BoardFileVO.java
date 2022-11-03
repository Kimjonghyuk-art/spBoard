package com.app.board.vo;

import java.util.Date;

public class BoardFileVO {
	
	// Fields
	private int fileNo;
	private String fileOriginalName;
	private String fileStoredName;
	private String fileContentType;
	private Date fileUploadDate;
	private String filePath;
	private int idx;
	
	// Getters & Setters
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public String getFileOriginalName() {
		return fileOriginalName;
	}
	public void setFileOriginalName(String fileOriginalName) {
		this.fileOriginalName = fileOriginalName;
	}
	public String getFileStoredName() {
		return fileStoredName;
	}
	public void setFileStoredName(String fileStoredName) {
		this.fileStoredName = fileStoredName;
	}
	public String getFileContentType() {
		return fileContentType;
	}
	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}
	public Date getFileUploadDate() {
		return fileUploadDate;
	}
	public void setFileUploadDate(Date fileUploadDate) {
		this.fileUploadDate = fileUploadDate;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
}
