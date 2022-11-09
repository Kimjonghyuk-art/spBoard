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
		<form @submit.prevent="signup" class="row g-3">
	
			<div class="col-auto">
				<label for="inputPassword2" class="visually-hidden">아이디</label>
				<input type="text" class="form-control" id="userId" @input="userId = $event.target.value" :class ="{ 'input-danger' : userIdHasError }"
					placeholder="아이디 입력">
					 <p v-show="valid.userId" class="input-error">
          			아이디 형식 5자리이상 15자리 이하로 입력
        		 </p> 
			</div>
			<div class="col-auto">
				<button type="button" id="duplicateBtn" class="btn btn-primary mb-3" @click="duplicateCheck">중복검사</button>
			</div>

			<div>
				<input class="form-control" type="text" id="userName" name="userName" v-model="userName" placeholder="이름" >
			</div>
		
			<div>
			
				<input class="form-control" type="password" id="userPw" name="userPw" v-model="userPw" placeholder="8자리이상 16자리이하 특수기호 포함"
					  :class = "{ 'input-danger' : userPwHasError } " >
					  <p v-show="valid.userPw" class="input-error">
          				비밀번호 8자리 이상 16자리 이하 특수기호 포함
        			 </p> 
			
			</div>
			
			<div>
				<input class="form-control" type="password" id="pwconfirm" v-model="pwconfirm" placeholder="비밀번호 확인"
				  :class="{ 'input-danger' : pwconfirmHasError }">
				<p v-show="valid.pwconfirm" class="input-error">
					비밀번호가 다릅니다.
				</p>
			</div>
			
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div class="">
				<button type="submit" class="btn btn-primary">회원가입</button>
				<button type="button" class="btn btn-primary" @click="cancel">취소</button>	
			</div>
			
		</form>
	</div>
	
</div>

<script>
	let vue = new Vue({
		el: "#container",
		data: {
			valid: {
				userId: false,
				userPw: false,
				pwconfirm: false,
			},
			userId: "",
			userName: "",
			userPw: "",
			pwconfirm: "",
			confirmText: "",
			
			userIdHasError: false,
			userPwHasError: false,
			pwconfirmHasError: false,
		},
		methods: {
			//폼체크
			formCheck: function() {
				if(this.userId == null || this.userId == '') {
					alert('아이디를 입력해주세요.');
					$("#userId").focus();
					return false;
				} else if (this.userName == null || this.userName == '') {
					alert("이름을 입력해주세요.");
					$("#userName").focus();
					return false;
				} else if(this.userPw == null || this.userPw == '') {
					alert("비밀번호를 입력해주세요.");
					$("#userPw").focus();
					return false;
				} else if(this.pwconfirm == null || this.pwconfirm == '') {
					alert("비밀번호 확인 입력해주세요");
					$("#pwconfirm").focus();
					return false;
				}
				
				return true;
			},
			//유저아이디 유효성검사
			checkUserId: function() {
				var idRegExp = /^[a-zA-z0-9]{5,15}$/;
				
				 if(!idRegExp.test(this.userId) || !this.userId) {
					 console.log("틀림")
					this.userIdHasError = true;
					this.valid.userId = true;
					 return;
				 }
				 console.log("맞음");
				 this.userIdHasError = false;
				 this.valid.userId = false;
			
				 
			},
			//비밀번호 유효성검사
			checkUserPw: function() {
				 const validatePassword = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
				 if(!validatePassword.test(this.userPw) || !this.userPw) {
					 console.log("비밀번호 틀림");
					 this.userPwHasError = true;
					 this.valid.userPw = true;
					 return;
				 }
				 console.log("비밀번호 통과");
				 this.userPwHasError = false;
				 this.valid.userPw = false;
			},
			//동일 비밀번호 확인
			checkPw: function() {
				let pw = this.userPw;
				let checkpw = this.pwconfirm;
				
				console.log("기존 입력 비번->" + pw);
				console.log("체크 비번 ->"+checkpw);
				
				if(pw != checkpw) {
					this.valid.pwconfirm = true;
					this.pwconfirmHasError = true;
					console.log("다름")
					return;
				}
				this.valid.pwconfirm = false;
				this.pwconfirmHasError = false;
				console.log("같음")
			},
			//아이디 중복체크
			duplicateCheck: function() {
				
				if(this.userId == null || this.userId == '') {
					alert('아이디를 입력해주세요.');
					$("#userId").focus();
					return;
				}
				
				let userId = this.userId;
				console.log(userId);
				console.log("즁복검사."+this.userIdHasError);
				if(this.userIdHasError) {
					alert("아이디형식 확인");
					$("#userId").focus();
					return;
				}

				$.ajax({
						url : '/users/json/idduplicatecheck.ajax',
						contentType : "application/json; charset=UTF-8",
						method : 'post',
						data : JSON.stringify({userId:userId}),
						dataType : 'json',	
						beforeSend: function(xhr){
							xhr.setRequestHeader(header, token);
						   },
						success : function(data) {
							console.log(typeof data);
							if(data == 0) {
								alert("체크완료!");
								$("#duplicateBtn").text('완료').prop("disabled", true);
							} else {
								alert("중복존재")
							}
						},
						error : function(e) {
							console.log(e);
							alert('에러 eee');
						},
						
					}); 
				
			},
			
			//회원가입 실행
			signup: function() {
				//입력값 없을 경우 리턴
				if(!this.formCheck()) return;
				
				if(this.valid.userPw) {
					alert("비밀번호 유효성 xx")
					return;
				}
				if(this.pwconfirmHasError) {
					alert("비밀번호 가 일치하지 않음");
					return;
				}
				
				if(!$("#duplicateBtn").is(":disabled")) {
					alert("아이디 중복검사 필요");
					return;
				} 
								
				let userData = {
						userId: this.userId,
						userName: this.userName,
						userPassword: this.userPw
				}
				
				console.log(userData);
			 	$.ajax({
					url : '/users/json/signup.ajax',
					contentType : "application/json; charset=UTF-8",
					method : 'post',
					data : JSON.stringify(userData),
					dataType : 'json',	
					beforeSend: function(xhr){
						xhr.setRequestHeader(header, token);
				    },
					success : function(data) {
						location.href = "/";
					},
					error : function(e) {
						console.log(e);
						alert('에러 eee');
					},
					
				}); 			
				
			},
			
			cancel: function() {
				if(!confirm('가입을 취소하시겠습니까?')) return false;
				location.href="/"
			},
			
		},
		watch: {
			userId: function() {
				this.checkUserId();
			},
			userPw: function() {
				this.checkUserPw();
			},
			pwconfirm: function() {
				this.checkPw();
			},
		
		},
		
	});
</script>