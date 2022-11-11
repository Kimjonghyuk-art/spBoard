<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <h1>info page</h1>
    
    <div id="info">
    
    	<h1>이름 : {{user.name}}</h1>
    	<h1>아이디 : {{user.userId}}</h1>
    </div>
	<div class="btn">
		<button type="button" onclick="location.href='/users/update.do'">수정페이지 이동</button>
		<button type="button" class="btn btn-primary" onclick="location.href='/users/updatepwpage.do'">비밀번호변경</button>
	</div>    

<script>
	let vue = new Vue({
		el:"#info",
		data: {
			user : ${user}
		},
		
		
	});    	
    
</script>