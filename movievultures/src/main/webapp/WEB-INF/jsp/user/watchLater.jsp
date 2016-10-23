<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movie Queue</title>
</head>
<body>
	<table border=1>
		<tr><td>Movie title</td> Action</tr>
		<c:forEach items="${user.watchLater}" var="movie" varStatus="status">
			<tr>
				<td>${movie.title}</td>
				<td>
					<form action="watchLater.html?${_csrf.parameterName}=${_csrf.token}" method="POST">
						<input type="hidden" name="index" value="${status.index}">
						<input type="hidden" name="userId" value="${user.userId }">
						<input type="hidden"  name="${_csrf.parameterName}"   value="${_csrf.token}"/>
						<input type="image" src="../images/delete.png" alt="Submit">
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>