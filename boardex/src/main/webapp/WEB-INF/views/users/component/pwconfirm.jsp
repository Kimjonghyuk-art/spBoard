<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <template id="pwconfirm">
    	
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
    	
    </template>
    
    
<script>
	Vue.component('confirm', {
		template: "#pwconfirm",
		data: {
			valid: {
				userPw: false,
				pwconfirm: false,
			},
			userPw: "",
			pwconfirm: "",
			userPwHasError: false,
			pwconfirmHasError: false,
		}
		methods : {
			
		},
	});

</script>