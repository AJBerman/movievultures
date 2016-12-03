<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
							<form:input path="username" type="text" class="form-control" 
								placeholder="Username" aria-describedby="basic-addon1" />
							<font color="red"><form:errors path="username" /></font>
						</div><br />
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">Email</span> 
							<form:input path="email" type="text" class="form-control" 
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
							<input class="btn btn-primary" type="submit" name="add" value="REGISTER" />
						</center>

					</form:form>
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>
	</div>
