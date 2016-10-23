<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List of Users</title>
</head>
<body>
	<form action="/logout" method="POST">
  		<input name="_csrf" type="hidden" value="${_csrf.token}" />
  		<input name="submit" type="submit" value="Logout" />
	</form>

	<table border=1>
	<tr><th>User ID</th> <th>Username</th></tr>
	<c:forEach items="${users}" var="user" varStatus="status">
		<tr>
		<td>${user.userId}</td>
		<td>${user.username}</td>
		<td><a href="view.html?userId=${user.userId}">view</a></td>
		</tr>
	</c:forEach>
	</table>
	
	
	
</body>
</html>