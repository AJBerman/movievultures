<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>Editing ${review.movie.title} review</title>
<link rel="stylesheet" type="text/css"
	href="/movievultures/res/css/starrating.css">
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
					<li><a href="<c:url value='/login.html'/>">Login</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li><a
						href="../user/home.html?username=<sec:authentication property="principal.username" />">
							<sec:authentication property="principal.username" />
					</a></li>
					<li><a
						href="../movies/details2.html?id=${review.movie.movieId}">${review.movie.title}</a>
					</li>
					<li><a href="<c:url value='/logout' />">Logout</a></li>
				</sec:authorize>
			</ul>
		</div>
	</nav>
	<%-- <p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="isAuthenticated()">
			<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="../movies/details2.html?id=${review.movie.movieId}">${review.movie.title}</a> |
			<a href="<c:url value='/logout'/>" >Logout</a>
		</sec:authorize>
	</p> --%>

	<div class="container">
	<form:form modelAttribute="review">
		<table class="table table-bordered table-hover table-striped">
			<tr>
				<td>Movie Title</td>
				<td>${review.movie.title}</td>
			</tr>
			<tr>
				<td>Released</td>
				<td><fmt:formatDate value="${review.movie.date}" pattern="yyyy" /></td>
			</tr>
		</table>
		<fieldset class="rating">
			<form:radiobutton path="rating" id="star5" name="rating" value="5" />
			<label class="full" for="star5" title="Awesome - 5 stars"></label>
			<form:radiobutton path="rating" id="star4half" name="rating"
				value="4.5" />
			<label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
			<form:radiobutton path="rating" id="star4" name="rating" value="4" />
			<label class="full" for="star4" title="Pretty good - 4 stars"></label>
			<form:radiobutton path="rating" id="star3half" name="rating"
				value="3.5" />
			<label class="half" for="star3half" title="Meh - 3.5 stars"></label>
			<form:radiobutton path="rating" id="star3" name="rating" value="3" />
			<label class="full" for="star3" title="Meh - 3 stars"></label>
			<form:radiobutton path="rating" id="star2half" name="rating"
				value="2.5" />
			<label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
			<form:radiobutton path="rating" id="star2" name="rating" value="2" />
			<label class="full" for="star2" title="Kinda bad - 2 stars"></label>
			<form:radiobutton path="rating" id="star1half" name="rating"
				value="1.5" />
			<label class="half" for="star1half" title="Meh - 1.5 stars"></label>
			<form:radiobutton path="rating" id="star1" name="rating" value="1" />
			<label class="full" for="star1" title="Sucks big time - 1 star"></label>
			<form:radiobutton path="rating" id="starhalf" name="rating"
				value="0.5" />
			<label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
		</fieldset>
		<br />
		<br />
		<form:textarea type="text" class="form-control" path="review" rows="6" />
		<form:input path="reviewId" type="hidden" value="${review.reviewId}" />
		<br />
		<br />
		<center>
		<input type="submit" class="btn btn-primary" value="Submit">
		</center>
	</form:form>
	</div>
</body>
</html>
