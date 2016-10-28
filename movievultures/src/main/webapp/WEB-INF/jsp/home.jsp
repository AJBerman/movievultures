<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
</head>
<body>
<br />
	<p align="right"><a href="user/register.html">Register</a> | 
	<c:choose>
		<c:when test="${empty username}">
			<a href="login">Login</a>
		</c:when>
		<c:when test="${not empty username}">
			<a href="logout">Logout</a>
		</c:when>
	</c:choose>
	<jsp:include page="./search/searchMovies2.jsp" />
	
	<p><img src="./images/MV_banner.png" alt="Banner of Movie Vultures" /></p>
	<ul>
		<li><a href="movies/movies.html">Movies</a></li>
		<c:if test="${not empty username}">
			<li><a href="user/list.html">User Management</a></li>
			<li><a href="user/home.html?username=${username}"> ${username} </a></li>
			<li><a href="elo/add.html">Elo Rate two random movies</a></li>
		</c:if>
	</ul>

	
</body>
</html>