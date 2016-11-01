<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movies</title>
</head>

<body>
	<div class="container">
		<br />
		<table class="table table-hover table-bordered">
			<tr>
				<th style="width: 15%">Title</th>
				<th style="width: 55%">Plot</th>
				<th style="width: 10%">Date</th>
				<th style="width: 5%">Elo Rating</th>
				<th style="width: 15%">Action</th>
			</tr>
			<c:forEach items="${movies}" var="movie">
				<tr>
					<td><a href="details.html?id=${movie.movieId}">${movie.title}</a></td>
					<td>${movie.plot}</td>
					<td>${movie.date}</td>
					<td>${movie.eloRating}</td>
					<td>
						<small>
						<a href="../user/addFav.html?movieId=${movie.movieId}">Favorite?</a> |
						<a href="../user/addWL.html?movieId=${movie.movieId}">WatchLater?</a>
						</small>
					</td>
				</tr>
				
			</c:forEach>
		</table>
	</div>
</body>
</html>