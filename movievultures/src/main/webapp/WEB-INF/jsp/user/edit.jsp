<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Go ahead, make my day.</title>
</head>
<body>
	<form:form modelAttribute="user">
	Username: ${user.username}<br />
	Password: <form:input path="password" /><br />
	
	<h3>Recommendations: </h3>
	<c:choose>
		<c:when test="${not empty user.recommendations}" >
			<table border=1>
				<tr><th>Movie</th></tr>
				<tr>
					<form:checkboxes path="recommendations" items="${user.recommendations}" />
					
				</tr>
			</table>
		</c:when>
	</c:choose>
	
	<input type="submit" name="save" value="save" />
	</form:form>
</body>
</html>