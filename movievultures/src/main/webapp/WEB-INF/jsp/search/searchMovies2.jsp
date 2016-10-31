<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search for a Movie</title>
</head>
<body>	 
	 <form action ="/movievultures/search/searchMovies4.html" method="post">
	 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	 	Search: <input type="text" name="searchTerm" />
	 	
	 	<select id="searchType" name="type">
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
	 		<option value="1">></option>
	 		<option value="2"><</option>
	 		<option value="3">=</option>
	 		<option value="4">!=</option>
	 	</select>
	 	
	 	<input name="search" type="submit" value="Go"/>
	 </form>
	<script>
    $("#comparator").hide();
	$("#searchType").bind("change", function() {
	    if ($(this).val() > "4" && $(this).val() < "8") {
	        $("#comparator").show();
	    }
	    else {
	        $("#comparator").hide();
	    }
	});</script>
	
</body>
</html>
