<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Recommendations!</title>
</head>
<body>
	<form:form methodAttribute="user">
		<table border=1>
			<tr> <th>Movie</th><th>action</th> </tr>
			<c:forEach items="${user.recommendations}" var="movie" varStatus="status">
				<tr>
					<td>${movie.tite}</td>
					<td>
						<a href="removeRec.html?index=${status.index}&userId=${user.userId}">
						<img src="../images/delete.png"></img></a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form:form>
</body>
</html>