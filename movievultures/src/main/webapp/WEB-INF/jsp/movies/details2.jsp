<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
			<a href="<c:url value='/logout'/>"   >Logout</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">All Users</a>
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
			<c:if test="${not empty user.username}"> |
			<a href="../review/add.html?id=${movie.movieId}">Make your voice heard!</a> |
			<a href="../elo/add.html?movie1=${movie.movieId}">Where does this movie stack up?</a> |
			<a href="../user/addFav.html?movieId=${movie.movieId}">Add to Favorites?</a> |
			<a href="../user/addWL.html?movieId=${movie.movieId}">Add to WatchList?</a> 
		</c:if>
				
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
		
		<b>Year of Release</b>: <fmt:formatDate value="${ movie.date }" pattern="yyyy" /><br />
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
		
		<c:set var="sum" value="0" />
		<c:forEach items="${ movie.reviews }" var="r">
			<c:set var="sum" value="${ sum + r.rating }" />
		</c:forEach>
		<b>Total User Rating</b>: <fmt:formatNumber type="number" maxFractionDigits="2" value="${sum/fn:length(movie.reviews)}"/><br />
		<br />
		
		<table>
		<c:choose>
			<c:when test="${ not empty movie.reviews }">
				<tr><th>User Reviews</th></tr>
				<c:forEach items="${movie.reviews}" var="r">
					<tr><td>
					<!--
						<td>${r.user.username} - ${r.rating}</td>
						<td>${r.review}</td>
						<c:if test="${r.user.username==username}">
							<td>
								<a href="../review/edit.html?id=${movie.movieId}"> Changed your mind?</a>
							</td>
						</c:if>
					  -->
					  ${r.user.username} - ${r.rating}
					  <c:if test="${r.user.username == user.username}">
					  	 | <a href="../review/edit.html?id=${movie.movieId}"> Changed your mind?</a>
					  </c:if>
					   <br />
					  ${r.review}<br /> 
					  
					</td></tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				There are no Reviews available for this movie.
			</c:otherwise>
		</c:choose>
		</table>
		
		<p><b>Elo Rating: ${movie.eloRating}</b><p>
		
		<table>
		<c:choose>
		<c:when test="${ not empty eloratings }">
			<tr><th>Elo Ratings</th></tr>
			<c:forEach items="${eloratings}" var="r">
				<tr><td>${movie.title}</td>
				  <c:choose>
    			    <c:when test="${r.winner.movieId == movie.movieId}">
    			      <td>></td><td>${r.loser.title}</td>
    				</c:when>    
    			    <c:otherwise>
    			      <td><</td><td>${r.winner.title}</td>
    				</c:otherwise>
				   </c:choose>
				<td> -${r.user.username}</td></tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
				There are no Elo Ratings avaliable for this movie.
			</c:otherwise>
		</c:choose>
		</table>
	
	</div>
</body>
</html>