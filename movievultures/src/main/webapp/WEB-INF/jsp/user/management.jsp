<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<title>User Management</title>
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
			<li><a
				href="home.html?username=<sec:authentication property="principal.username" />">
					<sec:authentication property="principal.username" />
			</a></li>
			<li><a href="<c:url value='/logout'/>">Logout</a></li>
		</ul>
	</div>
	</nav>

	<%-- <p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		<a href="home.html?username=<sec:authentication property="principal.username" />"> 
			<sec:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>" >Logout</a>
	</p> --%>
	<div class="container">
		<center>
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-header">
						<h2>Update User Privileges</h2>
					</div>
					<div class="panel-body">
						<table class="table table-hover table bordered table-striped">
							<tr>
								<td><b>Id Number: </b></td>
								<td>${user.userId}<br /></td>
							</tr>
							<tr>
								<td><b>Username: </b></td>
								<td>${user.username}</td>
							</tr>
							<tr>
								<td><b>Status: </b></td>
								<td><c:choose>
										<c:when test="${user.enabled}">
											<i><font color="green">enabled</font></i>
										</c:when>
										<c:when test="${!user.enabled}">
											<i><font color="red">disabled</font></i>
										</c:when>
									</c:choose></td>
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
				Authorize <input type="checkbox" name="authority" />
									<br />
									<br />
									<form:radiobutton path="enabled" value="1" />  Enable
				<form:radiobutton path="enabled" value="0" />  Disable
				<br />
									<br />
									<input class="btn btn-primary" type="submit" name="edit"
										value="Update" />
								</form:form>
							</c:when>
							<c:when test="${contains}">
								<i>This user is an administrative user. Can't edit
									privileges.</i>
							</c:when>
						</c:choose>
					</div>
				</div>



			</div>
		</center>
	</div>
</body>
</html>