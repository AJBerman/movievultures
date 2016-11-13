<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security"
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
<title>List of Users</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="<c:url value="/res/js/userPaging.js" />"></script>

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
				href="home.html?username=<security:authentication property="principal.username" />">
					<security:authentication property="principal.username" />
			</a></li>
			<li><a href="<c:url value='/logout'/>">Logout</a></li>
		</ul>
	</div>
	</nav>

	<%-- <p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		<a href="home.html?username=<security:authentication property="principal.username" />"> 
			<security:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>" >Logout</a>
	</p> --%>
	<div class="container">
		<h2>User Management</h2>
		<br />

		<jsp:include page="searchForm.jsp" /><br />

		<%-- Paging scripts for search results --%>
		<table class="table table-hover table bordered table-striped" id="usersT">
			<tr>
				<th>User ID</th>
				<th>Username</th>
				<th>Manage</th>
			</tr>
			<c:forEach items="${users}" var="user" varStatus="varStatus">
				<tr
					class="user userpage${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')} 
				${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')}">
					<td>${user.userId}</td>
					<td>${user.username}</td>
					<td>
						<%-- if user isn't authority, authorize --%> <c:set var="contains"
							value="false" /> <c:forEach var="role" items="${user.roles}">
							<c:if test="${role == 'ROLE_ADMIN'}">
								<c:set var="contains" value="true" />
							</c:if>
						</c:forEach> <c:choose>
							<c:when test="${!contains}">
								<a href="management.html?userid=${user.userId}">Manage</a>
							</c:when>
							<c:when test="${contains}">
						Admin
					</c:when>
						</c:choose>
					</td>
					<%-- 
		<td>${user.userId}</td>
		<td>${user.username}</td>
		<td><a href="view.html?userId=${user.userId}">view</a>
		<security:authorize access="hasRole('ROLE_ADMIN')">
			| <a href="authorize.html?userid=${user.userId}">Authorize</a>
		</security:authorize>
		</td>
		--%>
				</tr>
			</c:forEach>
		</table>
		<br /> <a href="javascript:changePageBy(-1000)" id="user_btn_first">
			<< </a> <a href="javascript:changePageBy(-1)" id="user_btn_prev">Prev</a>
		<a href="javascript:changePageBy(-4)" id="userpageno-4"
			style="display: none;"></a> <a href="javascript:changePageBy(-3)"
			id="userpageno-3" style="display: none;"></a> <a
			href="javascript:changePageBy(-2)" id="userpageno-2"
			style="display: none;"></a> <a href="javascript:changePageBy(-1)"
			id="userpageno-1" style="display: none;"></a> <a id="userpageno"></a>
		<a href="javascript:changePageBy(1)" id="userpageno1"
			style="display: none;"></a> <a href="javascript:changePageBy(2)"
			id="userpageno2" style="display: none;"></a> <a
			href="javascript:changePageBy(3)" id="userpageno3"
			style="display: none;"></a> <a href="javascript:changePageBy(4)"
			id="userpageno4" style="display: none;"></a> <a
			href="javascript:changePageBy(1)" id="user_btn_next">Next</a> <a
			href="javascript:changePageBy(-99)" id="user_btn_last"> >> </a>

	</div>
</body>
</html>