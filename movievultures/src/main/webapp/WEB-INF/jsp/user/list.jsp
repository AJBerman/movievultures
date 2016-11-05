<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List of Users</title>
</head>
<body>
	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		<a href="home.html?username=<security:authentication property="principal.username" />"> 
			<security:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>" >Logout</a>
	</p>

	<table border=1>
	<tr><th>User ID</th> <th>Username</th></tr>
	<c:forEach items="${users}" var="user" varStatus="status">
		<tr>
		<td>${user.userId}</td>
		<td>${user.username}</td>
		<td><a href="view.html?userId=${user.userId}">view</a>
		<security:authorize access="hasRole('ROLE_ADMIN')">
			| <a href="authorize.html?userid=${user.userId}">Authorize</a>
		</security:authorize>
		
		
		</td>
		</tr>
	</c:forEach>
	</table>
	
	
	
</body>
</html>