<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<tr><th>Plot</th><td>${movie1.shortPlot}</td><td>${movie2.shortPlot}</td></tr>
<tr><th>Director(s)</th><td>${movie1.director[0]}</td><td>${movie2.director[0]}</td></tr>
<c:forEach begin="1" end="${movie1.director.length > movie2.director.length ? movie1.director.length : movie2.director.length }" varStatus="loop">
<tr><td></td><td>${movie1.director[loop.index]}</td><td>${movie2.director[loop.index]}</td></tr>
</c:forEach>
<tr><th>Cast</th><td>${movie1.actors[0]}</td><td>${movie2.actors[0]}</td></tr>
<c:forEach begin="1" end="${movie1.actors.length > movie2.actors.length ? movie1.actors.length : movie2.actors.length }" varStatus="loop">
<tr><td></td><td>${movie1.actors[loop.index]}</td><td>${movie2.actors[loop.index]}</td></tr>
</c:forEach>
<tr><th>EloRating</th><td>${movie1.elorating}</td><td>${movie2.elorating}</td></tr>
<tr><th>Vote</th><td><form><input type="hidden" name="winner" value="1"><input type="submit" value="Better"></form></td><td><form><input type="hidden" name="winner" value="2"><input type="submit" value="Better"></form></td></tr>
</table>
</body>
</html>