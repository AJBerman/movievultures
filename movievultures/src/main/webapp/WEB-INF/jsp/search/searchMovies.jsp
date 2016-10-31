<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search for a Movie</title>
</head>
<body>
<h5><a href="/movievultures/home.html">Home</a></h5>

	<h2>Search for Movies</h2>
	 
	 <form action ="searchMovies.html" method="post">
	 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	 	Search: <input type="text" name="searchTerm" />
	 	
	 	<select name="type">
	 		<option value="1">Title</option>
	 		<option value="2">Genre</option>
	 		<option value="3">Director</option>
	 		<option value="4">Artist (Actor/Actress)</option>
	 		<option value="5">Less Than this Year of Release</option>
	 		<option value="6">Greater Than this Year of Release</option>
	 		<option value="7">Equal to this Year of Release</option>
	 		<option value="8">Less Than this User Rating (WORK IN PROGRESS)</option>
	 		<option value="9">Greater Than this User Rating (WORK IN PROGRESS)</option>
	 		<option value="10">Equal to this User Rating (WORK IN PROGRESS)</option>
	 		<option value="11">Less Than this Elo Rating</option>
	 		<option value="12">Greater Thank this Elo Rating</option>
	 		<option value="13">Equal to this Elo Rating</option>
	 	</select>
	 	
	 	<input name="search" type="submit" value="Go"/>
	 </form>
	
	<br />
	<hr>
	<hr>
	
	<h2><u>MOVIE RESULTS</u> ( ${fn:length(movieResults)} result(s) )</h2>
	<hr>
	<hr>
	<br />
	
	<c:choose>
		<c:when test="${ not empty movieResults }">
			<c:forEach items="${ movieResults }" var="movieResult" varStatus="status" begin="0" end="20">
				<c:if test="${ !movieResult.hidden }">
					<b>Movie Title</b>: ${ movieResult.title }<br />
					<b>Year of Release</b>: <fmt:formatDate value="${ movieResult.date }" pattern="yyyy" /><br />
					<b>Total Elo Rating</b>: ${ movieResult.eloRating }<br />
					<b>Total User Rating</b>: <br />
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
