<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="_csrf_parameter" content="_csrf" />
 <meta name="_csrf_header" content="X-CSRF-TOKEN" />
 <meta name="_csrf" content="${_csrf.token}" />
<title>Insert title here</title>
</head>
<body>
<h1><a href="/">header 영역</a></h1>


<script>
var header = $("meta[name='_csrf_header']").attr("content");
var token = $("meta[name='_csrf']").attr("content");
		
</script>
</body>



</html>