<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<title>Search for a Movie</title>
<style>
mark {
	background: yellow;
}

.marked {
	background: yellow;
}
</style>
<!-- For search highlighting -->
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
			<sec:authorize access="!isFullyAuthenticated()">
				<li><a href="<c:url value='/' />">Main</a></li>
				<li><a href="../user/register.html">Register</a></li>
				<li><a href="<c:url value='/login.html'/>">Login</a></li>
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
	
	<sec:authorize access="!isFullyAuthenticated()">
		<a href="../user/register.html">Register</a> |
		<a href="<c:url value='/login'/>">Login</a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
		 	<sec:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>">Logout</a>
	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">All Users</a>
	</sec:authorize>
	</p> --%>
	<div class="container">
		<jsp:include page="searchMovies2.jsp" />

		<!-- <p><a href="/movievultures/home.html"><img src="../images/MV_banner.png" alt="Banner of Movie Vultures" /></a></p> -->

		<c:set var="res" value="0" />
		<c:forEach items="${ movieResults }" var="movieResult">
			<c:if test="${ !movieResult.hidden }">
				<c:set var="res" value="${ res + 1 }" />
			</c:if>
		</c:forEach>

		<h2>MOVIE RESULTS: ( ${ res } result(s) )</h2>
		<h4>
			Where <span id="searchResultType">${type}</span> <span
				id="comparator">${comparator}</span> <span id="searchResultTerm">${searchTerm}</span>
		</h4>

		<hr>
		<hr>
		<br />
		<div class="panel panel-default">
			<div class="panel-body">
				<c:choose>
					<c:when test="${ not empty movieResults }">
						<c:forEach items="${ movieResults }" var="movieResult"
							varStatus="status" begin="0" end="20">
							<c:if test="${ !movieResult.hidden }">
								<b>Movie Title</b>: <a class="movieTitle"
									href="../movies/details2.html?id=${ movieResult.movieId }">${ movieResult.title }</a>
								<br />
								<b>Year of Release</b>: <span class="movieYear"><fmt:formatDate
										value="${ movieResult.date }" pattern="yyyy" /></span>
								<br />
								<b>Total Elo Rating</b>: <span class="movieElo"><fmt:formatNumber
										type="number" maxFractionDigits="2"
										value="${movieResult.eloRating}" /></span>
								<br />

								<c:set var="sum" value="0" />
								<c:forEach items="${ movieResult.reviews }" var="r">
									<c:set var="sum" value="${ sum + r.rating }" />
								</c:forEach>
								<b>Total User Rating</b>: <span class="movieRating"><fmt:formatNumber
										type="number" maxFractionDigits="0"
										value="${sum/fn:length(movieResult.reviews)}" /></span>
								<br />
								<!-- c:url is used here to url-encode the genre/director/actor, so if their name is "null&illegalargument=foo" we don't get funny business. -->
								<b>Genres</b>: <c:forEach items="${ movieResult.genres }"
									var="g">| <span class="movieGenre"> <c:url
											value="searchMovies4.html" var="myURL">
											<c:param name="searchTerm" value="${g}" />
											<c:param name="type" value="2" />
											<c:param name="comparator" value="3" />
										</c:url> <a href="${myURL}">${g}</a>
									</span> |</c:forEach>
								<br />
								<b>Directors</b>: <c:forEach items="${ movieResult.directors }"
									var="d">| <span class="movieDirector"> <c:url
											value="searchMovies4.html" var="myURL">
											<c:param name="searchTerm" value="${d}" />
											<c:param name="type" value="3" />
											<c:param name="comparator" value="3" />
										</c:url> <a href="${myURL}">${d}</a>
									</span> |</c:forEach>
								<br />
								<b>Artists</b>: <c:forEach items="${ movieResult.actors }"
									var="a">| <span class="movieActor"> <c:url
											value="searchMovies4.html" var="myURL">
											<c:param name="searchTerm" value="${a}" />
											<c:param name="type" value="4" />
											<c:param name="comparator" value="3" />
										</c:url> <a href="${myURL}">${a}</a>
									</span> |</c:forEach>
								<br />
								<br />
								<b>===== Short Plot Summary =====</b>
								<br />
								<span class="moviePlot">${movieResult.plot}</span>
								<br />
								<br />
								<hr>
								<br />
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
			No results were found.
		</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<script src="/movievultures/res/js/jquery-3.1.1.min.js"></script>
	<!-- For search highlighting -->
	<script src="/movievultures/res/js/jquery.mark.js"></script>
	<!-- For search highlighting -->
	<script>
		//at the bottom so it can mutate existing text.
		$(document).ready(function() {
			console.log($("#searchResultTerm").text());
			switch ($("#searchResultType").text()) {
			case "title":
				$(".movieTitle").mark($("#searchResultTerm").text(), {
					diacritics : false,
					debug : true
				});
				break;
			case "genre":
				$(".movieGenre").mark($("#searchResultTerm").text(), {
					diacritics : false,
					debug : true
				});
				break;
			case "director":
				$(".movieDirector").mark($("#searchResultTerm").text(), {
					diacritics : false,
					debug : true
				});
				break;
			case "actor":
				$(".movieActor").mark($("#searchResultTerm").text(), {
					diacritics : false,
					debug : true
				});
				break;
			case "year of release":
				$(".movieYear").addClass("marked");
				break;
			case "user rating":
				$(".movieRating").addClass("marked");
				break;
			case "Elo rating":
				$(".movieElo").addClass("marked");
				break;
			default:
				console.log("Foo!");
				break;
			}
		});
	</script>

</body>
</html>
