<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Rating ${review.movie.title}</title>
<link rel="stylesheet" type="text/css" href="/movievultures/res/css/starrating.css">
</head>
<body>
	<p align="right">
		<security:authorize access="isAuthenticated()">
			<a href="<c:url value='/'/>/user/home.html?username=<security:authentication property="principal.username" />" >
		<security:authentication property="principal.username" /> </a> |
			<a href="<c:url value='/' /> ">Main</a> |
			<a href="<c:url value='/logout' />">Logout</a> 
		</security:authorize>
	</p>

	<form:form modelAttribute="review">
		<table border="1">
			<tr>
			  <td>Movie Title</td>
			  <td>${review.movie.title}</td>
			</tr>
			<tr>
			  <td>Released</td>
			  <td><fmt:formatDate value="${review.movie.date}" pattern="yyyy" /></td>
			</tr>
		</table>
		
		<fieldset class="rating">
		    <form:radiobutton path="rating" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
		    <form:radiobutton path="rating" id="star4half" name="rating" value="4.5" /><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
		    <form:radiobutton path="rating" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
		    <form:radiobutton path="rating" id="star3half" name="rating" value="3.5" /><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
		    <form:radiobutton path="rating" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
		    <form:radiobutton path="rating" id="star2half" name="rating" value="2.5" /><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
		    <form:radiobutton path="rating" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
		    <form:radiobutton path="rating" id="star1half" name="rating" value="1.5" /><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
		    <form:radiobutton path="rating" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
		    <form:radiobutton path="rating" id="starhalf" name="rating" value="0.5" /><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
		</fieldset>
		<br />
		<br />
		<form:textarea type="text" path="review" rows="6" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="submit" value="Submit">
	</form:form>
	
</body>
</html>
