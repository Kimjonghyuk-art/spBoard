<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.inline {
	display: inline-block;
}

.contentarea {
	border: none;
	resize: none;
}

.contentarea:focus {
	outline: none;
}

.replyarea {
	border: none;
	resize: none;
}

.inputBorder {
	border: none;
}

.inputBorder:focus {
	outline: none;
}
</style>
<h1>read Page</h1>
<div id="info">
	<input type="hidden" id="boardNo" v-model="info.idx">
	<input type="hidden" id="loginUserId" v-model="userId">
	<table class="table">
		<tbody>
			<tr>
				<th class="table-active">제목</th>
				<td>{{info.title}}</td>
			</tr>
			<tr>
				<th class="table-active">작성자</th>
				<td>{{info.writer}}</td>
			</tr>
			<tr>
				<th class="table-active">작성일</th>
				<td>{{info.createDate}}</td>
			</tr>
			<tr>
				<th class="table-active">조회수</th>
				<td>{{info.hit}}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="10" cols="120" class="contentarea" readonly>{{info.content}}</textarea></td>
			</tr>
			<tr>
				<th><button type="button" id="likeBtn" @click="like"
						class="btn btn-primary">좋아요♥</button></th>
				<td><input type="text" class="inputBorder"
					v-model="info.likeNo"></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
					<div v-if="file != null">
						<a href="#" @click="download">{{file.fileOriginalName}}</a>
					</div>
					<div v-else>첨부파일 없음</div>
				</td>
			</tr>
		</tbody>

	</table>

	<div id="reply" style="width: 100%;">
		<table id ="reply-table"class="table">
			<tbody>
				
			</tbody>
		</table>
	
		<!-- <div v-for="item in reply">
			<span>{{item.writer}}</span>
			<span>{{item.content}}</span>
			<span class="fs-6">{{item.replyDate}}</span>
		</div> -->


	</div>
<!-- 컴포넌트 -->
<%-- <jsp:include page="/WEB-INF/views/board/component/reply.jsp" /> --%> 

<!-- <reply></reply>  -->
	<!-- <hr>
	<span>댓글작성</span>
	<textarea id="replyContent" name="replyContent" v-model="replyContent"
		rows="5" cols="130"></textarea>
	<button type="button" class="btn btn-primary" @click="insertReply">등록</button>
	<hr> -->
	



	<div class="">
		<div v-if="info.writer == userId" class="inline">
			<button type="button" @click="update" class="btn btn-primary">수정</button>
			<button type="button" @click="del" class="btn btn-primary">삭제</button>
		</div>
		<button type="button" @click="goList" class="btn btn-primary">목록</button>

	</div>
	
	

	
</div>
<script>

$("document").ready(function(){
		//댓글 조회
		findAllReply();
		
		//댓글 테이블 수정,삭제 이벤트
		
		replyUDevent();
		
});

function findAllReply() {
	
	let boardNo = $("#boardNo").val();
	
	$.ajax({
				 	url : '/reply/json/findallreply.ajax',
				 	contentType : "application/json; charset=UTF-8",
				 	method : 'POST',
				 	data : JSON.stringify({boardNo:boardNo}),
				 	dataType : 'json',
				 	beforeSend: function(xhr){
						xhr.setRequestHeader(header, token);
					   },
				 	success : function(data) {
				 		console.log("data: " + JSON.stringify(data));
				 		$("#reply-table tbody tr").remove();
				 
				 		for (obj of data) {
				 					replyMakeRow(obj);
				 	      }
				 	},
				 	error : function(e) {
				 		
				 		alert('에러 eee');
				 	},

				 });

};



function replyMakeRow(obj) {
	loginUser = $("#loginUserId").val();
	console.log(`udx->${idx}`);
	let node;
	node += "<tr>";
	node += "<input type='hidden'>"
	node += "<td>"+obj.writer+"</td>";
	node += "<td style='width:70%;'>"+obj.content+"</td>";
	node += "<td>"+obj.replyDate+"</td>";
	
	if(loginUser == obj.writer) {
		node+= "<td><button type='button'>수정</button></td>"
		node+= "<td><button type='button'>삭제</button></td>"
	};
	node += "</tr>"
	
	$("#reply-table tbody").append(node);
	$("#reply-table tbody tr").find('input[type=hidden]').last().val(obj.replyNo);
};



function replyUDevent() {
	$("#reply-table tbody").on("click", "tr", function(e) {
		
		let element = e.target.tagName;
		
		if(element != "BUTTON") return;
		
		console.log(e.target.textContent);
		
		if(e.target.textContent == '수정') {
			replyInclude();
			
		} else if(e.target.textContent == '삭제') {
			let replyNo = $(this).find("input[type=hidden]").val();
			delReply(replyNo);
		}
		
	});
}


function delReply(replyNo) {
	console.log("삭제실행");
	let replyData = {replyNo : replyNo};
	
	 $.ajax({
		 	url : '/reply/json/delreply.ajax',
		 	contentType : "application/json; charset=UTF-8",
		 	method : 'POST',
			async: false,
		 	data : JSON.stringify(replyData),
		 	dataType : 'json',
		 	beforeSend: function(xhr){
				xhr.setRequestHeader(header, token);
			   },
		 	success : function(data) {
		 		alert('삭제 완료');
		 		findAllReply();
		 	},
		 	error : function(e) {
		 		console.log(e);
		 		alert('삭제에러 발생');
		 	},

		 });
	
	
}


function replyInclude() {

}

	

let vue = new Vue({
	el: "#info",
	data: {
		userId: ${userId},
		info: ${board},
		file: ${file},
		reply: ${reply},
		//replyContent: "",
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
				 	beforeSend: function(xhr){
						xhr.setRequestHeader(header, token);
					   },
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
				 	beforeSend: function(xhr){
						xhr.setRequestHeader(header, token);
					   },
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
													userId : vue.userId};
					$.ajax({
						url : '/board/json/findlike.ajax',
						contentType : "application/json; charset=UTF-8",
						method : 'POST',
						data : JSON.stringify(findLikeObj),
						dataType : 'json',
						beforeSend: function(xhr){
							xhr.setRequestHeader(header, token);
						   },
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
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
										   },
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
										beforeSend: function(xhr){
											xhr.setRequestHeader(header, token);
										   },
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

			download: function() {
				//e.preventDefault(); 
				let vue = this;
				location.href="/board/downloadtest.do?idx="+vue.info.idx;
				
			},
			//댓글 등록
			insertReply: function() {
				var vue = this;
				
				let replyData = {
					boardNo : vue.info.idx,
					content : this.replyContent,
					writer : this.userId
				};
				console.log(JSON.stringify(replyData));
				
			 	$.ajax({
				 	url : '/reply/json/insertreply.ajax',
				 	contentType : "application/json; charset=UTF-8",
				 	method : 'POST',
				 	data : JSON.stringify(replyData),
				 	dataType : 'json',
				 	beforeSend: function(xhr){
						xhr.setRequestHeader(header, token);
					   },
				 	success : function(data) {
				 		alert('댓글 등록완료');
				 		$("#replyContent").val('');
				 		findAllReply();
								
				 		},
				 		error : function(e) {
					 		console.log(e);
					 		alert('에러 발생\n관리자에게 문의하세요.');
				 		},

				 	});
				
			},


	},

});

</script>
