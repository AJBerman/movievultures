<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>"There's no place like home"</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<c:url value="/res/js/userHome.js" />"></script>
</head>
<body>

	<p align="right">
		<security:authorize access="isAuthenticated()">
			<a href="<c:url value='/' /> ">Main</a> |
			<a href="<c:url value='/logout' />">Logout</a> 
		</security:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">Management</a>
		</sec:authorize>
	</p>

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
			<table id="rec" border=1>
				<tr class="header"><th>Title</th></tr>
				<c:forEach items="${user.recommendations}" var="movie" varStatus="status" >
					<tr>
						<td><a href="../movies/details2.html?id=${movie.movieId}">${movie.title}</a></td>
					</tr>
				</c:forEach>
			</table>
			<input type="button" value="Less" id="lessRec" />
			<input type="button" value="More" id="moreRec" />
		</c:if>
	<br />
	
	<h3>Favorites:</h3>
	<c:if test="${empty user.favorites}">
		<p>None at the moment.</p>
	</c:if>
	<c:if test="${not empty user.favorites}">
		<table id="fav" border=1>
			<tr class="header"><th>Title</th><th>action</th></tr>
			<c:forEach items="${user.favorites}" var="movie" varStatus="status" >
				<tr>
					<td><a href="../movies/details2.html?id=${ movie.movieId }">${movie.title }</a></td>
					<td>
						<a href="removeFav.html?index=${status.index}&userId=${user.userId}">
							<img src="../images/delete.png"></img>
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<input type="button" value="Less" id="lessFav" />
		<input type="button" value="More" id="moreFav" />
	</c:if>

	<br />
	
	<h3>Watch Later:</h3>
	<c:if test="${empty user.watchLater}">
		<p>None at the moment.</p>
	</c:if>
	<c:if test="${not empty user.watchLater}">
		<table id="watch" border=1>
			<tr class="header"><th>Title</th><th>action</th></tr>
			<c:forEach items="${user.watchLater}" var="movie" varStatus="status" >
				<tr>
					<td><a href="../movies/details2.html?id=${ movie.movieId }">${movie.title }</a></td>
					<td>
						<a href="removeWL.html?index=${status.index}&userId=${user.userId}">
							<img src="../images/delete.png"></img>
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<input type="button" value="Less" id="lessWatch" />
		<input type="button" value="More" id="moreWatch" />
	</c:if>

	<h3 style="cursor: pointer;" id="revHeader">Reviewed Movies:</h3>
	<div id="slideRev">
	<c:if test="${empty user.reviewedMovies}">
		<p>You haven't reviewed any movies yet!</p>
	</c:if>
	<c:if test= "${not empty user.reviewedMovies}">
	<table id="rev" border=1>
		<tr class="header"><th>Movie Title</th><th>Review</th> <th>Rating</th><th>Operations</th></tr>
		<c:forEach items="${user.reviewedMovies}" var="review" varStatus="status">
			<tr>
				<td><a href="../movies/details2.html?id=${ review.movie.movieId }">${review.movie.title}</a></td>
				<td>${review.review}</td>
				<td>${review.rating }</td>
				<td>
					<a href="../review/edit.html?id=${review.movie.movieId}">Edit</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<input type="button" value="Less" id="lessRev" />
	<input type="button" value="More" id="moreRev" />
	</c:if>	
	</div>
</body>
</html>