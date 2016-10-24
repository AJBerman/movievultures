<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search for a Movie</title>
</head>
<body>
	<h2>Movies</h2>
	 
	 <form action ="searchResults.html" method="post">
	 	Search: <input type="text" name="searchTerm" />
	 	
	 	<select name="type">
	 		<option value="1">Title</option>
	 		<option value="2">Genre</option>
	 		<option value="3">Director</option>
	 		<option value="4">Artist (Actor/Actress)</option>
	 		<option value="5">Less Than this Year of Release</option>
	 		<option value="6">Greater Than this Year of Release</option>
	 		<option value="7">Equal to this Year of Release</option>
	 		<option value="8">Less Than this User Rating</option>
	 		<option value="9">Greater Than this User Rating</option>
	 		<option value="10">Equal to this User Rating</option>
	 		<option value="11">Less Than this Elo Rating</option>
	 		<option value="12">Greater Thank this Elo Rating</option>
	 		<option value="13">Equal to this Elo Rating</option>
	 	</select>
	 	
	 	<input name="search" type="submit" value="Go"/>
	 </form>
	
</body>
</html>