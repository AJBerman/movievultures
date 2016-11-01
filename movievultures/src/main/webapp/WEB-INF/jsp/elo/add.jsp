<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Elo Rating: ${movie1.title} vs ${movie2.title}</title>
</head>

<body>
	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="!isFullyAuthenticated()">
			<a href="../user/register.html">Register</a> |
			<a href= "<c:url value='/login'/>"  >Login</a>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="<c:url value='/logout'/>"   >Logout</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">All Users</a>
		</sec:authorize>
	</p>
	
	<p><a href="/movievultures/home.html"><img src="../images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p>
	
	<h3>From the choices below, please select the movie you believe is better.</h3>
	
	<table border="1">
		<tr><th>Title</th><td><a href="../movies/details2.html?id=${ movie1.movieId }" target="_blank">${movie1.title}</a></td><td><a href="../movies/details2.html?id=${ movie2.movieId }" target="_blank">${movie2.title}</a></td></tr>
		<tr><th>Year</th><td><fmt:formatDate value="${movie1.date}" pattern="yyyy" /></td><td><fmt:formatDate value="${movie2.date}" pattern="yyyy" /></td></tr>
		<tr><th>Plot</th><td>${movie1.plot}</td><td>${movie2.plot}</td></tr>
		<tr><th>Director(s)</th><td>${movie1.directors[0]}</td><td>${movie2.directors[0]}</td></tr>
		
		<c:forEach begin="1" end="${fn:length(movie1.directors) > fn:length(movie2.directors) ? fn:length(movie1.directors)-1 : fn:length(movie2.directors)-1 }" varStatus="loop">
			<tr><td></td><td>${movie1.directors[loop.index]}</td><td>${movie2.directors[loop.index]}</td></tr>
		</c:forEach>
		
		<tr><th>Cast</th><td>${movie1.actors[0]}</td><td>${movie2.actors[0]}</td></tr>
	
		<c:forEach begin="1" end="${fn:length(movie1.actors) > fn:length(movie2.actors) ? fn:length(movie1.actors)-1 : fn:length(movie2.actors)-1 }" varStatus="loop">
			<tr><td></td><td>${movie1.actors[loop.index]}</td><td>${movie2.actors[loop.index]}</td></tr>
		</c:forEach>
	
		<tr><th>EloRating</th><td>${movie1.eloRating}</td><td>${movie2.eloRating}</td></tr>
		<tr>
			<th>Vote</th>
			
			<td><form method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="winner" value="1">
				<input type="submit" value="Better">
			</form></td>
			
			<td>
				<form method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="winner" value="2">
				<input type="submit" value="Better">
				</form>
			</td>
		</tr>
		
		<tr bgcolor="#FFEB99">
			<th>Different Match</th>
			
			<td> 
				<a href="add.html?movie2=${movie2.movieId}">Switch First Movie?</a> |
				<a href="add.html?movie1=${movie1.movieId}">Switch Second Movie?</a>
			 </td>
			 
			<td><a href="add.html">New Match?</a></td>
		</tr>
	</table>

</body>
</html>