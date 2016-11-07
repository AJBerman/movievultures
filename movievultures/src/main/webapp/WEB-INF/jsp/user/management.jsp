<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Management</title>
</head>
<body>
	<h2>Update User Privileges</h2>
	<form:form modelAttribute="user">
	<table>
		<tr>
			<td><b>Id Number: </b></td>
			<td>${user.userId}<br /></td>
		</tr>
		<tr>
			<td><b>Username: </b></td>
			<td>${user.username}</td>
		</tr>
		<tr><td>Status: </td>
		<td>
		<c:choose>	
			<c:when test="${user.enabled}">
				<font color="green">enabled</font>
			</c:when>
			<c:when test="${!user.enabled}">
				<font color="red">disabled</font>
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
	<c:if test="${!contains}">
		<%-- Authorize <form:checkbox path="authorize"/>--%>
		Authorize <input type="checkbox" name="authority" /> <br />
	</c:if>
	<form:radiobutton path="enabled" value="1"/>enable
	<form:radiobutton path="enabled" value="0"/>disable
	<br />
	<input type="submit" name="edit" value="Update" />
	</form:form>
</body>
</html>