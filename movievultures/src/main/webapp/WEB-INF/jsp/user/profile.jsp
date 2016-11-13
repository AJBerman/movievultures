<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<title>Profile</title>
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
			<security:authorize access="isAuthenticated()">
				<li><a href="<c:url value='/' /> ">Main</a></li>
				<li><a
					href="home.html?username=<sec:authentication property="principal.username" />">
						<sec:authentication property="principal.username" />
				</a></li>
				<li><a href="<c:url value='/logout' />">Logout</a></li>
			</security:authorize>
		</ul>
	</div>
	</nav>
	<%-- <p align="right">
		<sec:authorize access="isAuthenticated()">
			<a href="<c:url value='/' />" >Main</a> |
			<a href="home.html?username=<sec:authentication property="principal.username" />" >
				<sec:authentication property="principal.username" /></a> |
			<a href="<c:url value='/logout' />">Logout</a> 
		</sec:authorize>
	</p> --%>
	<div class="container">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2><center>User Profile</center></h2>
				</div>
				<div class="panel-body">
					<form:form modelAttribute="user">
					
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Username</span> 
							<input class="form-control" type="text" value="${user.username }" readonly />
							<form:input path="username" type="hidden" value="${user.username }" />
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Password</span> 
							<form:input path="password" class="form-control"/><font color="red"><form:errors path="password" /></font>
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Email</span> 
							<form:input path="email" class="form-control"/><font color="red"><form:errors path="email" /></font>
						</div><br />
						<center><input type="submit" class="btn btn-primary" name="update" value="Update" /></center>
						
						
						<%-- Username: ${user.username}<br />
						<form:input path="username" type="hidden"
							value="${user.username }" />
						<br />
						Password: <form:input path="password" />
						<font color="red"><form:errors path="password" /></font>
						<br />
						<br />
						E-mail: <form:input path="email" />
						<font color="red"><form:errors path="email" /></font>
						<br />
						<br />
						<input type="submit" name="update" value="Update" /> --%>
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>


	</div>
</body>
</html>