<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

<title>Willkommen, Bienvenue, Welcome</title>

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
			<li><sec:authorize access="!isFullyAuthenticated()">
					<li><a href="../login.html">Login</a></li>
				</sec:authorize></li>
		</ul>
	</div>
	</nav>

	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="!isFullyAuthenticated()">
			<a href= "<c:url value='/login.html'/>"  >Login</a>
		</sec:authorize>
	</p>
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
							<form:input onfocusout="myFunction()" path="email" type="text" class="form-control" placeholder="someting@abc.com" aria-describedby="basic-addon1" /><font color="red"><form:errors path="email" /></font>
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Password</span> 
							<form:input path="password" type="text" class="form-control" placeholder="Password" aria-describedby="basic-addon1" /><font color="red"><form:errors path="password" /></font>
						</div><br />
			 			<center>
							<input class="btn btn-primary" type="submit" name="add" value="REGISTER" />
						</center>
						<div class="col-md-2">Username:</div>
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
							value="REGISTER" />
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
</body>
</html> --%>

<!-- New code -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<title>Willkommen, Bienvenue, Welcome</title>

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
			<li><sec:authorize access="!isFullyAuthenticated()">
					<li><a href="../login.html">Login</a></li>
				</sec:authorize></li>
		</ul>
	</div>
	</nav>

	<%-- <p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		
		<sec:authorize access="!isFullyAuthenticated()">
			<a href= "<c:url value='/login.html'/>"  >Login</a>
		</sec:authorize>
	</p> --%>

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
					<div class="alert alert-success alert-dismissable" id="registrationAvalaible" style="display: none">
						<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
						User name and email are available
					</div>

						<div class="alert alert-danger alert-dismissable" id="registrationNotAvalaible" style="display: none">
							<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
							User name and email already exists
						</div>

					<form:form modelAttribute="user">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">@</span>
							<form:input path="username" id="username"  type="text" class="form-control"
								placeholder="Username" aria-describedby="basic-addon1" />
							<font color="red"><form:errors path="username" /></font>
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Email</span>
							<form:input id="email" name="email" path="email" type="text" class="form-control" onfocusout="checkExistingRegisteration()"
								placeholder="email@abc.com" aria-describedby="basic-addon1" />
							<font color="red"><form:errors path="email" /></font>
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Password</span>
							<form:input path="password" type="password" class="form-control"
								placeholder="Password" aria-describedby="basic-addon1" />
							<font color="red"><form:errors path="password" /></font>
						</div><br />
						<center>
							<input class="btn btn-primary" type="submit" id ="register-btn" name="add" value="REGISTER" />
						</center>

					</form:form>
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
<script>

	function checkExistingRegisteration() {
		 email = document.getElementById('email').value;
		username = document.getElementById('username').value;
		document.getElementById("register-btn").disabled = false;
		$.ajax({
			url: "../user/register/existing/"+ username+"/"+email, //+ userId + "/" + status + "/" + authorize,
			method: "GET",
			success: function(data){
                $("#registrationNotAvalaible").show();
                setTimeout(function(){ $("#registrationNotAvalaible").hide(); }, 3000);
                document.getElementById("register-btn").disabled = true;

			},
			error: function(request, status, error){
				$("#registrationAvalaible").show();
				setTimeout(function(){ $("#registrationAvalaible").hide(); }, 3000);
				document.getElementById("register-btn").disabled = false;

			}

		});

	}
</script>
