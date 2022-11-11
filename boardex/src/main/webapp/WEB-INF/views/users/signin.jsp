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
			<h1>로그인 페이지</h1>
			<form action="/users/login.do" method="post">
				<div class="mb-3 row">
					<label for="userId" class="col-sm-2 col-form-label">아이디</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="userId" name="userId" v-model="userId" @keypress.enter.prevent>
					</div>
				</div>

				<div class="mb-3 row">
					<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="userPw"
						name="userPw" v-model="pw" @keypress.enter.prevent @keyup.enter.prevent @keydown.enter.prevent>
						<a href="/users/passwordreset.do" class="fs-6">Forgot password?</a>
					</div>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
					
				<div class="">
					<button type="submit" class="btn btn-primary">로그인</button>
					<button type="button" class="btn btn-primary"
						onclick="location.href='/users/signuppage.do'">회원가입</button>
				</div>

			</form>
		</div>
	</div>
</div>

<script>
let vue = new Vue({
	el: "#formWrapper",
	data: {
		userId: "",
		pw: "",
	},
	methods: {
		
		submitForm() {
			console.log("서브밋폼");
			const userData = {
					email: this.email,
					pw: this.pw,
			}
			console.log(userData);
		
			
		},
	}
	
});


</script>




