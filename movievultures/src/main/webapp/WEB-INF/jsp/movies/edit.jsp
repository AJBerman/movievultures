<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

	<div class="container">
	<p align="left">
		<a href="../movies/details2.html?id=${ movie.movieId }">Back</a>
	</p>

	<h1>${ movie.title }</h1>
		<form:form modelAttribute="movie">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<form:input type="hidden" path="movieId" />
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Title of the Movie</div>
				<div class="col-xs-10">
					<form:input class="form-control" type="text"
						placeholder="Enter title of the movie" path="title" /><br />
						<font color="red"><form:errors path="title" /></font>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Plot</div>
				<div class="col-xs-10">
					<textarea style="width: 50%; height: 300px;" class="form-control"
						placeholder="Enter plot of the movie" name="editmovie_plot"
						>${movie.plot}</textarea>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Date</div>
				<div class="col-xs-10">
					<form:input path="date" type="date"/><br />
					<font color="red"><form:errors path="date" /></font>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Genre(s)</div>
				<div class="col-xs-10">
					<span id="genres">
					<c:forEach items="${movie.genres}" var="genre" varStatus="stat">
						<span id="genre${stat.count}">
						<br />
						<input type="text" class="form-control" placeholder="Horror, Comedy,....." name="editmovie_genres" value="${genre}"/>
						<a onclick="$('#genre${stat.count}').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</c:forEach>
					</span>
					<a onclick="addGenre()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Cast</div>
				<div class="col-xs-10">
					<span id="actors">
					<c:forEach items="${movie.actors}" var="actor" varStatus="stat">
						<span id="actor${stat.count}">
						<br />
						<input type="text" class="form-control" placeholder="Fay Wray, Ronald Reagan,....." name="editmovie_actors" value="${actor}"/>
						<a onclick="$('#actor${stat.count}').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</c:forEach>
					</span>
					<a onclick="addActor()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Director(s)</div>
				<div class="col-xs-10">
					<span id="directors">
					<c:forEach items="${movie.directors}" var="director" varStatus="stat">
						<span id="director${stat.count}">
						<br />
						<input type="text" class="form-control" placeholder="Wes Anderson, Woody Allen,....." name="editmovie_directors" value="${director}"/>
						<a onclick="$('#director${stat.count}').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</c:forEach>
					</span>
					<a onclick="addDirector()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<input type="submit" class="btn btn-primary" value="Update"/>
		</form:form>
		 
	</div>
	
<script>
function addGenre() {
	var id = Date.now()
	$('#genres').append( '<span id="genre' + id + '"><br /><input type="text" class="form-control" placeholder="Horror, Comedy,....." name="editmovie_genres""/> <a onclick="$(\'#genre' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
function addActor() {
	var id = Date.now()
	$('#actors').append( '<span id="actor' + id + '"><br /><input type="text" class="form-control" placeholder="Fay Wray, Ronald Reagan,....." name="editmovie_actors""/> <a onclick="$(\'#actor' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
function addDirector() {
	var id = Date.now()
	$('#directors').append( '<span id="director' + id + '"><br /><input type="text" class="form-control" placeholder="Wes Anderson, Woody Allen,....." name="editmovie_directors"/> <a onclick="$(\'#director' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
</script>
