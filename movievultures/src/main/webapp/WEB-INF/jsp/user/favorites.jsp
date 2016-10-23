<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Favorites</title>
</head>
<body>
	<form:form modelAttribute="user">
		<table border=1>
			<tr><th>Movie Title</th></tr>
			<c:forEach items="${user.favorites}" var="movie" varStatus="status">
				<tr>
					<td>${movie.title }</td>
					<td>
						<a href="removeFav.html?index=${status.index}&userId=${user.userId}">X</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form:form>
</body>
</html>