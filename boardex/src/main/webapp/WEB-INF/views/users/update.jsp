<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>user update Form</h1>
    
    <div id="content">
    
	    <form id="updateForm" method="post" action="/users/updateAction.do">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	    	<div class="form-group">
	    		<label>아이디 : </label>
	    		<input type="text" id="userId" name="userId" v-model="user.userId" readonly>
	    	</div>
	    
	    	<div class="form-group">
	    		<label>이름 : </label>
	    		<input type="text" id="userName" name="userName" v-model="user.name">
	    	</div>
	    
	    	<div class="form-group">
	    		<label>권한 : </label>
	    		<input type="text" id="userAuthority" name="userAuthority" v-model="user.userAuthority" readonly>
	    	</div>
	    </form>
    
    	<div id="btn">
    		<button type="button" class="btn btn-primary" @click="update">수정</button>
    		<button type="button" class="btn btn-primary" onclick="location.href='/'">취소</button>
    	</div>
    
    
    </div>
    
    
<script>

let vue = new Vue({
	el: "#content",
	
	data: {
		user : ${user}
	},
	methods : {
		update: function() {
			let vue = this;
			let form = $("#updateForm")[0];
			
			let data = {
					userId : vue.user.userId,
					userPassword :  vue.user.userPassword,
					userName : vue.user.name 
			};
			console.log("data->" + JSON.stringify(data))
			alert("수정이 완료되었습니다.");	
			form.submit();


		},
		
	
	},
	
	
});

</script>    
    