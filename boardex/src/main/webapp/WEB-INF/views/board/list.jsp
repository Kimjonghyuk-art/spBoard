<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    



<h1>list Page</h1>
<div id="content">

<div class="searchForm">
	<select name="searchType" id="searchType" v-model="page.searchType">
		<option value="">전체</option>
		<option value="title">제목</option>
		<option value="content">내용</option>
	</select>
	
	<input type="text" name="searchKeyword" id="searchKeyword" v-model="page.searchKeyword"
		@keyup.enter="goPage(1)">
	<button type="button" class="searchBtn" @click="goPage(1)">검색</button>
</div>
	

	<table id="board">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
			
		<tbody>
			<tr v-for="item in list" style="cursor:pointer;">
				<td>{{item.idx}}</td>
					<td>{{item.title}}</td>
					<td>{{item.writer}}</td>
					<td>{{item.createDate}}</td>
					<td>{{item.hit}}</td>
			</tr>
		</tbody>

	</table>
	<page :data-search="page" @pagingfn="goPage"></page>
	<div class="btn">
		<button type="button" @click="write">글쓰기</button>

	</div>
</div>

<!-- 컴포넌트 -->
<jsp:include page="/WEB-INF/views/board/component/pagination.jsp" />

<script>
$( document ).ready(function() {
	

	if (localStorage.getItem("temporary user") === null) {
			let randomStr = Math.random().toString(36).substring(2, 12);
			console.log(randomStr);
			localStorage.setItem("temporary user",randomStr);
			
			} 
			
  $("#board tbody tr").click(function() {
		console.log("click");
		let idx = $(this).find("td:eq(0)").text();
		console.log(idx);

		location.href="read.do?idx="+idx;
	});
});

let vue = new Vue({
	el: "#content",
	data: {
		list: ${list},
		page: ${page}
	},
	methods: {
		
		goPage: function(nowPage) {
			let vue = this;
			//console.log("이벤트 위임됌");
			this.page.nowPage = nowPage;
			//console.log("페이지->"+nowPage);
			//console.log(JSON.stringify(vue.page));
			 $.ajax({
				url : '/board/json/list.ajax',
				contentType : "application/json; charset=UTF-8",
				method : 'post',
				data : JSON.stringify(vue.page),
				dataType : 'json',	
				beforeSend: function(xhr){
					xhr.setRequestHeader(header, token);
				   },
				success : function(data) {
					vue.list = JSON.parse(data.list);
					
					let url = '/board/list.do';
					vue.page = JSON.parse(data.page);				
					let urlMap = new Map();
					//urlMap.set('url', url);
					urlMap.set('nowPage', vue.page.nowPage);
					urlMap.set('searchType',vue.page.searchType);
					urlMap.set('searchKeyword',vue.page.searchKeyword);
					changeURL(url,urlMap);
					//location.href= url;
				},
				error : function(e) {
					console.log(e);
					alert('에러 eee');
				},
				
			}); 
			
			
			
		},
		
		write: function() {
			location.href ="/board/upsert.do";
		}

	},
	
	mounted: function () {
		let vue = this;
	}
});

</script>
