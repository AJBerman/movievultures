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
<title>"There's no place like home"</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<c:url value="/res/js/userHome.js" />"></script>
</head>
<body>
	<nav class="navbar navbar-inverse">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
	</div>
	<div class="navbar-collapse collapse">
		<ul class="nav navbar-nav navbar-left">
			<li><a href="/movievultures/home.html">Movie Vultures</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<security:authorize access="isAuthenticated()">
				<li><a href="<c:url value='/' /> ">Main</a></li>
				<li><a href="<c:url value='/logout' />">Logout</a></li>
			</security:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="../user/list.html">Management</a></li>
			</sec:authorize>
		</ul>
	</div>
	</nav>
	<%-- <p align="right">
		<security:authorize access="isAuthenticated()">
			<a href="<c:url value='/' /> ">Main</a> |
			<a href="<c:url value='/logout' />">Logout</a> 
		</security:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">Management</a>
		</sec:authorize>
	</p> --%>
	<div class="container">
	<h2>Welcome ${user.username}</h2>
	
	<h3>Profile:</h3> <a href="profile.html?userId=${user.userId}">Edit Profile</a>
	
	<table class="table table-bordered table-striped table-hover">
		<tr><th>Member #: </th><td>${user.userId }</td></tr>
		<tr><th>Username:</th> <td>${user.username}</td></tr>
		<tr><th>e-mail: </th><td>${user.email}</td></tr>
	</table>
	
	
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
		<table id="fav" class="table table-bordered table-striped table-hover">
			<tr><th>Title</th><th>action</th></tr>
			<c:forEach items="${user.favorites}" var="movie" varStatus="status" >
				<tr>
					<td><a href="../movies/details2.html?id=${ movie.movieId }">${movie.title }</a></td>
					<td>
						<a href="removeFav.html?index=${status.index}&userId=${user.userId}">
							<img src="../images/delete.png"></img> Delete
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
		<table id="watch" class="table table-bordered table-striped table-hover">
			<tr><th>Title</th><th>action</th></tr>
			<c:forEach items="${user.watchLater}" var="movie" varStatus="status" >
				<tr>
					<td><a href="../movies/details2.html?id=${ movie.movieId }">${movie.title }</a></td>
					<td>
						<a href="removeWL.html?index=${status.index}&userId=${user.userId}">
							<img src="../images/delete.png"></img> Delete
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
		<input type="button" value="Less" id="lessWatch" />
		<input type="button" value="More" id="moreWatch" />
	</c:if>

	<h3>Reviewed Movies:</h3>
	<c:if test="${empty user.reviewedMovies}">
		<p>You haven't reviewed any movies yet!</p>
	</c:if>
	<c:if test= "${not empty user.reviewedMovies}">
		<table id="reviews" class="table table-bordered table-striped table-hover">
			<tr><th>Movie Title</th> <th>Rating</th><th>Operations</th></tr>
			<c:forEach items="${user.reviewedMovies}" var="review" varStatus="status">
				<tr>
					<td><a href="../movies/details2.html?id=${ review.movie.movieId }">${review.movie.title}</a></td>
					<td>${review.rating }  <img height="15" width="15" src="http://st.depositphotos.com/1216158/4699/v/170/depositphotos_46997115-stock-illustration-yellow-stars-vector-illustration-single.jpg"></td>
					<td>
						<a href="../review/edit.html?id=${review.movie.movieId}">Edit</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if> 
	</div>
</body>
</html>