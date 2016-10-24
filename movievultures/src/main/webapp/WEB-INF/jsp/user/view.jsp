<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Curiouser and Curiouser</title>
</head>
<body>
	<h2>${user.username}</h2>
	
	<br />
	
	${user.username} has reviewed:
	<table border=1>
		<tr><th>Title</th><th>rating</th></tr>
		<c:forEach items="${user.reviewedMovies}" var="review" varStatus="status" >
			<tr>
				<td><a href="../movies/details.html?id=${review.movie.movieId}">${review.movie.title}</a></td>
				<td>${review.rating }</td>
			</tr>
		</c:forEach>
	</table>
	
</body>
</html>