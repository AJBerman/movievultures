<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${runoff.winner.title} > ${runoff.loser.title}</title>
</head>
<body>

<table border="1">
<tr><th>Rating By:</th><td>${runoff.user.username}</td></tr>
<tr><th>On:</th><td><fmt:formatDate value="${movie1.date}" pattern="mm-dd-yyyy hh:mm" /></td></tr>
<tr><th>Title</th><td>${runoff.winner.title}</td><td>${runoff.loser.title}</td></tr>
<tr><th>Year</th><td><fmt:formatDate value="${runoff.winner.date}" pattern="yyyy" /></td><td><fmt:formatDate value="${runoff.loser.date}" pattern="yyyy" /></td></tr>
<tr><th>Plot</th><td>${runoff.winner.shortPlot}</td><td>${runoff.loser.shortPlot}</td></tr>
<tr><th>Director(s)</th><td>${runoff.winner.director[0]}</td><td>${runoff.loser.director[0]}</td></tr>
<c:forEach begin="1" end="${runoff.winner.director.length > runoff.loser.director.length ? runoff.winner.director.length : runoff.loser.director.length }" varStatus="loop">
<tr><td></td><td>${runoff.winner.director[loop.index]}</td><td>${runoff.loser.director[loop.index]}</td></tr>
</c:forEach>
<tr><th>Cast</th><td>${runoff.winner.actors[0]}</td><td>${runoff.loser.actors[0]}</td></tr>
<c:forEach begin="1" end="${runoff.winner.actors.length > runoff.loser.actors.length ? runoff.winner.actors.length : runoff.loser.actors.length }" varStatus="loop">
<tr><td></td><td>${runoff.winner.actors[loop.index]}</td><td>${runoff.loser.actors[loop.index]}</td></tr>
</c:forEach>
<tr><th>EloRating</th><td>${runoff.winner.elorating}</td><td>${runoff.loser.elorating}</td></tr>
<tr><th>Vote</th><td><form><input type="hidden" name="winner" value="1"><input type="submit" value="Better"></form></td><td><form><input type="hidden" name="winner" value="2"><input type="submit" value="Better"></form></td></tr>
</table>

</body>
</html>