<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
<title>Elo Rating: ${movie1.title} vs ${movie2.title}</title>
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
				<li><a href="user/register.html">Register</a></li>
				<li><a href=" <c:url value='/login'/>">Login</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><a
					href="../user/home.html?username=<sec:authentication property="principal.username" />">
						<sec:authentication property="principal.username" />
				</a></li>
				<li><a href="<c:url value='/logout'/>">Logout</a></li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="../user/list.html">All Users</a></li>
			</sec:authorize>
		</ul>
	</div>
	</nav>

	<%-- <p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="isAuthenticated()">
			<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="<c:url value='/logout'/>"   >Logout</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">All Users</a>
		</sec:authorize>
	</p> --%>

	<!-- <p><a href="/movievultures/home.html"><img src="../images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p> -->
	<div class="container">
		<h3>From the choices below, please select the movie you believe
			is better.</h3>

		<table class="table table-bordered table-striped table-hover">
			<tr>
				<th>Title</th>
				<td><a href="../movies/details2.html?id=${ movie1.movieId }"
					target="_blank">${movie1.title}</a></td>
				<td><a href="../movies/details2.html?id=${ movie2.movieId }"
					target="_blank">${movie2.title}</a></td>
			</tr>
			<tr>
				<th>Year</th>
				<td><fmt:formatDate value="${movie1.date}" pattern="yyyy" /></td>
				<td><fmt:formatDate value="${movie2.date}" pattern="yyyy" /></td>
			</tr>
			<tr>
				<th>Plot</th>
				<td>${movie1.plot}</td>
				<td>${movie2.plot}</td>
			</tr>
			<tr>
				<th>Director(s)</th>
				<td>${movie1.directors[0]}</td>
				<td>${movie2.directors[0]}</td>
			</tr>

			<c:forEach begin="1"
				end="${fn:length(movie1.directors) > fn:length(movie2.directors) ? fn:length(movie1.directors)-1 : fn:length(movie2.directors)-1 }"
				varStatus="loop">
				<tr>
					<td></td>
					<td>${movie1.directors[loop.index]}</td>
					<td>${movie2.directors[loop.index]}</td>
				</tr>
			</c:forEach>

			<tr>
				<th>Cast</th>
				<td>${movie1.actors[0]}</td>
				<td>${movie2.actors[0]}</td>
			</tr>

			<c:forEach begin="1"
				end="${fn:length(movie1.actors) > fn:length(movie2.actors) ? fn:length(movie1.actors)-1 : fn:length(movie2.actors)-1 }"
				varStatus="loop">
				<tr>
					<td></td>
					<td>${movie1.actors[loop.index]}</td>
					<td>${movie2.actors[loop.index]}</td>
				</tr>
			</c:forEach>

			<tr>
				<th>EloRating</th>
				<td>${movie1.eloRating}</td>
				<td>${movie2.eloRating}</td>
			</tr>
			<tr>
				<th>Vote</th>

				<td><form method="POST">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input type="hidden" name="winner"
							value="1"> <input class="btn btn-primary" type="submit" value="Better">
					</form></td>

				<td>
					<form method="POST">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" /> <input type="hidden" name="winner"
							value="2"> <input class="btn btn-primary" type="submit" value="Better">
					</form>
				</td>
			</tr>

			<tr bgcolor="#FFEB99">
				<th>Different Match</th>

				<td><a href="add.html?movie2=${movie2.movieId}">Switch
						First Movie?</a> | <a href="add.html?movie1=${movie1.movieId}">Switch
						Second Movie?</a></td>

				<td><a href="add.html">New Match?</a></td>
			</tr>
		</table>
	</div>
</body>
</html>