<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List of Users</title>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<c:url value="/res/js/userPaging.js" />"></script>

</head>
<body>
	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		<a href="home.html?username=<security:authentication property="principal.username" />"> 
			<security:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>" >Logout</a>
	</p>
	
	<h2>User Management</h2> <br />

	<jsp:include page="searchForm.jsp" /><br />
	
	<%-- Paging scripts for search results --%>
	<table border=1 id="usersT">
		<tr><th>User ID</th> <th>Username</th></tr>
		<c:forEach items="${users}" var="user" varStatus="varStatus">
			<tr class="user userpage${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')} 
				${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')}">
				<td>${user.userId}</td>
				<td>${user.username}</td>
				<td>
					<%-- if user isn't authority, authorize --%>
					<c:set var="contains" value="false" />
					<c:forEach var="role" items="${user.roles}">
  						<c:if test="${role == 'ROLE_ADMIN'}">
    						<c:set var="contains" value="true" />
  						</c:if>
					</c:forEach>
					<c:choose>
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
	</table> <br />
			<a href="javascript:changePageBy(-1000)" id="user_btn_first"> << </a> 
			<a href="javascript:changePageBy(-1)" id="user_btn_prev">Prev</a>
			<a href="javascript:changePageBy(-4)" id="userpageno-4" style="display: none;"></a>
			<a href="javascript:changePageBy(-3)" id="userpageno-3" style="display: none;"></a>
			<a href="javascript:changePageBy(-2)" id="userpageno-2" style="display: none;"></a>
			<a href="javascript:changePageBy(-1)" id="userpageno-1" style="display: none;"></a>
			<a id="userpageno"></a>
			<a href="javascript:changePageBy(1)" id="userpageno1" style="display: none;"></a>
			<a href="javascript:changePageBy(2)" id="userpageno2" style="display: none;"></a>
			<a href="javascript:changePageBy(3)" id="userpageno3" style="display: none;"></a>
			<a href="javascript:changePageBy(4)" id="userpageno4" style="display: none;"></a>
			<a href="javascript:changePageBy(1)" id="user_btn_next">Next</a> 
			<a href="javascript:changePageBy(-99)" id="user_btn_last"> >> </a>
	
</body>
</html>