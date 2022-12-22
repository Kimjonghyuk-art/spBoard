<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
	<title>Home</title>
</head>
<body>

<h1>이    름 : ${user.name} 님 접속</h1> 

<P>  The time on the server is ${serverTime}. </P>

<!-- 로그인중이 아닐 때에만 Login 버튼이 보임  -> taglib ( security/tags ) 때문에 가능 -->
	<sec:authorize access="isAnonymous()">
 		<a href='/users/loginpage.do'>Login</a>
 		<h1><a href="/users/signuppage.do">회원가입이동</a></h1>
	</sec:authorize>

<!-- 로그인 중일 경우에만 Logout 버튼이보임 -->
	<sec:authorize access="isAuthenticated()">
		<form action="${pageContext.request.contextPath}/users/logout.do" method="POST">
			<input id="logoutBtn" type="submit" value="Logout" />
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
		
		<h1><a href="/board/list.do">게시판이동</a></h1> 
		<h1><a href="/charts/chartEx.do">차트테스트</a></h1>
		<div>
			<button type="button" onclick="location.href='/users/info.do'">내정보 보기</button>
		
		</div>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<h1>관리자만 보입니다.</h1>
		<a href="/admin/readexcelpage.do">엑셀읽기 테스트</a>
	</sec:authorize>
	
	
	
	
	<form action="/board/list.do" method="POST">
		<%-- <input id="logoutBtn" type="submit" value="게시판이동" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> --%>
	</form>



</body>
</html>
