<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<h1>비밀번호 변경 페이지</h1>

<div id="container">

	<input type="hidden" id="userId" name="userId" v-model="user.userId">
	<div>
		<input class="form-control" type="password" id="userPw" name="userPw"
			v-model="userPw" placeholder="8자리이상 16자리이하 특수기호 포함"
			:class="{ 'input-danger' : userPwHasError } ">
		<p v-show="valid.userPw" class="input-error">비밀번호 8자리 이상 16자리 이하
			특수기호 포함</p>
	</div>
	<div>
		<input class="form-control" type="password" id="pwconfirm"
			v-model="pwconfirm" placeholder="비밀번호 확인"
			:class="{ 'input-danger' : pwconfirmHasError }">
		<p v-show="valid.pwconfirm" class="input-error">비밀번호가 다릅니다.</p>
	</div>
	<div class="">
		<button type="button" class="btn btn-primary" @click="updatePw">수정</button>
	</div>
	
	
	
</div>



<!-- 컴포넌트 -->
<jsp:include page="/WEB-INF/views/users/component/pwconfirm.jsp" />

<script>
	let vue = new Vue({
		el : "#container",
		data : {
			user: ${user},
			valid : {
				userPw : false,
				pwconfirm : false,
			},
			userPw : "",
			pwconfirm : "",
			userPwHasError : false,
			pwconfirmHasError : false,
		},
		methods : {
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
			
			updatePw: function() {
				
			 	if(this.valid.userPw) {
					alert("비밀번호 유효성 xx")
					return;
				}
				if(this.pwconfirmHasError) {
					alert("비밀번호 가 일치하지 않음");
					return;
				}
				let userpw = this.userPw; 
				let userId = $("#userId").val();
				$.ajax({
					url : '/users/json/updatepw.ajax',
					contentType : "application/json; charset=UTF-8",
					method : 'post',
					data : JSON.stringify({userId:userId,userPassword:userpw}),
					dataType : 'json',	
					beforeSend: function(xhr){
						xhr.setRequestHeader(header, token);
				    },
					success : function(data) {
						alert("수정이 완료되었습니다.")
						location.href = "/";
					},
					error : function(e) {
						console.log(e);
						alert('에러 eee');
					},
					
				}); 
				
			},

		},
		watch: {
			userPw: function() {
				this.checkUserPw();
			},
			pwconfirm: function() {
				this.checkPw();
			},
		},
	});
</script>