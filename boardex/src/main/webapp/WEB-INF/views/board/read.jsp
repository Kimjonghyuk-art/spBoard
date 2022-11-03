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
			<tr>
				<th><button type="button" id="likeBtn" class="" @click="like">좋아요♥</button></th>
				<td><input type="text" v-model="info.likeNo"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<div v-if="file != null">
					<a href="#" @click="download">{{file.fileOriginalName}}</a>
				</div>
					<div v-else>
						첨부파일 없음
					</div>
				</td>
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

$("document").ready(function(){
	

})

let vue = new Vue({
	el: "#info",
	data: {
		info: ${board},
		file: ${file},
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
				if(vue.file != null ) {
					let obj = {fileNo : vue.file.fileNo,
										idx : vue.info.idx};
					console.log(JSON.stringify(obj));
				 $.ajax({
				 	url : '/board/json/delfile.ajax',
				 	contentType : "application/json; charset=UTF-8",
				 	method : 'POST',
					async: false,
				 	data : JSON.stringify(obj),
				 	dataType : 'json',
				 	success : function(data) {
				 		//alert('삭제 완료');
				 	},
				 	error : function(e) {
				 		console.log(e);
				 		alert('파일 삭제에러 발생');
				 	},

				 });
				 }

				
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
				 		alert('글 삭제에러 발생');
				 	},

				 });
			
				


			
		},

		goList: function() {
			console.log("크릭");
			location.href="/board/list.do";				
			},


			like: function() {
				let vue = this;

				let findLikeObj = {boardIdx : vue.info.idx,
													userId : localStorage.getItem("temporary user")};
					$.ajax({
						url : '/board/json/findlike.ajax',
						contentType : "application/json; charset=UTF-8",
						method : 'POST',
						data : JSON.stringify(findLikeObj),
						dataType : 'json',
						success : function(data) {
							console.log(data.toString());
							if(data.toString() == '0') {
								//좋아요 등록
								console.log("좋아요 등록")
								//insertLike(findLikeObj);
									//인설트
									$.ajax({
										url : '/board/json/insertlike.ajax',
										contentType : "application/json; charset=UTF-8",
										method : 'POST',
										data : JSON.stringify(findLikeObj),
										dataType : 'json',
										success : function(data) {
											alert('좋아요 등록완료');
											console.log("좋아요 데이터->"+data);
											vue.info.likeNo = data;
										},
										error : function(e) {
											console.log(e);
											alert('에러 발생\n관리자에게 문의하세요.');
										},

									});

							} else {
								console.log("좋아요 삭제 ")
								//좋아요 삭제
								//deleteLike(findLikeObj);

								$.ajax({
										url : '/board/json/deletelike.ajax',
										contentType : "application/json; charset=UTF-8",
										method : 'POST',
										data : JSON.stringify(findLikeObj),
										dataType : 'json',
										success : function(data) {
											alert('좋아요 취소완료');
											vue.info.likeNo = data;
										},
										error : function(e) {
											console.log(e);
											alert('에러 발생\n관리자에게 문의하세요.');
										},
				
									});
							}

							
						},
						error : function(e) {
							console.log(e);
							alert('에러 발생\n관리자에게 문의하세요.');
						},

					});


			},


			// insertLike: function(findLikeObj) {
			// 		//인설트
			// 		$.ajax({
			// 			url : '/board/json/insertlike.ajax',
			// 			contentType : "application/json; charset=UTF-8",
			// 			method : 'POST',
			// 			data : JSON.stringify(findLikeObj),
			// 			dataType : 'json',
			// 			success : function(data) {
			// 				alert('좋아요 등록완료');
							
			// 			},
			// 			error : function(e) {
			// 				console.log(e);
			// 				alert('에러 발생\n관리자에게 문의하세요.');
			// 			},

			// 		});
			// },
			// deleteLike: function(findLikeObj) {
			// 	//딜리트
			// 	$.ajax({
			// 			url : '/board/json/deletelike.ajax',
			// 			contentType : "application/json; charset=UTF-8",
			// 			method : 'POST',
			// 			data : JSON.stringify(findLikeObj),
			// 			dataType : 'json',
			// 			success : function(data) {
			// 				alert('좋아요 취소완료');
							
			// 			},
			// 			error : function(e) {
			// 				console.log(e);
			// 				alert('에러 발생\n관리자에게 문의하세요.');
			// 			},

			// 		});
			// },

			download: function() {
				//e.preventDefault(); 
				let vue = this;
				location.href="/board/downloadtest.do?idx="+vue.info.idx;
				
			}




	},

});

</script>
