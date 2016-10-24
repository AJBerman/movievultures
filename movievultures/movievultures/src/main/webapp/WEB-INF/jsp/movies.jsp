<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movies</title>
</head>
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

<body>
	<h1>Movies</h1>
	<div class="container">
		<form action="movies/add.html">
			<input type="submit" class="btn btn-primary" value="Add Movies" />
		</form>
		<br />
		<table class="table table-hover table-bordered">
			<tr>
				<th style="width: 15%">Title</th>
				<th style="width: 60%">Plot</th>
				<th style="width: 15%">Date</th>
				<th style="width: 10%">Elo Rating</th>
			</tr>
			<c:forEach items="${movies}" var="movie">
				<tr>
					<td><a href="movies/details.html?id=${movie.movieId}">${movie.title}</a></td>
					<td>${movie.plot}</td>
					<td>${movie.date}</td>
					<td>${movie.eloRating}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>