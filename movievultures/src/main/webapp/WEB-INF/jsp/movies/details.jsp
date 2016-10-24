<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Details</title>
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
	<div class="container">
		<div class="jumbotron">
			<h1>${movie.title}</h1>
		</div>
		<div class="col-md-6">
			<a href="edit.html?id=${movie.movieId}" class="btn btn-primary">Edit</a>
		</div>
		<div class="col=md-6">
			<a href="delete.html?id=${movie.movieId}" class="btn btn-primary">Delete</a>
		</div>
		<b>Plot</b><br />
		<p>${movie.plot}</p>
		<br /> <b>Genre</b><br />
		<c:forEach items="${genres}" var="genre">
			${genre} ,
		</c:forEach>
		<br />
		<table>
			<tr>
				<th>Cast</th>
			</tr>
			<c:forEach items="${cast}" var="c">
				<tr>
					<td>${c}</td>
				</tr>
			</c:forEach>
		</table>
		<br /> 
		<table>
			<tr><th>Director(s)</th></tr>
			<c:forEach items="${directors}" var="director">
				<tr><td>${director}</td></tr>
			</c:forEach>
		</table><br /> 
		<table>
			<tr><th>Reviews</th></tr>
			<c:forEach items="${reviews}" var="r" varStatus="status">
				<tr>
					<td>By: ${users[status.index].username} - ${r.review}</td>
					<td>${r.rating}<td>
				</tr>
			</c:forEach>
		</table>

	</div>
</body>
</html>