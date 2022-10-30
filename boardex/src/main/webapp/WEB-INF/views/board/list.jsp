<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    


<h1>list Page</h1>
<div id="content">

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
			<tr v-for="item in list">
				<td>{{item.idx}}</td>
					<td>{{item.title}}</td>
					<td>{{item.writer}}</td>
					<td>{{item.createDate}}</td>
					<td>{{item.hit}}</td>
			</tr>
		</tbody>

	</table>
	<div class="btn">
		<button type="button" @click="write">글쓰기</button>

	</div>
</div>
<script>
$( document ).ready(function() {
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
	},
	methods: {
		write: function() {
			location.href ="/board/upsert.do";
		}

	},
});

</script>
