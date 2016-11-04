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
		
	<script>
	var current_page_users = 1;
	var records_per_page = 10;

	function changePageBy(num) {
		if(current_page_users+num >= 1 && current_page_users+num <= numPagesUsers()) {
			current_page_users += num;
	        changePageUsers(current_page_users);
		}
	}

	function changePageUsers(page)
	{
	    // Validate page
	    if (page < 1) page = 1;
	    if (page > numPagesUsers()) page = numPagesUsers();

	    $(".user").filter(":not(." +current_page_users+")").hide();
		$(".userpage"+page).show();
	    $("#userpageno").html(page);
	    for(var i = 1; i <= 4; i++) {
	    	if(page-i >= 1) {
	    		$("#userpageno-"+i).show().html(page-i);
	    		
	    	} else {
	    		$("#userpageno-"+i).hide();
	    	}
	    	console.log($("#userpageno"+i));
	    	if(page+i <= numPagesUsers()) {
	    		$("#userpageno"+i).show().html(page+i);
	    	} else {
	    		$("#userpageno"+i).hide();
	    	}
	    }

	    if (page == 1) {
	        $("#user_btn_prev").hide();
	    } else {
	        $("#user_btn_prev").show();
	    }

	    if (page == numPagesUsers()) {
	        $("#user_btn_next").hide();
	    } else {
	        $("#user_btn_next").show();
	    }
	}

	function numPagesUsers()
	{


		var count = $('#usersT tr').length - 1;
		//console.log(Math.ceil($("#users > li").length / records_per_page));
	    return Math.ceil(count / records_per_page);
	}

	window.onload = function() {
		changePageUsers(1);
	};
	</script>
</head>
<body>
	<p align="right">
		<a href="<c:url value='/' />" >Main</a> |
		<a href="home.html?username=<security:authentication property="principal.username" />"> 
			<security:authentication property="principal.username" /></a> |
		<a href="<c:url value='/logout'/>" >Logout</a>
	</p>

	<jsp:include page="searchForm.jsp" /><br />
	
	<%-- Paging scripts for search results --%>
	<table border=1 id="usersT">
		<tr><th>User ID</th> <th>Username</th></tr>
		<c:forEach items="${users}" var="user" varStatus="varStatus">
			<tr class="user userpage${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')} 
				${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')}">
				<td>${user.userId}</td>
				<td>${user.username}</td>
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
	
</body>
</html>