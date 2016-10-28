<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Profile</title>
</head>
<body>
	<form:form modelAttribute="user">
		Username: ${user.username}<br />
				<form:input path="username" type="hidden" value="${user.username }" />
		Password: <form:input path="password" /> <font color="red"><form:errors path="password" /></font><br />
		E-mail: <form:input path="email" /> <font color="red"><form:errors path="email" /></font><br />
		<input type="submit" name="update" value="Update" />
	</form:form>

</body>
</html>