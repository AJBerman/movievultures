<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
	integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
	integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	crossorigin="anonymous"></script>
<title>Welcome back~</title>
</head>
<body>
	<nav class="navbar navbar-inverse">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".navbar-collapse">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
	</div>
	<div class="navbar-collapse collapse">
		<ul class="nav navbar-nav navbar-left">
			<li><a href="/movievultures/home.html">Movie Vultures</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="<c:url value='/' />">Main</a></li>
			<sec:authorize access="!isFullyAuthenticated()">
				<li><a href="user/register.html">Register</a></li>
			</sec:authorize>
		</ul>
	</div>
	</nav>
	<%-- <p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="!isFullyAuthenticated()">
			<a href="user/register.html">Register</a>
		</sec:authorize>
	</p> --%>

	<div class="container">
		<jsp:include page="search/searchMovies2.jsp" />
	<br />
	<br />
	<!-- <br /><a href="/movievultures/home.html"><img src="images/MV_banner.png" alt="Banner of Movie Vultures" /></a><br /> -->

	<c:if test="${not empty error}">
		<font color="red"> Your login attempt was not successful.<br />
			Reason: <i>${SPRING_SECURITY_LAST_EXCEPTION.message}</i>
		</font>
	</c:if>
	<br />
	
		<div class="col-md-4">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h2 class="panel-title">Login</h2>
			</div>
			<div class="panel-body">
				<form name="login" class="input=group" action="<c:url value='/login' />" method="post">
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">Username</span>
						<input type="text" name="username" class="form-control"
							placeholder="Username" aria-describedby="basic-addon1" /><font
							color="red"><form:errors path="username" /></font>
					</div>
					<br />
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">Password</span>
						<input type="password" name="password" class="form-control"
							placeholder="Password" aria-describedby="basic-addon1" /><font
							color="red"><form:errors path="username" /></font>
					</div>
					<br />
					<center>New User? <a href="user/register.html">Register Here</a></center><br /><br />
					<center><input type="submit" value="Login" class="btn btn-primary"></center>
					<!-- <table class="general" style="width: auto;">
						<tr>
							<th>Username:</th>
							<td><input type="text" name="username" /></td>
						</tr>
						<tr>
							<th>Password:</th>
							<td><input type="password" name="password" /></td>
						</tr>
						<tr>
							<td colspan="2"><br /> <input class="submit" type="submit"
								name="login" value="Login" /> <input class="reset" type="reset"
								value="Clear" /></td>
						</tr>
					</table> -->
				</form>
			</div>
			</div>
		</div>
		</div>
</body>
</html>