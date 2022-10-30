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
					$("#updtNm").focus();
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
				
				$.ajax({
					url : '/board/json/upsert.ajax',
					contentType : "application/json; charset=UTF-8",
					method : 'POST',
					data : JSON.stringify(vue.info),
					dataType : 'json',
					success : function(data) {
						alert('등록 완료');
						vue.goList();
					},
					error : function(e) {
						console.log(e);
						alert('에러 발생\n관리자에게 문의하세요.');
					},

				});
				
				
			},

			cancel: function() {
			if(!confirm('등록을 취소하시겠습니까?')) return false;
				location.href="/board/list.do"
			}
		}
	});

</script>
