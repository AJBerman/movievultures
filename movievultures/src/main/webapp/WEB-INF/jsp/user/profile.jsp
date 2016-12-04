<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

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
						
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-md-3"></div>


	</div>