<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>read Page</h1>
<div id="info">
	<table>
		
		<tbody>
			<tr>
				<th>제목</th>
				<td>{{info.title}}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>{{info.writer}}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>{{info.createDate}}</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>{{info.hit}}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>{{info.content}}</td>
			</tr>
		
		</tbody>
	
	</table>
	
	<div class="btn">
		<button type="button" @click="update">수정</button>
		<button type="button" @click="del">삭제</button>
		<button type="button" @click="goList">목록</button>
	
	</div>
</div>
<script>
let vue = new Vue({
	el: "#info",
	data: {
		info: ${board},
	},
	methods: {

		//수정
		update: function() {
			location.href="/board/upsert.do?idx="+this.info.idx;
		},

		//삭제
		del: function() {
			var vue = this;
				if(!confirm('삭제하시겠습니까?')) return false;

				console.log(JSON.stringify(vue.info));
				$.ajax({
					url : '/board/json/del.ajax',
					contentType : "application/json; charset=UTF-8",
					method : 'POST',
					data : JSON.stringify(vue.info),
					dataType : 'json',
					success : function(data) {
						alert('삭제 완료');
						vue.goList();
					},
					error : function(e) {
						console.log(e);
						alert('에러 발생\n관리자에게 문의하세요.');
					},

				});
			
		},

		goList: function() {
			console.log("크릭");
			location.href="/board/list.do";				
			},
	},
});

</script>
