<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>"There's no place like home"</title>
</head>
<body>
	<h2>Welcome ${user.username}</h2>
	
	<h3>Profile:</h3>
	<table border=1>
		<tr><th>Member #: </th><td>${user.userId }</td></tr>
		<tr><th>Username:</th> <td>${user.username}</td></tr>
		<tr><th>e-mail: </th><td>${user.email}</td></tr>
	</table>
	<a href="profile.html?userId=${user.userId}">Edit Profile</a>
	
	<br />
	<h3>Recommendations:</h3>
	<c:if test="${empty user.recommendations}">
		<p>None at the moment.</p>
	</c:if>
	<c:if test="${not empty user.recommendations}">
		<table>
			<tr><th>Title</th></tr>
			<c:forEach items="${user.recommendations}" var="movie" varStatus="status" >
				<tr>
					<td>${movie.title }</td>
					<td><a href="movie/view.html">view</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	<br />
	
	<h3>Favorites:</h3>
	<c:if test="${empty user.favorites}">
		<p>None at the moment.</p>
	</c:if>
	<c:if test="${not empty user.favorites}">
		<table border=1>
			<tr><th>Title</th></tr>
			<c:forEach items="${user.favorites}" var="movie" varStatus="status" >
				<tr>
					<td>${movie.title }</td>
				</tr>
			</c:forEach>
		</table>
		<a href="favorites.html?userId=${user.userId}">Edit favorites</a>
	</c:if>

	<br />
	
	<h3>Watch Later:</h3>
	<c:if test="${empty user.watchLater}">
		<p>None at the moment.</p>
	</c:if>
	<c:if test="${not empty user.watchLater}">
		<table border=1>
			<tr><th>Title</th></tr>
			<c:forEach items="${user.watchLater}" var="movie" varStatus="status" >
				<tr>
					<td>${movie.title }</td>
				</tr>
			</c:forEach>
		</table>
		<a href="watchLater.html?userId=${user.userId}">Edit Watch Later</a>
	</c:if>

	<h3>Reviewed Movies:</h3>
	<c:if test="${empty user.reviewedMovies}">
		<p>You haven't reviewed any movies yet!</p>
	</c:if>
	<c:if test= "${not empty user.reviewedMovies}">
	<table border=1>
		<tr><th>Movie Title</th> <th>Rating</th><th>Operations</th></tr>
		<c:forEach items="${user.reviewedMovies}" var="review" varStatus="status">
			<tr>
				<td>${review.movie.title}</td>
				<td>${review.rating }</td>
				<td>
					<a href="/review/view.html">View</a> |
					<a href="/review/edit.html">Edit</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	</c:if>			
	
	
</body>
</html>