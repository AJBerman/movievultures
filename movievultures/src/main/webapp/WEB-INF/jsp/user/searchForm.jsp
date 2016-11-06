<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Search</title>
</head>
<body>
	<form action="<c:url value="/user/searchResults.html" />" method="POST">
		Search: <input type="text" name="nameQuery" value="Username" >
		<input name="search" type="submit" value="Search"/>
	</form>
</body>
</html>