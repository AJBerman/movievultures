<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!-- <title>Willkommen, Bienvenue, Welcome</title> -->


<%-- 	<nav class="navbar navbar-inverse">
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
			<li><sec:authorize access="!isFullyAuthenticated()">
					<li><a href="../login.html">Login</a></li>
				</sec:authorize></li>
		</ul>
	</div>
	</nav> --%>

	<div class="container">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h2 class="panel-title">
						<center>Please Fill Out the Form to Register</center>
					</h2>
				</div>
				<div class="panel-body">

					<form:form modelAttribute="user">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">@</span> 
							<form:input path="username" type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1" /><font color="red"><form:errors path="username" /></font>
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Email</span> 
							<form:input path="email" type="text" class="form-control" placeholder="someting@abc.com" aria-describedby="basic-addon1" /><font color="red"><form:errors path="email" /></font>
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Password</span> 
							<form:input path="password" type="password" class="form-control" placeholder="Password" aria-describedby="basic-addon1" /><font color="red"><form:errors path="password" /></font>
						</div><br />
						<center>
							<input class="btn btn-primary" type="submit" name="add" value="REGISTER" />
						</center>
						<%-- <div class="col-md-2">Username:</div>
						<div class="col-md-4">
							<form:input path="username" />
						</div>
						<font color="red"><form:errors path="username" /></font>
						<br />
						<br />
						<div class="col-md-2">E-mail:</div>
						<div class="col-md-4">
							<form:input path="email" />
						</div>
						<font color="red"><form:errors path="email" /> </font>
						<br />
						<br />
						<div class="col-md-2">Password:</div>
						<div class="col-md-4">
							<form:input path="password" />
						</div>
						<font color="red"><form:errors path="password" /> </font>
						<br />
						<br />
						<input class="btn btn-primary" type="submit" name="add"
							value="REGISTER" /> --%>
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
