<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit</title>
</head>
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

<body>
	<div class="container">
		<form action="edit.html?id=${movie.movieId}" method="post">
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Title of the Movie</div>
				<div class="col-xs-10">
					<input class="form-control" type="text"
						placeholder="Enter title of the movie" value="${movie.title}"name="editmovie_title"
						required />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Plot</div>
				<div class="col-xs-10">
					<textarea class="form-control"
						placeholder="Enter plot of the movie" name="editmovie_plot"
						required>${movie.plot}</textarea>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Date</div>
				<div class="col-xs-10">
					<input type="date" value="${movie.date}" name="editmovie_date" id="moviedate" required />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Genre</div>
				<div class="col-xs-10">
					<input type="text" class="form-control"
						placeholder="Genre1, Genre2,....." name="editmovie_genres" value="${genres}" required>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Cast</div>
				<div class="col-xs-10">
					<input type="text" class="form-control"
						placeholder="Actor1, Actor2...." value="${actors}"name="editmovie_actors" required>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-xs-2 col-form-label">Director(s)</div>
				<div class="col-xs-10">
					<input type="text" class="form-control"
						placeholder="Director1,Director2...." value="${directors}" name="editmovie_directors"
						required>
				</div>
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