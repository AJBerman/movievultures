<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<script src="../res/js/jquery-3.1.1.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a New Movie</title>

<script>
function addGenre() {
	var id = Date.now()
	$('#genres').append( '<span id="genre' + id + '"><input type="text" class="form-control" placeholder="Horror, Comedy,....." name="editmovie_genres""/> <a onclick="$(\'#genre' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a><br /></span>' );
}
function addActor() {
	var id = Date.now()
	$('#actors').append( '<span id="actor' + id + '"><input type="text" class="form-control" placeholder="Fay Wray, Ronald Reagan,....." name="editmovie_actors""/> <a onclick="$(\'#actor' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a><br /></span>' );
}
function addDirector() {
	var id = Date.now()
	$('#directors').append( '<span id="director' + id + '"><input type="text" class="form-control" placeholder="Wes Anderson, Woody Allen,....." name="editmovie_directors"/> <a onclick="$(\'#director' + id +'\').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a><br /></span>' );
}
</script>
</head>

<body>
	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="isAuthenticated()">
			<a href="../user/home.html?username=<sec:authentication property="principal.username" />" >
			 	<sec:authentication property="principal.username" /></a> |
			<a href="<c:url value='/logout'/>"   >Logout</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
				| <a href="../user/list.html">All Users</a>
		</sec:authorize>
	</p>
	
	<p align="left">
		<a href="/movievultures/">Back</a>
	</p>

	<h1>Add a New Movie</h1>
	<div class="container">
		<form action="add.html" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Title of the Movie</div>
				<div class="col-xs-10">
					<input class="form-control" type="text"
						placeholder="Enter title of the movie" name="addmovie_title"
						required />
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Plot</div>
				<div class="col-xs-10">
					<textarea style="width: 50%; height: 300px;" class="form-control"
						placeholder="Enter plot of the movie" name="addmovie_plot"
						required></textarea>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Date</div>
				<div class="col-xs-10">
					<input type="date" name="addmovie_date" id="moviedate" 
					placeholder="YYYY"
					required />
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Genre(s) <a onclick="addGenre()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a></div>
				<div class="col-xs-10">
					<span id="genres">
						<span id="genre1">
						<input type="text" class="form-control" placeholder="Horror, Comedy,....." name="addmovie_genres"/>
							<a onclick="$('#genre1').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
							<br />
						</span>
					</span>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Cast <a onclick="addActor()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a></div>
				<div class="col-xs-10">
					<span id="actors">
						<span id="actor1">
						<input type="text" class="form-control" placeholder="Fay Wray, Ronald Reagan,....." name="addmovie_actors"/>
							<a onclick="$('#actor1').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
							<br />
						</span>
					</span>
				</div>
				<br />
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Director(s) <a onclick="addDirector()"><i style="color: green;" class="fa fa-plus-circle" aria-hidden="true"></i></a></div>
				<div class="col-xs-10">
					<span id="directors">
					<span id="director1">
					<input type="text" class="form-control" placeholder="Wes Anderson, Woody Allen,....." name="addmovie_directors"/>
						<a onclick="$('#director1').remove();"><i style="color: red;" class="fa fa-minus-circle" aria-hidden="true"></i></a>
						<br />
					</span>
					</span>
				</div>
				<br />
			</div>
			<input type="submit" class="btn btn-primary" />
		</form>
	</div>
</body>
</html>