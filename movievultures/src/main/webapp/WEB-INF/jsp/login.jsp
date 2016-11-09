<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome back~</title>
</head>
<body>
	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="!isFullyAuthenticated()">
			<a href="user/register.html">Register</a>
		</sec:authorize>
	</p>
	
	<jsp:include page="search/searchMovies2.jsp" />
	<br /><a href="/movievultures/home.html"><img src="images/MV_banner.png" alt="Banner of Movie Vultures" /></a><br />

	<c:if test="${not empty error}">
      <font color="red">
        Your login attempt was not successful.<br/>
        Reason: <i>${SPRING_SECURITY_LAST_EXCEPTION.message}</i>
      </font>
	</c:if>

<form name="login" action="<c:url value='/login' />" method="post">
<table class="general" style="width: auto;">
  <tr>
    <th>Username:</th>
    <td><input type="text" name="username" /></td>
  </tr>
  <tr>
    <th>Password:</th>
    <td><input type="password" name="password" /></td>
  </tr>
  <tr>
    <td colspan="2">
  	  <br />
      <input class="submit" type="submit" name="login" value="Login" />
      <input class="reset" type="reset" value="Clear" />
    </td>
  </tr>
</table>
</form>

</body>
</html>