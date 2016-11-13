<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
<title>Home</title>
</head>
<body>
	<%-- ===== REGISTRATION AUTHENTICATION ===== --%>
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
			<sec:authorize access="!isFullyAuthenticated()">
				<li><a href="user/register.html">Register</a></li>
				<li><a href="login.html">Login</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li><a
					href="user/home.html?username=<sec:authentication property="principal.username" />">
						<sec:authentication property="principal.username" />
				</a></li>
				<li><a href="logout">Logout</a></li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="user/list.html">Management</a></li>
			</sec:authorize>
		</ul>
	</div>
	</nav>




	<%-- <p align="right">
		<sec:authorize access="!isFullyAuthenticated()">
			<a href="user/register.html">Register</a> |
			<a href="login">Login</a>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<a href="user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="logout">Logout</a> 
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="user/list.html">Management</a>
		</sec:authorize>
	</p> --%>
	
	<div class="container">
		
		<%-- ========= CONTENT VISIBLE ON PAGE =========== --%>
		<jsp:include page="./search/searchMovies2.jsp" /><br /> 
		<!-- <a href="/movievultures/home.html"><img src="./images/MV_banner.png" alt="Banner of Movie Vultures" /></a> <br /> -->


		<%-- ===== LOGIN AUTHENTICATION ===== --%>
		<br />
		<sec:authorize access="isAuthenticated()">
			<a href="elo/add.html">Elo Rate two random movies</a> |
			<a href="movies/add.html">Add a new movie</a>
		</sec:authorize>

		<%-- ===== NOT LOGGED IN ===== --%>
		<sec:authorize access="!isFullyAuthenticated()">
			<h2>Films</h2>
			<c:choose>
				<c:when test="${ not empty movies }">
					<table class="table table-bordered">
						<c:forEach items="${movies}" var="movie" varStatus="status">
							<tr>
								<td><b>Title:</b> <a
									href="movies/details2.html?id=${movie.movieId}">${movie.title}</a>
									<br /> <b>Director(s):</b> <c:forEach
										items="${movie.directors}" var="dir" varStatus="status">
									${dir},  
								</c:forEach><br /> <b>Cast:</b> <c:forEach items="${movie.actors}"
										var="actor" varStatus="status">
									${actor}, 
								</c:forEach><br /> <b>Genre:</b> <c:choose>
										<c:when test="${ not empty movie.genres }">
											<c:forEach items="${movie.genres}" var="genre"
												varStatus="status">
										| ${genre} |
									</c:forEach>
										</c:when>
										<c:otherwise>
									Not available.
								</c:otherwise>
									</c:choose> <br /> <br /> <b>Plot:</b>
									<p>${movie.plot}</p></td>
							</tr>
						</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
				There are no movies to display.
			</c:otherwise>
			</c:choose>
		</sec:authorize>

		<%-- ===== DISPLAY MOVIES OF: RANDOM (not logged in) / FAVORITES (logged in) ===== --%>

		<sec:authorize access="isAuthenticated()">
			<h2>Favorites</h2>

			<c:choose>
				<c:when test="${ not empty movies }">
					<table class="table table-bordered">
						<c:forEach items="${movies}" var="movie" varStatus="status">
							<tr>
								<td><b>Title:</b> <a
									href="movies/details2.html?id=${movie.movieId}">${movie.title}</a>
									<br /> <b>Director(s):</b> <c:forEach
										items="${movie.directors}" var="dir" varStatus="status">
									${dir},  
								</c:forEach><br /> <b>Cast:</b> <c:forEach items="${movie.actors}"
										var="actor" varStatus="status">
									${actor}, 
								</c:forEach><br /> <b>Genre:</b> <c:choose>
										<c:when test="${ not empty movie.genres }">
											<c:forEach items="${movie.genres}" var="genre"
												varStatus="status">
										| ${genre} |
									</c:forEach>
										</c:when>
										<c:otherwise>
									Not available.
								</c:otherwise>
									</c:choose> <br /> <br /> <b>Plot:</b>
									<p>${movie.plot}</p></td>
							</tr>
						</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
				There are no movies to display.
			</c:otherwise>
			</c:choose>
			<br />

			<h2>Watch Later</h2>

			<c:choose>
				<c:when test="${ not empty movies2 }">
					<table border=1>
						<c:forEach items="${movies2}" var="movie2" varStatus="status">
							<tr>
								<td><b>Title:</b> <a
									href="movies/details2.html?id=${movie2.movieId}">${movie2.title}</a>
									<br /> <b>Director(s):</b> <c:forEach
										items="${movie2.directors}" var="dir2" varStatus="status">
									${dir2},  
								</c:forEach><br /> <b>Cast:</b> <c:forEach items="${movie2.actors}"
										var="actor2" varStatus="status">
									${actor2}, 
								</c:forEach><br /> <b>Genre:</b> <c:choose>
										<c:when test="${ not empty movie2.genres }">
											<c:forEach items="${movie2.genres}" var="genre"
												varStatus="status">
										| ${genre} |
									</c:forEach>
										</c:when>
										<c:otherwise>
									Not available.
								</c:otherwise>
									</c:choose> <br /> <br /> <b>Plot:</b>
									<p>${movie2.plot}</p></td>
							</tr>
						</c:forEach>
					</table>
				</c:when>
				<c:otherwise>
				There are no movies to display.
			</c:otherwise>
			</c:choose>
		</sec:authorize>
	</div>
</body>
</html>