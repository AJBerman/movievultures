<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

	<div class="container">
		<h3>From the choices below, please select the movie you believe
			is better.</h3>

		<table class="table table-bordered table-striped table-hover">
			<tr>
				<th>Title</th>
				<td><a href="<c:url value="/movies/details2?id=${ movie1.movieId }" />"
					target="_blank">${movie1.title}</a></td>
				<td><a href="<c:url value="/movies/details2?id=${ movie2.movieId }" />"
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

				<td><a href="add?movie2=${movie2.movieId}">Switch
						First Movie?</a> | <a href="add?movie1=${movie1.movieId}">Switch
						Second Movie?</a></td>

				<td><a href="add">New Match?</a></td>
			</tr>
		</table>
	</div>