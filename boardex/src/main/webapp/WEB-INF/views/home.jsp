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
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
<h1>이    름 : ${userinfo.userName }님 환영</h1> 

<!-- 로그인중이 아닐 때에만 Login 버튼이 보임  -> taglib ( security/tags ) 때문에 가능 -->
	<sec:authorize access="isAnonymous()">
 		<a href='/users/loginpage.do'>Login</a>
	</sec:authorize>

<!-- 로그인 중일 경우에만 Logout 버튼이보임 -->
	<sec:authorize access="isAuthenticated()">
		<form action="${pageContext.request.contextPath}/logout" method="POST">
			<input id="logoutBtn" type="submit" value="Logout" />
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
	</sec:authorize>
	<form action="${pageContext.request.contextPath}/userPage/userTest.do" method="POST">
		<input id="logoutBtn" type="submit" value="userPage" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>




<h1><a href="/board/list.do">게시판이동</a></h1>
<h1><a href="/users/signuppage.do">회원가입이동</a></h1>
</body>
</html>
