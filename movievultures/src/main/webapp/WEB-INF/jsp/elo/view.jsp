<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${runoff.winner.title} > ${runoff.loser.title}</title>
</head>
<body>

<table border="1">
<tr><th>Rating By:</th><td>${runoff.user.username}</td></tr>
<tr><th>On:</th><td><fmt:formatDate value="${runoff.date}" pattern="MM-dd-yyyy hh:mm" /></td></tr>
<tr><th>Title</th><td>${runoff.winner.title}</td><td>${runoff.loser.title}</td></tr>
<tr><th>Year</th><td><fmt:formatDate value="${runoff.winner.date}" pattern="yyyy" /></td><td><fmt:formatDate value="${runoff.loser.date}" pattern="yyyy" /></td></tr>
<tr><th>Plot</th><td>${runoff.winner.shortPlot}</td><td>${runoff.loser.shortPlot}</td></tr>
<tr><th>director(s)</th><td>${runoff.winner.directors[0]}</td><td>${runoff.loser.directors[0]}</td></tr>
<c:forEach begin="1" end="${fn:length(runoff.winner.directors) > fn:length(runoff.loser.directors) ? fn:length(runoff.winner.directors) : fn:length(runoff.loser.directors) }" varStatus="loop">
<tr><td></td><td>${runoff.winner.directors[loop.index]}</td><td>${runoff.loser.directors[loop.index]}</td></tr>
</c:forEach>
<tr><th>Cast</th><td>${runoff.winner.actors[0]}</td><td>${runoff.loser.actors[0]}</td></tr>
<c:forEach begin="1" end="${fn:length(runoff.winner.actors) > fn:length(runoff.loser.actors) ? fn:length(runoff.winner.actors) : fn:length(runoff.loser.actors) }" varStatus="loop">
<tr><td></td><td>${runoff.winner.actors[loop.index]}</td><td>${runoff.loser.actors[loop.index]}</td></tr>
</c:forEach>
<tr><th>EloRating</th><td>${runoff.winner.eloRating}</td><td>${runoff.loser.eloRating}</td></tr>
<tr><td></td><th>Winner</th><th>Loser</th></tr>
</table>

</body>
</html>