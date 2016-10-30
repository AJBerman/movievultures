<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Details</title>
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
			<a href="<c:url value='/logout'/>"   >Logout</a> |
			<a href="../user/list.html">Users</a>
		</sec:authorize>
	</p>
	
	<jsp:include page="../search/searchMovies2.jsp" />
	<p><a href="/movievultures/home.html"><img src="../images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p>


	<%-- ===== MOVIE DETAILS DISPLAY ===== --%>
	<div class="container">
	
		<div class="jumbotron">
			<h1>${movie.title}</h1>
		</div>
		
		
		
		<div class="col-md-6">
			<sec:authorize access = "isAuthenticated()">
			<a href="edit.html?id=${movie.movieId}" class="btn btn-primary">Edit Movie</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="delete.html?id=${movie.movieId}" class="btn btn-primary">Delete Movie</a>
			</sec:authorize>	
		</div>

		<br />
		<b>Plot</b><br />
		<p>${movie.plot}</p>
		<br /> <b>Genre</b><br />
		<c:choose>
			<c:when test="${ not empty movie.genres }">
				<c:forEach items="${movie.genres}" var="genre">
					<ul><li>${genre}</li></ul>
				</c:forEach>
			</c:when>
			<c:otherwise>
				Please help by adding Genres to this movie.
			</c:otherwise>
		</c:choose>
		<br />
		<br />
		<table>
			<tr>
				<th>Cast</th>
			</tr>
			<c:forEach items="${movie.actors}" var="c">
				<tr>
					<td>${c}</td>
				</tr>
			</c:forEach>
		</table>
		<br /> 
		<table>
			<tr><th>Director(s)</th></tr>
			<c:forEach items="${movie.directors}" var="director">
				<tr><td>${director}</td></tr>
			</c:forEach>
		</table><br /> 
		<table>
			<tr><th>User Reviews</th></tr>
			<c:forEach items="${movie.reviews}" var="r">
				<tr>
					<td>${r.user.username} - ${r.review}</td>
					<td>${r.rating}</td>
					<c:if test="${r.user.username==username}"><td><a href="../review/edit.html?id=${movie.movieId}"> Changed your mind?</a></td></c:if>
				</tr>
			</c:forEach>
		</table>
		
		<c:if test="${not empty username}">
			<br />
			<a href="../review/add.html?id=${movie.movieId}">Make your voice heard!</a>
			<br />
			<a href="../elo/add.html?movie1=${movie.movieId}">Where does this movie stack up?</a>
			<br />
			<a href="../user/addFav.html?movieId=${movie.movieId}">Add to Favorites?</a>
			<br />
			<a href="../user/addWL.html?movieId=${movie.movieId}">Add to WatchList?</a>
		</c:if>

	</div>
</body>
</html>