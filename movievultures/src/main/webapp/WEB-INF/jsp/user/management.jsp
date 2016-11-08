<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Management</title>
</head>
<body>

	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		<a href="home.html?username=<sec:authentication property="principal.username" />"> 
			<sec:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>" >Logout</a>
	</p>
	<h2>Update User Privileges</h2>

	<table>
		<tr>
			<td><b>Id Number: </b></td>
			<td>${user.userId}<br /></td>
		</tr>
		<tr>
			<td><b>Username: </b></td>
			<td>${user.username}</td>
		</tr>
		<tr><td><b>Status: </b></td>
		<td>
		<c:choose>	
			<c:when test="${user.enabled}">
				<i><font color="green">enabled</font></i>
			</c:when>
			<c:when test="${!user.enabled}">
				<i><font color="red">disabled</font></i>
			</c:when>
		</c:choose>
		</td>
		</tr>

	</table>
	<br />
	<%-- if user isn't authority, authorize --%>
	<c:set var="contains" value="false" />
	<c:forEach var="role" items="${user.roles}">
  		<c:if test="${role == 'ROLE_ADMIN'}">
    		<c:set var="contains" value="true" />
  		</c:if>
	</c:forEach>
	<c:choose>
		<c:when test="${!contains}">
			<%-- Authorize <form:checkbox path="authorize"/>--%>
			<form:form modelAttribute="user">
				Authorize <input type="checkbox" name="authority" /> <br />
				<form:radiobutton path="enabled" value="1"/>enable
				<form:radiobutton path="enabled" value="0"/>disable
				<br />
				<input type="submit" name="edit" value="Update" />
			</form:form>
		</c:when>
		<c:when test="${contains}">
			<i>This user is an administrative user. Can't edit privileges.</i>
		</c:when>
	</c:choose>
	
</body>
</html>