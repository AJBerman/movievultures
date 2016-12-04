<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
				<tr data-user-id="${user.userId}" class="user userpage${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')} 
				${fn:replace(((varStatus.count/10)-((varStatus.count/10)%1)+1),'.0','')}">
					<td data-prop="id">${user.userId}</td>
					<td data-prop="username">${user.username}</td>
					<td>
						<%-- if user isn't authority, authorize --%> 
						<c:set var="contains" value="false" /> 
						<c:forEach var="role" items="${user.roles}">
							<c:if test="${role == 'ROLE_ADMIN'}">
								<c:set var="contains" value="true" />
							</c:if>
						</c:forEach> <c:choose>
							<c:when test="${!contains}">
								<a class="manage" href="javascript:void(0)">Manage</a>
							</c:when>
							<c:when test="${contains}">
								Admin
						</c:when>
						</c:choose>
					</td>
					<td data-prop="enabled" style="display:none;">${user.enabled}</td>
				</tr>
			</c:forEach>
		</table>
		<br /> 
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
	</div>
	
	<!-- Adding management div here for ajax operations -->
	<div id="management">	
		<table class="table table-hover table bordered table-striped" id="user_data">
			<tr>
				<td><b>Id Number: </b></td>
				<td data-field="id"></td>
			</tr>
			<tr>
				<td><b>Username: </b></td>
				<td data-field="username"></td>
			</tr>
			<tr>
				<td><b>Status: </b></td>
				<td data-field="status"></td>
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
			<form>
				Authorize <input type="checkbox" name="authority" />
				<br /><br />
				<input type="radio" name="status" value="enabled" />  Enable
				<input type="radio" name="status" value="disabled" />  Disable
				<br /><br />
			</form>
		</c:when>
		<c:when test="${contains}">
			<i>This user is an administrative user. Can't edit
				privileges.</i>
		</c:when>
	</c:choose>
</div>

<script>

function updatePrivileges(userId, status){
	$.ajax({
		url: "/service/user/" + userId,
		method: "PUT", 
		dataType: "json",
		
	});
}

$(function(){
	$("#management").dialog({
		autoOpen: false,
		title: "Update User Privileges",
		buttons: {
			"Update": function(){
				var userId = $("#management td[data-field='id']").html();
				//get values from forms and pass them into function
				//update function
				//print out values before moving on.
				//console.log(status);
				//console.log(userId);
				//updatePrivileges(userId, status);
				$(this).dialog("close");
			}
		}
	});
	
	$(".manage").click(function(){
		$("form")[0].reset();
		var userId = $(this).closest("tr").attr("data-user-id");
		var username = $(this).closest("tr").find("td[data-prop='username']").html();
		var status = $(this).closest("tr").find("td[data-prop='enabled']").html();
		console.log(status);
		$("#management td[data-field='id']").html(userId);
		$("#management td[data-field='username']").html(username);
	 	if(status === "true"){
			$("#management td[data-field='status']").html('<i><font color="green">enabled</font></i>');
			$("#management input[value='enabled']").prop("checked", true);
	 	}else{
			$("#management td[data-field='status']").html('<i><font color="red">disabled</font></i>');
			$("#management input[value='disabled']").prop("checked", true);
	 	}
		$("#management").dialog("open");
	});
	
});
</script>	
	