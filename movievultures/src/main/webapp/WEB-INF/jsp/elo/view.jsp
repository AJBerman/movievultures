<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>

<title>${runoff.winner.title} > ${runoff.loser.title}</title>
</head>
<body>
	<h5><a href="/movievultures/home.html">Home</a></h5>
	
	<table class="table table-bordered table-striped table-hover">
		<tr><th>Rating By:</th><td>${runoff.user.username}</td></tr>
		<tr><th>On:</th><td><fmt:formatDate value="${runoff.date}" pattern="MM-dd-yyyy hh:mm" /></td></tr>
		<tr><th>Title</th><td><a href="/movievultures/movies/details.html?id=${runoff.winner.movieId}">${runoff.winner.title}</a></td><td><a href="/movievultures/movies/details.html?id=${runoff.loser.movieId}">${runoff.loser.title}</a></td></tr>
		<tr><th>Year</th><td><fmt:formatDate value="${runoff.winner.date}" pattern="yyyy" /></td><td><fmt:formatDate value="${runoff.loser.date}" pattern="yyyy" /></td></tr>
		<tr><th>Plot</th><td>${runoff.winner.plot}</td><td>${runoff.loser.plot}</td></tr>
		<tr><th>director(s)</th><td>${runoff.winner.directors[0]}</td><td>${runoff.loser.directors[0]}</td></tr>
		
		<c:forEach begin="1" end="${fn:length(runoff.winner.directors) > fn:length(runoff.loser.directors) ? fn:length(runoff.winner.directors)-1 : fn:length(runoff.loser.directors)-1 }" varStatus="loop">
			<tr><td></td><td>${runoff.winner.directors[loop.index]}</td><td>${runoff.loser.directors[loop.index]}</td></tr>
		</c:forEach>
		
		<tr><th>Cast</th><td>${runoff.winner.actors[0]}</td><td>${runoff.loser.actors[0]}</td></tr>
		
		<c:forEach begin="1" end="${fn:length(runoff.winner.actors) > fn:length(runoff.loser.actors) ? fn:length(runoff.winner.actors)-1 : fn:length(runoff.loser.actors)-1 }" varStatus="loop">
			<tr><td></td><td>${runoff.winner.actors[loop.index]}</td><td>${runoff.loser.actors[loop.index]}</td></tr>
		</c:forEach>
		
		<tr><th>EloRating</th><td>${runoff.winner.eloRating}</td><td>${runoff.loser.eloRating}</td></tr>
		<tr><td></td><th>Winner</th><th>Loser</th></tr>
	</table>

</body>
</html>