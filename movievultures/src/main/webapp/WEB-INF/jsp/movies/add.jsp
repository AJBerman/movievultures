<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

	<div class="container">
	<p align="left">
		<a href="/movievultures/">Back</a>
	</p>
	<center>
	<h1>Add a New Movie</h1></center>
		<form:form modelAttribute="movie">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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
					<form:textarea style="width: 50%; height: 300px;" class="form-control"
						placeholder="Enter plot of the movie"
						path="plot"></form:textarea>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Date</div>
				<div class="col-xs-10">
					<form:input type="date" id="moviedate" placeholder="YYYY" path="date" /><br />
					<font color="red"><form:errors path="date" /></font>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Genre(s)</div>
				<div class="col-xs-10">
					<span id="genres">
						<span id="genre1">
						<br />
						<input type="text" class="form-control" placeholder="Horror, Comedy,....." name="addmovie_genres"/>
							<a onclick="$('#genre1').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</span>
					<a onclick="addGenre()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Cast</div>
				<div class="col-xs-10">
					<span id="actors">
						<span id="actor1">
						<br />
						<input type="text" class="form-control" placeholder="Fay Wray, Ronald Reagan,....." name="addmovie_actors"/>
							<a onclick="$('#actor1').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						</span>
					</span>
					<a onclick="addActor()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Director(s)</div>
				<div class="col-xs-10">
					<span id="directors">
					<span id="director1">
					<br />
					<input type="text" class="form-control" placeholder="Wes Anderson, Woody Allen,....." name="addmovie_directors"/>
						<a onclick="$('#director1').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
					</span>
					</span>
					<a onclick="addDirector()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a>
				</div>
				<br />
			</div>
			<input type="submit" class="btn btn-primary" />
		</form:form>
	</div>
	
	
<script>
function addGenre() {
	var id = Date.now()
	$('#genres').append( '<span id="genre' + id + '"><br /><input type="text" class="form-control" placeholder="Horror, Comedy,....." name="addmovie_genres""/> <a onclick="$(\'#genre' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
function addActor() {
	var id = Date.now()
	$('#actors').append( '<span id="actor' + id + '"><br /><input type="text" class="form-control" placeholder="Fay Wray, Ronald Reagan,....." name="addmovie_actors""/> <a onclick="$(\'#actor' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
function addDirector() {
	var id = Date.now()
	$('#directors').append( '<span id="director' + id + '"><br /><input type="text" class="form-control" placeholder="Wes Anderson, Woody Allen,....." name="addmovie_directors"/> <a onclick="$(\'#director' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a></span>' );
}
</script>
