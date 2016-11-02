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
	<%-- ===== REGISTRATION AUTHENTICATION ===== --%>
	<p align="right">
		<sec:authorize access="!isFullyAuthenticated()">
			<a href="user/register.html">Register</a> |
			<a href="login">Login</a>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<a href="user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="logout">Logout</a> 
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="user/list.html">All Users</a>
		</sec:authorize>
	</p>
	
	<%-- ========= CONTENT VISIBLE ON PAGE =========== --%>
	<jsp:include page="./search/searchMovies2.jsp" /><br />
	<a href="/movievultures/home.html"><img src="./images/MV_banner.png" alt="Banner of Movie Vultures" /></a><br />
	
	
	<%-- ===== LOGIN AUTHENTICATION ===== --%>
	<br />
	<sec:authorize access="isAuthenticated()">
		<a href="elo/add.html">Elo Rate two random movies</a> |
		<a href="movies/add.html">Add a new movie</a>
	</sec:authorize>
	
	<sec:authorize access = "isAuthenticated()">
		<h2>Favorites</h2>
	</sec:authorize>
	
	
	<%-- ===== NOT LOGGED IN ===== --%>
	<sec:authorize access = "!isFullyAuthenticated()">
		<h2>Films</h2>
	</sec:authorize>
	
	<%-- ===== DISPLAY MOVIES OF: RANDOM (not logged in) / FAVORITES (logged in) ===== --%>
	<c:choose>
		<c:when test="${ not empty movies }">
			<table border=1>
				<c:forEach items="${movies}" var="movie" varStatus="status">
					<tr>
						<td>
						<b>Title:</b> <a href="movies/details2.html?id=${movie.movieId}">${movie.title}</a> <br />
						<b>Director(s):</b>
							<c:forEach items="${movie.directors}" var="dir" varStatus="status">
								${dir},  
							</c:forEach><br />
						<b>Cast:</b>
							<c:forEach items="${movie.actors}" var="actor" varStatus="status">
								${actor}, 
							</c:forEach><br />
						<b>Plot:</b> <p>${movie.plot}</p>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:when>
		<c:otherwise>
			There are no movies to display.
		</c:otherwise>
	</c:choose>
			
</body>
</html>