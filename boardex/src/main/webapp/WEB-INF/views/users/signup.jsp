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

 .input-error {
    line-height: 16px;
    font-size: 11px;
    color: red;
  }
  .title-danger {
    color: red;
  }
  .input-danger {
    border-color:  red;
  }

</style>
    
<div id="container">
	<div id="formWrapper">
	<h1>회원가입 페이지</h1>
		<form action="/users/signup.do" method="post">
			<div>
				<label>아이디</label>
				<input type="text" id="userId" name="userId" v-model="userId" placeholder="5자리이상 15자리 이하"
				  :class ="{ 'input-danger' : userIdHasError }">
				  <!-- <p v-show="valid.userId" class="input-error">
          			아이디 형식 5자리이상 15자리 이하로 입력
        		 </p> -->
			</div>
			<div>
				<label>이름</label>
				<input type="text" id="userName" name="userName" v-model="userName" placeholder="이름">
			</div>
			<div>
				<label>비밀번호</label>
				<input type="password" id="userPw" name="userPw" v-model="userPw" placeholder="8자리이상 16자리이하 특수기호 포함">
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
			
			userId: "",
			userName: "",
			userPw: "",
			pwconfirm: "",
			confirmText: "",
			
			userIdHasError: false,
			userPwHasError: false,
		},
		methods: {
			checkUserId: function() {
				var idRegExp = /^[a-zA-z0-9]{5,15}$/;
				
				 if(!idRegExp.test(this.userId) || !this.userId) {
					 console.log("틀림")
					 this.userIdHasError = true;
					
					 return;
				 }
				 console.log("맞음");
				 this.userIdHasError = false;
			
				 
			},
			checkUserPw: function() {
				 const validatePassword = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
				 if(!validatePassword.test(this.userPw) || !this.userPw) {
					 console.log("비밀번호 틀림");
					 this.userPwHasError = true;
					 return;
				 }
				 console.log("비밀번호 통과");
				 this.userPwHasError = false;
			}
			
			
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
			
			
		},
		watch: {
			userId: function() {
				this.checkUserId();
			},
			userPw: function() {
				this.checkUserPw();
			},
			pwconfirm: function() {
				let pw = this.userPw;
				let pwconfirm = this.pwconfirm;
				if(pw == pwconfirm) {
					console.log("같음")
					this.confirmText = "";
				} else {
					this.confirmText = "불일치";
				}
			},
		
		},
		
	});
</script>