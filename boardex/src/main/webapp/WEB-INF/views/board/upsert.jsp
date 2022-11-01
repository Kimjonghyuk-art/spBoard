<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="write">
<h1>upsert Page</h1>

<table>
	<tbody>
		<tr>
			<th>제목</th>
			<td><input type="text" id="title" name="title" placeholder="제목을 입력해주세요." v-model="info.title"></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" id="writer" name="writer" placeholder="작성자를 입력해주세요." v-model="info.writer"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><input type="text" id="content" name="content" placeholder="내용을 입력해주세요." v-model="info.content"></td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td><input type="file" id="uploadFile" name="uploadFile" @change="changeFile"></td>
		</tr>
	</tbody>

</table>


<div class="btn">
	<button type="button" @click="upsert">등록</button>
	<button type="button" @click="cancel">취소</button>
</div>

</div>

<script>
	let vue = new Vue({
		el: "#write",
		data: {
			info : ${board},
		},
		methods: {
		
		// 유효성 검사
			formChck: function() {
				if(this.info.title == null || this.info.title == '') {
					alert('제목을 입력해주세요.');
					$("#title").focus();
					return false;
				} else if(this.info.writer == null || this.info.writer == '') {
					alert('작성자를 입력해주세요.');
					$("#writer").focus();
					return false;
				} else if(this.info.content == null || this.info.content == '') {
					alert('내용을 입력해주세요.');
					$("#content").focus();
					return false;
				}
				return true;
			},

			upsert: function() {
				let vue = this;
				if(!this.formChck()) return;
				let formData = new FormData();
				console.log(vue.info.title);
				console.log(vue.info.writer);
				console.log(vue.info.content);
				console.log(vue.info.uploadFile);
				formData.append('title', vue.info.title);
				formData.append('writer', vue.info.writer);
				formData.append('content', vue.info.content);
				formData.append('uploadFile', vue.info.uploadFile);
				$.ajax({
					url : '/board/json/upsert.ajax',
					contentType : "application/json; charset=UTF-8",
					method : 'POST',
					data : JSON.stringify(vue.info),formData,
					dataType : 'json',
					success : function(data) {
						alert('등록 완료');
						location.href="/board/list.do";
					},
					error : function(e) {
						console.log(e);
						alert('에러');
					},

				});
				
				
			},

			cancel: function() {
			if(!confirm('등록을 취소하시겠습니까?')) return false;
				location.href="/board/list.do"
			},
			changeFile: function(e) {
				let vue = this;
				vue.info.uploadFile = e.target.files[0];
				console.log(e.target.files[0]);
			}
		}
	});

</script>

