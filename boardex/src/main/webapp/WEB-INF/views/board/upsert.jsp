<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<style>
	#write {
		width:78%;
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
	.contentarea {
		border: none;
		resize: none;	
	}
	.contentarea:focus {
		outline : none;
	}
	.floatRight {
		float: right;
	}
	input[type=text] {
		border : none;
		
	}
	input[type=text]:focus {
		outline : none;
	}
	
</style>
<div id="write">
<h1>upsert Page</h1>
<div id="formWrapper">
	<form id="fileForm" enctype="multipart/form-data" method="POST">
		<input type="hidden" id="idx" name="idx" v-model="info.idx">
		
		
		<table class="table">
			<tbody>
				<tr>
					<th class="table-active">제목</th>
					<td><input type="text" id="title" name="title" v-model="info.title"></td>
				</tr>
				<tr>
					<th class="table-active">작성자</th>
					<td><input type="text" id="writer" name="writer" v-model="userId" readonly></td>
				</tr>
				<tr>
					<th class="table-active">내용</th>
					<td><textarea cols="80" rows="10" type="text" id="content" name="content" v-model="info.content" class="contentarea"></textarea></td>
				</tr>
				<tr>
					<th class="table-active">파일</th>
					<td><input type="file" id="uploadFile" name="uploadFile"> 
						<div v-if="file != null">
							{{file.fileOriginalName}}
						</div>
						
					</td>
				</tr>
			</tbody>
		
		</table>
		<div class="floatRight">
			<button type="button" @click="upsert" class="btn btn-primary">등록</button>
			<button type="button" @click="cancel" class="btn btn-primary">취소</button>
		</div>
	</form>
</div>


</div>

<script>
	let vue = new Vue({
		el: "#write",
		data: {
			userId : ${userName},
			info : ${board},
			file : ${file},
		},
		methods: {
		
		// 유효성 검사
			formChck: function() {
				if(this.info.title == null || this.info.title == '') {
					alert('제목을 입력해주세요.');
					$("#title").focus();
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
					
				
				console.log("check");
				formData.append("file", $("input[name=uploadFile]")[0].files[0]);					
				console.log(formData)
				$.ajax({
					url : '/board/json/upsert.ajax',
					contentType : false,
					processData : false,
					type : 'POST',
					data : formData,
					beforeSend: function(xhr){
						xhr.setRequestHeader(header, token);
				    },
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

