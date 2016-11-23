<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ===== REGISTRATION AUTHENTICATION ===== --%>
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
			<sec:authorize access="!isFullyAuthenticated()">
				<li><a href="<c:url value="/user/register.html" />" > Register</a></li>
				<li><a href="<c:url value="/login.html" />" >Login</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li>
				<a
					href="/movievultures/user/home.html?username=<sec:authentication property="principal.username" />">
						<sec:authentication property="principal.username" />
				</a></li>
				<li><a href="<c:url value="/logout" />" >Logout</a></li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="<c:url value="/user/list.html" />" >Management</a></li>
			</sec:authorize>
		</ul>
	</div>
</nav>