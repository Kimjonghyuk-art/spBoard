package com.board.app.common;

public class Pagination {
	/* 검색관련 */
	private String searchType = "";		// 검색 타입
	private String searchKeyword = "";	// 검색어
	/* 검색관련 */
	
	/* 페이징 처리를 위해 외부에서 받아 오는 필드 값 */
	private int nowPage = 1;	// 현재 페이지 번호
	private int perPage = 10;	// 출력할 페이지(row) 갯수
	private int pagingCnt = 10;	// 화면에 표시할 페이징 번호 갯수
	private int totalCnt;		// 게시물 총 갯수

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getPagingCnt() {
		return pagingCnt;
	}

	public void setPagingCnt(int pagingCnt) {
		this.pagingCnt = pagingCnt;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	/* 페이징 처리를 위해 외부에서 받아 오는 필드 값 */
	
	/* 페이징 처리를 위해 계산되는 필드 값 */
	private int totalPagingCnt;		// 페이지 번호의 총갯수
	private int firstPage;			// 화면에 표시 되는 시작 페이지 번호
	private int lastPage;			// 화면에 표시 되는 마지막 페이지 번호
	private int startPage;			// SQL 페이징 처리 시작 번호
	private int endPage;			// 페이징 마지막 번호

	public int getTotalPagingCnt() {
		totalPagingCnt = ((getTotalCnt() - 1) / getPerPage()) + 1;
		return totalPagingCnt;
	}

	public int getFirstPage() {
		firstPage = ((getNowPage() - 1) / getPagingCnt()) * getPagingCnt() + 1;
		return firstPage;
	}

	public int getLastPage() {
		lastPage = getFirstPage() + getPagingCnt() - 1;
		if(lastPage > getTotalPagingCnt()) {
			lastPage = getTotalPagingCnt();
		}
		return lastPage;
	}

	public int getStartPage() {
		startPage = (getNowPage() - 1) * getPerPage();
		return startPage;
	}

	public int getEndPage() {
		endPage = (int) Math.ceil((double) getTotalCnt() / (double) getPerPage());
		return endPage;
	}
	/* 페이징 처리를 위해 계산되는 필드 값 */
}
