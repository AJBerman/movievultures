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
	<h1>Welcome to Movie Vultures!</h1>
	<ul>
		<li><a href="user/list.html">User Management</a></li>
		<li><a href="user/register.html">Register</a></li>
		<li><a href="movies.html">Movies</a></li>
		<li><a href="search/searchMovies.html">Search Movie</a></li>
		<c:if test="${not empty username}">
			<li><a href="user/home.html?username=${username}" >${username}</a></li>
		</c:if>
	</ul>

	
</body>
</html>