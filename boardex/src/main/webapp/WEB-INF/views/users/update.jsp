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
	    
	    	<div class="form-group">
	    		<label>비밀번호 : </label>
	    		<input type="password" id="userPassword" name="userPassword">
	    	</div>
	    </form>
    
    	<div id="btn">
    		<button type="button" @click="update">수정</button>
    		<button type="button" onclick="location.href='/'">취소</button>
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
	
			form.submit();
			
			
			/* $.ajax({
				url : "/users/json/update.ajax",
				contentType : "application/json; charset=UTF-8",
				method : 'POST',
				data : JSON.stringify(data),
				dataType : 'json',	
				beforeSend: function(xhr){
					xhr.setRequestHeader(header, token);
					
				   },
				success : function(data) {
					alert("수정완료");
					
				},
				error : function(e) {
					console.log(e);
					alert('에러 eee');
				},
				
			});  */
			

		},
		
	
	},
	
	
});

</script>    
    