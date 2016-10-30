<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search for a Movie</title>
</head>
<body>
	<p align="right">
	<a href="<c:url value='/' />" >Main</a> |
	
	<sec:authorize access="!isFullyAuthenticated()">
		<a href="../user/register.html">Register</a> |
		<a href="<c:url value='/login'/>">Login</a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
		 	<sec:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>">Logout</a> |
		<a href="../user/list.html">Users</a>
	</sec:authorize>
	</p>
	
	<jsp:include page="searchMovies2.jsp" />
	
	<p><a href="/movievultures/home.html"><img src="../images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p>
	
	<h2><u>MOVIE RESULTS</u> ( ${fn:length(movieResults)} result(s) )</h2>
	<hr>
	<hr>
	<br />
	
	<c:choose>
		<c:when test="${ not empty movieResults }">
			<c:forEach items="${ movieResults }" var="movieResult" varStatus="status" begin="0" end="20">
				<c:if test="${ !movieResult.hidden }">
					<b>Movie Title</b>: <a href="../movies/details2.html?id=${ movieResult.movieId }">${ movieResult.title }</a><br />
					<b>Year of Release</b>: <fmt:formatDate value="${ movieResult.date }" pattern="yyyy" /><br />
					<b>Total Elo Rating</b>: ${ movieResult.eloRating }<br />
					
					<c:set var="sum" value="0" />
					<c:forEach items="${ movieResult.reviews }" var="r">
						<c:set var="sum" value="${ sum + r.rating }" />
					</c:forEach>
					<b>Total User Rating</b>: <fmt:formatNumber type="number" maxFractionDigits="2" value="${sum/fn:length(movieResult.reviews)}"/><br />
					
					<b>Genres</b>: <c:forEach items="${ movieResult.genres }" var="g">| ${g} |</c:forEach><br />
					<b>Directors</b>: <c:forEach items="${ movieResult.directors }" var="d">| ${d} |</c:forEach><br />
					<b>Artists</b>: <c:forEach items="${ movieResult.actors }" var="a">| ${a} |</c:forEach><br />
					<br />
					<b>===== Short Plot Summary =====</b><br />
						${movieResult.plot}
					<br />
					<br />
					<hr>
					<br />
				</c:if>
			</c:forEach>
		</c:when>
		<c:otherwise>
			No results were found.
		</c:otherwise>
	</c:choose>
	
</body>
</html>
