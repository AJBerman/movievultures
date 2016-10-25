<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>
<body>
<h5><a href="/movievultures/home.html">Home</a></h5>

	<h2>Movie Results (${fn:length(movieResults)} result(s) returned)</h2>
	
	<c:choose>
		<c:when test="${ not empty movieResults }">
			<c:forEach items="${ movieResults }" var="movieResult">
				<c:if test="${ !movieResult.hidden }">
					<b>Movie Title</b>: ${ movieResult.title }<br />
					<b>Year of Release</b>: <fmt:formatDate value="${ movieResult.date }" pattern="yyyy" /><br />
					<b>Total Elo Rating</b>: ${ movieResult.eloRating }<br />
					<b>Total User Rating</b>: <br />
					<b>Genres</b>: <c:forEach items="${ movieResult.genres }" var="g">| ${g} |</c:forEach><br />
					<b>Directors</b>: <c:forEach items="${ movieResult.directors }" var="d">| ${d} |</c:forEach><br />
					<b>Artists</b>: <c:forEach items="${ movieResult.actors }" var="a">| ${a} |</c:forEach><br />
					<b>===== Short Plot Summary =====</b><br />
						${movieResult.plot}
					<br/ >
					<br />
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
