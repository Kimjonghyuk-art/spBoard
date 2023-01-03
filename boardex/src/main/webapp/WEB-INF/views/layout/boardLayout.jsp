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
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

<!-- 공통 js -->
<script src="/resources/js/board/common.js"></script>
<!-- ammChart -->
<script src="//cdn.amcharts.com/lib/4/core.js"></script>
<script src="//cdn.amcharts.com/lib/4/charts.js"></script>
<script src="//cdn.amcharts.com/lib/4/maps.js"></script>
<script type="text/javascript" src="/resources/js/common/commonChart.js"></script>

<style>
	#mainContainer {
		width: 70%;
		margin : 0 auto;
	}

</style>
</head>
<body>
	<div id="mainContainer">
		<tiles:insertAttribute name="header" ignore="true"></tiles:insertAttribute>
		<tiles:insertAttribute name="body" ignore="true"></tiles:insertAttribute>
	</div>
</body>
</html>