<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#container {
width: 50%;
margin: 0 auto;
}
#formWrapper {
width:100%;
text-align: center;
}

</style>

<div id="container">
	<div id="formWrapper">
	<h1>로그인 페이지</h1>	
		<form action="/users/login.do" method="post">
			<div>
				<label>아이디</label>
				<input type="text" id="userId" name="userId" v-model="userId" placeholder="id">
			</div>
			<div>
				<label>비밀번호</label>
				<input type="password" id="userPw" name="userPw" v-model="pw" placeholder="비밀번호를 입력하세요">
			</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<div class="btn">
				<button type="submit">로그인</button>
				<button type="button" onclick="location.href='/users/signuppage.do'">회원가입</button>	
			</div>
			
		</form>
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




