<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<!-- 공통 js -->

<script src="/resources/js/board/common.js"></script>

</head>
<body>
<tiles:insertAttribute name="header" ignore="true"></tiles:insertAttribute>
<tiles:insertAttribute name="body" ignore="true"></tiles:insertAttribute>
</body>
</html>