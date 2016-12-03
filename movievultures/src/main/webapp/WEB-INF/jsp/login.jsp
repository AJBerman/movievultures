<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

	<div class="container">
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
					<center>New User? <a href="<c:url value="user/register" />">Register Here</a></center><br /><br />
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