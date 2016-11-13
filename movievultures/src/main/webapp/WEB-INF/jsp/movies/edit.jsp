<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>Edit</title>
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
			<li><a href="<c:url value='/' />">Main</a></li>
			<sec:authorize access="!isFullyAuthenticated()">
				<li><a href="../user/register.html">Register</a></li>
				<li><a href=" <c:url value='/login.html'/>">Login</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><a
					href="../user/home.html?username=<sec:authentication property="principal.username" />">
						<sec:authentication property="principal.username" />
				</a></li>
				<li><a href="<c:url value='/logout'/>">Logout</a></li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="../user/list.html">Management</a></li>
			</sec:authorize>
		</ul>
	</div>
	</nav>
	<%-- <p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="!isFullyAuthenticated()">
			<a href="../user/register.html">Register</a> |
			<a href= "<c:url value='/login'/>"  >Login</a>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="<c:url value='/logout'/>"   >Logout</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">All Users</a>
		</sec:authorize>
	</p> --%>
	<div class="container">
	<p align="left">
		<a href="../movies/details2.html?id=${ movie.movieId }">Back</a>
	</p>

	<h1>${ movie.title }</h1>
		<form action="edit.html?id=${movie.movieId}" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Title of the Movie</div>
				<div class="col-xs-10">
					<input class="form-control" type="text"
						placeholder="Enter title of the movie" value="${movie.title}"name="editmovie_title"
						required />
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Plot</div>
				<div class="col-xs-10">
					<textarea style="width: 50%; height: 300px;" class="form-control"
						placeholder="Enter plot of the movie" name="editmovie_plot"
						required>${movie.plot}</textarea>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Date</div>
				<div class="col-xs-10">
					<input type="date" value="<fmt:formatDate value="${ movie.date }" pattern="yyyy" />" name="editmovie_date" id="moviedate" required />
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Genre</div>
				<div class="col-xs-10">
					<input type="text" class="form-control"
						placeholder="Genre1, Genre2,....." name="editmovie_genres" value="${genres}" required>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Cast</div>
				<div class="col-xs-10">
					<input type="text" class="form-control"
						placeholder="Actor1, Actor2...." value="${actors}"name="editmovie_actors" required>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Director(s)</div>
				<div class="col-xs-10">
					<input type="text" class="form-control"
						placeholder="Director1,Director2...." value="${directors}" name="editmovie_directors"
						required>
				</div>
				<br />
			</div>
			<input type="submit" class="btn btn-primary" value="Update"/>

			<script type="text/javascript">
			var d=${movie.date}
				$(function() {
					$('#moviedate').datetimepicker({
						inline : true,
						sideBySide : true,
						setDate: d
					});
				});
				
			</script>
		</form>
	</div>
</body>
</html>