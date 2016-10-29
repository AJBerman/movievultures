<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
</head>
<body>
<br />
	<p align="right"> 
	<sec:authorize access="!isFullyAuthenticated()">
		<a href="user/register.html">Register</a> |
		<a href="login">Login</a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<a href="user/home.html?username=<sec:authentication property="principal.username" />" >
		 	<sec:authentication property="principal.username" /> </a> |
		<a href="logout">Logout</a> |
		<a href="user/list.html">Users</a>
	</sec:authorize>
	</p>
	
	<%-- ========= CONTENT VISIBLE ON PAGE =========== --%>
	
	<jsp:include page="./search/searchMovies2.jsp" />
	
	<p><a href="/movievultures/home.html"><img src="./images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p>
	<ul>
		<%-- <li><a href="movies/movies.html">Movies</a></li> --%>
	</ul>	
		<sec:authorize access="isAuthenticated()">
			<li><a href="elo/add.html">Elo Rate two random movies</a></li>
		</sec:authorize>

		
		<%-- ===== DISPLAY RANDOM MOVIES ===== --%>
		<br />
		<sec:authorize access = "isAuthenticated()">
			<p>Favorites</p>
		</sec:authorize>
		<sec:authorize access = "!isFullyAuthenticated()">
			<p>Films</p>
		</sec:authorize>
		
		<table border=1>
			<c:forEach items="${movies}" var="movie" varStatus="status">
				<tr>
					<td>
					Title: <a href="movies/details2.html?id=${movie.movieId}">${movie.title}</a> <br />
					Director(s):
						<c:forEach items="${movie.directors }" var="dir" varStatus="status">
							${dir},  
						</c:forEach><br />
					Cast:
						<c:forEach items="${movie.actors}" var="actor" varStatus="status">
							${actor}, 
						</c:forEach><br />
					Plot: <p>${movie.plot}</p>
					</td>
				</tr>
			</c:forEach>
		</table>		
		
		<!--<jsp:include page="movies/movies2.jsp" /> -->

	

	
</body>
</html>