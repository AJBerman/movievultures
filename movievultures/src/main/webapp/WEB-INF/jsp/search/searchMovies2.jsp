<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
	integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
	crossorigin="anonymous"></script>
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

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.11.2/css/bootstrap-select.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.11.2/js/bootstrap-select.min.js"></script>

<!-- (Optional) Latest compiled and minified JavaScript translation files -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.11.2/js/i18n/defaults-*.min.js"></script>

<title>Search for a Movie</title>
</head>
<body>
	<form class="form-inline" name="searchForm" action="/movievultures/search/searchMovies4.html" onsubmit="return numCheck()" method="get">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<div class="input-group">
			<div class="input-group-addon">Search</div>
			<input placeholder="Search for..." class="form-control" type="text" name="searchTerm" />
		</div>
		
		<select class="selectpicker" data-live-search="true" id="searchType" name="type">
	 		<option value="9">General Search</option>
	 		<option value="10">General Search (Indexable)</option>
			<option value="1">Title</option>
			<option value="2">Genre</option>
			<option value="3">Director</option>
			<option value="4">Artist (Actor/Actress)</option>
			<option value="5">Year of Release</option>
			<option value="6">User Rating</option>
			<option value="7">Elo Rating</option>
			<option value="8">Random Movies</option>
		</select> 
		<select id="comparator" name="comparator">
			<option value="3" selected="selected">=</option>
			<option value="4">!=</option>
			<option value="1">></option>
			<option value="2"><</option>
		</select> 
		<input class="btn btn-primary" name="search" type="submit" value="GO"/>
	</form>
	<script>
		$("#comparator").hide();
		$("#searchType").bind("change", function() {
			if ($(this).val() > "4" && $(this).val() < "8") {
				$("#comparator").show();
			} else {
				$("#comparator").hide();
			}
		});
	</script>
	<script>
	//http://stackoverflow.com/questions/18042133/check-if-input-is-number-or-letter-javascript
	//http://www.w3schools.com/js/js_validation.asp
	function numCheck() {
		var input = document.forms["searchForm"]["searchTerm"].value;
		var selection = document.forms["searchForm"]["type"].value;
		//console.log("INPUT: " + input);
		//console.log("TYPE: " + selection);
		if ( (selection == 5 || selection == 6 || selection == 7) && isNaN(input) ) {
			alert("The input is not a number");
			return false;
		}
	}
	</script>
</body>
</html>
