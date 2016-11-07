<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form name="login" action="<c:url value='/login' />" method="post">
<table class="general" style="width: auto;">
  <tr>
    <th>Username:</th>
    <td><input type="text" name="username" class="forminput" /></td>
  </tr>
  <tr>
    <th>Password:</th>
    <td><input type="password" name="password" class="forminput" /></td>
  </tr>
  <tr>
    <td colspan="2">
      <input type="checkbox" name="remember-me" />
      Remember me on this computer.
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <input class="submit" type="submit" name="login" value="Login" />
    </td>
  </tr>
</table>
</form>

</body>
</html>