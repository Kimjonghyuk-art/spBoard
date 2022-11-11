<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
#container {
	width: 50%;
	margin: 0 auto;
}

#formWrapper {
	text-align: center;
}

</style>

<div id="container">
	<div id="formWrapper">
		<div class="">
			<h1>비밀번호 찾기 페이지</h1>
			<!-- <form method="post" action="/users/sendemail.do"> -->
			
				<div class="mb-3 row">
					<label for="userId" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="userId" name="userId" v-model="userId">
					</div>
				</div>
				
				<div class="mb-3 row">
					<label for="email" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="email" name="email" v-model="email" placeholder="enter your email adress">
					</div>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
					
				<div class="">
					<button type="submit" class="btn btn-primary" @click="sendEmail">전송</button>
		
				</div>
			<!-- </form> -->
		</div>
	</div>
</div>

<script>
let vue = new Vue({
	el: "#formWrapper",
	data: {
		email : "",
		userId: "",
	},
	methods: {
		sendEmail: function() {
	
			let data = {email: this.email
						,userId : this.userId};
			let email = this.email;
			let userId = this.userId;
			console.log(JSON.stringify(data));
			
			$.ajax({
				url : '/users/json/sendemail.ajax',
				method : 'POST',
				data : {userId : userId,email: email},
				dataType : 'json',	
				beforeSend: function(xhr){
					xhr.setRequestHeader(header, token);
				   },
				success : function(data) {
					alert("전송완료!");
					location.href="/"; 
				},
				error : function(e) {
					console.log(e);
					alert('에러 eee');
				},
				
			}); 
			
		},
	
	}
	
});


</script>




