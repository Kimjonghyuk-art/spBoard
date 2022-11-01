<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<style>
	#write {
		width:50%;
		margin: 0 auto;
	}

	#formWrapper {
		width: 100%;
	}
	#formWrapper label {
		font-weight: bold;
		color: pink;
	}
	#formWrapper input {
		width: 80%;
	}
</style>
<div id="write">
<h1>upsert Page</h1>
<div id="formWrapper">
	<form id="fileForm" enctype="multipart/form-data" method="POST">
		<div>
			<label>제목</label>
			<input type="text" id="title" name="title" v-model="info.title">
		</div>
		<div>
			<label>작성자</label>
			<input type="text" id="writer" name="writer" v-model="info.writer">
		</div>
		<div>
			<label>내용</label>
			<input type="text" id="content" name="content" v-model="info.content">
		</div>
		<div>
			<label>파일</label>
			<input type="file" id="uploadFile" name="file">
		</div>
		<button type="button" @click="upsert">등록</button>
	</form>
</div>
<!-- <table>
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
</div> -->

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
				let form = $("#fileForm")[0];
				let formData = new FormData(form);
				formData.append("file", $("input[name=file]")[0].files[0]);
				$.ajax({
					url : '/board/json/upsert.ajax',
					contentType : false,
					processData : false,
					type : 'POST',
					data : formData,
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

