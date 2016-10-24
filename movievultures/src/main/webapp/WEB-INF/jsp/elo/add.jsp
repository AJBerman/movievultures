<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Elo Rating: ${movie1.title} vs ${movie2.title}</title>
</head>
<body>
<table border="1">
<tr><th>Title</th><td>${movie1.title}</td><td>${movie2.title}</td></tr>
<tr><th>Year</th><td><fmt:formatDate value="${movie1.date}" pattern="yyyy" /></td><td><fmt:formatDate value="${movie2.date}" pattern="yyyy" /></td></tr>
<tr><th>Plot</th><td>${movie1.plot}</td><td>${movie2.plot}</td></tr>
<tr><th>Director(s)</th><td>${movie1.directors[0]}</td><td>${movie2.directors[0]}</td></tr>
<c:forEach begin="1" end="${fn:length(movie1.directors) > fn:length(movie2.directors) ? fn:length(movie1.directors) : fn:length(movie2.directors) }" varStatus="loop">
<tr><td></td><td>${movie1.directors[loop.index]}</td><td>${movie2.directors[loop.index]}</td></tr>
</c:forEach>
<tr><th>Cast</th><td>${movie1.actors[0]}</td><td>${movie2.actors[0]}</td></tr>
<c:forEach begin="1" end="${fn:length(movie1.actors) > fn:length(movie2.actors) ? fn:length(movie1.actors) : fn:length(movie2.actors) }" varStatus="loop">
<tr><td></td><td>${movie1.actors[loop.index]}</td><td>${movie2.actors[loop.index]}</td></tr>
</c:forEach>
<tr><th>EloRating</th><td>${movie1.eloRating}</td><td>${movie2.eloRating}</td></tr>
<tr><th>Vote</th><td><form method="POST"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="hidden" name="winner" value="1"><input type="submit" value="Better"></form></td><td><form method="POST"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><input type="hidden" name="winner" value="2"><input type="submit" value="Better"></form></td></tr>
</table>
</body>
</html>