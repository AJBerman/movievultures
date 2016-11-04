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
<style>
mark {
    background: yellow;
}
.marked {
    background: yellow;
}
</style><!-- For search highlighting -->
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
		<a href="<c:url value='/logout'/>">Logout</a>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">All Users</a>
	</sec:authorize>
	</p>
	
	<jsp:include page="searchMovies2.jsp" />
	
	<p><a href="/movievultures/home.html"><img src="../images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p>
	
		<c:set var="res" value="0" />
		<c:forEach items="${ movieResults }" var="movieResult">
			<c:if test="${ !movieResult.hidden }">
				<c:set var="res" value="${ res + 1 }" />			
			</c:if>
		</c:forEach>
		
	<h2><u>MOVIE RESULTS</u>: ( ${ res } result(s) )</h2>
	<h3>Where <span id="searchResultType">${type}</span> <span id="comparator">${comparator}</span> <span id="searchResultTerm">${searchTerm}</span></h3>
	
	<hr>
	<hr>
	<br />
	
	<c:choose>
		<c:when test="${ not empty movieResults }">
			<c:forEach items="${ movieResults }" var="movieResult" varStatus="status" begin="0" end="20">
				<c:if test="${ !movieResult.hidden }">
					<b>Movie Title</b>: <a class="movieTitle" href="../movies/details2.html?id=${ movieResult.movieId }">${ movieResult.title }</a><br />
					<b>Year of Release</b>: <span class="movieYear"><fmt:formatDate value="${ movieResult.date }" pattern="yyyy" /></span><br />
					<b>Total Elo Rating</b>: <span class="movieElo"><fmt:formatNumber type="number" maxFractionDigits="2" value="${movieResult.eloRating}"/></span><br />
					
					<c:set var="sum" value="0" />
					<c:forEach items="${ movieResult.reviews }" var="r">
						<c:set var="sum" value="${ sum + r.rating }" />
					</c:forEach>
					<b>Total User Rating</b>: <span class="movieRating"><fmt:formatNumber type="number" maxFractionDigits="0" value="${sum/fn:length(movieResult.reviews)}"/></span><br />
					
					<b>Genres</b>: <c:forEach items="${ movieResult.genres }" var="g">| <span class="movieGenre">${g}</span> |</c:forEach><br />
					<b>Directors</b>: <c:forEach items="${ movieResult.directors }" var="d">| <span class="movieDirector">${d}</span> |</c:forEach><br />
					<b>Artists</b>: <c:forEach items="${ movieResult.actors }" var="a">| <span class="movieActor">${a}</span> |</c:forEach><br />
					<br />
					<b>===== Short Plot Summary =====</b><br />
						<span class="moviePlot">${movieResult.plot}</span>
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
	<script src="/movievultures/res/js/jquery-3.1.1.min.js"></script> <!-- For search highlighting -->
	<script src="/movievultures/res/js/jquery.mark.js"></script> <!-- For search highlighting -->
	<script>
	//at the bottom so it can mutate existing text.
	$(document).ready(function() {
		console.log($("#searchResultTerm").text());
		switch($("#searchResultType").text()) {
			case "title":
				$(".movieTitle").mark($("#searchResultTerm").text(), {
					diacritics: false,
	                debug: true
	            });
				break;
			case "genre":
				$(".movieGenre").mark($("#searchResultTerm").text(), {
					diacritics: false,
	                debug: true
	            });
				break;
			case "director":
				$(".movieDirector").mark($("#searchResultTerm").text(), {
					diacritics: false,
	                debug: true
	            });
				break;
			case "actor":
				$(".movieActor").mark($("#searchResultTerm").text(), {
					diacritics: false,
	                debug: true
	            });
				break;
			case "year of release":
				$(".movieYear").addClass("marked");
				break;
			case "user rating":
				$(".movieRating").addClass("marked");
				break;
			case "Elo rating":
				$(".movieElo").addClass("marked");
				break;
			default:
				console.log("Foo!");
				break;
		}
	});
	</script>
	
</body>
</html>
