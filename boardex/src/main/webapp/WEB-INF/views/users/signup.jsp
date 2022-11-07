<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#container {
width: 50%;
margin: 0 auto;
}
#formWrapper {
width:100%;.
text-align: center;
}

</style>
    
<div id="container">
	<div id="formWrapper">
	<h1>회원가입 페이지</h1>
		<form action="/users/signup.do" method="post">
			<div>
				<label>이메일</label>
				<input type="text" id="email" name="email" v-model="email" placeholder="aaa@bbb.ccc">
			</div>
			<div>
				<label>이름</label>
				<input type="text" id="userName" name="userName" v-model="userName" placeholder="이름">
			</div>
			<div>
				<label>비밀번호</label>
				<input type="password" id="userPw" name="userPw" v-model="pw" placeholder="비밀번호를 입력하세요">
			</div>
			<div>
				<label>비밀번호 확인</label>
				<input type="password" id="pwconfirm" v-model="pwconfirm" placeholder="비밀번호 확인">
			</div>
			<div>
				{{confirmText}}
			</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="btn">
				<button type="submit">회원가입</button>
				<button type="button" onclick="location.href='/users/loginpage.do'">로그인페이지이동</button>	
			</div>
			
		</form>
	</div>
	
</div>

<script>
	let vue = new Vue({
		el: "#container",
		data: {
			email: "",
			pw: "",
			pwconfirm: "",
			confirmText: "",
		},
		methods: {
			checkEmail: function() {
				 const validateEmail = /^[A-Za-z0-9_\\.\\-]+@[A-Za-z0-9\\-]+\.[A-Za-z0-9\\-]+/
				 if(!validateEmail.test(this.email) || !this.email) {
					console.log("에러에러");
					return;
				 } 
				 console.log("양식맞음 ")
				 
			},
			
			/* submitForm() {
				console.log("서브밋폼");
				const userData = {
						email: this.email,
						pw: this.pw,
				} */
				
			/* 	 $.ajax({
						url : '/login/json/signup.ajax',
						contentType : "application/json; charset=UTF-8",
						method : 'post',
						data : JSON.stringify(userData),
						dataType : 'json',	
						success : function(data) {
							alert("회원가입성공@")
						},
						error : function(e) {
							console.log(e);
							alert('에러 eee');
						},
						
					});  */
				
				
				
				
				/* this.initForm(); */
			/* }, */
			//폼 초기화
			initForm() {
				this.email = "",
				this.pw = "",
				this.pwconfirm = ""
			},
			
			
		},
		watch: {
			email: function() {
				this.checkEmail();
			},
			pwconfirm: function() {
				let pw = this.pw;
				let pwconfirm = this.pwconfirm;
				if(pw == pwconfirm) {
					console.log("같음")
					this.confirmText = "";
				} else {
					this.confirmText = "불일치";
				}
			}
		
		},
		
	});
</script>