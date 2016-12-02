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
			<li><a href="/movievultures/home">Movie Vultures</a></li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li>
				<p>
				<form class="form-inline" name="searchForm" action="/movievultures/search/searchMovies4" onsubmit="return numCheck()" method="get">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div class="input-group">
						<div class="input-group-addon">Search</div>
						<input placeholder="Search for..." class="form-control" type="text" name="searchTerm" />
					</div>
					
					<select class="selectpicker" id="searchType" name="type">
				 		<option value="9">General Search</option>
				 		<option value="10">General Search (Indexable)</option>
						<option value="1">Title</option>
						<option value="2">Genre</option>
						<option value="3">Director</option>
						<option value="4">Artist (Actor/Actress)</option>
						<option value="5">Year of Release</option>
						<option value="6">User Rating</option>
						<option value="7">Elo Rating</option>
						<option value="8">Random Movies</option>
					</select> 
					<select class="selectpicker" data-live-search="true" id="comparator" name="comparator">
						<option value="3" selected="selected">=</option>
						<option value="4">!=</option>
						<option value="1">></option>
						<option value="2"><</option>
					</select> 
					<input class="btn btn-primary" name="search" type="submit" value="GO"/>
				</form>
				</p>
			</li>
		</ul>
		
		<ul class="nav navbar-nav navbar-right">
			<sec:authorize access="!isFullyAuthenticated()">
				<li><a href="<c:url value="/user/register" />" > Register</a></li>
				<li><a href="<c:url value="/login" />" >Login</a></li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<li>
				<a
					href="/movievultures/user/home/<sec:authentication property="principal.username" />">
						<sec:authentication property="principal.username" />
				</a></li>
				<li><a href="<c:url value="/logout" />" >Logout</a></li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="<c:url value="/user/list" />" >Management</a></li>
			</sec:authorize>
		</ul>
	</div>
</nav>

<script>
	$(function() {
		$("[data-id=\"comparator\"]").parent().hide();
		$("#searchType").bind("change", function() {
			if ($(this).val() > "4" && $(this).val() < "8") {
				$("[data-id=\"comparator\"]").parent().show();
			} else {
				$("[data-id=\"comparator\"]").parent().hide();
			}
		});
	});

// 	var searchDropDown = document.getElementById("searchType");
// 	var hidden = true;
// 	$(searchDropDown.options[searchDropDown.selectedIndex].value).bind("change", function() {
// 		if ($(this).val() > "4" && $(this).val() < "8") {
// 			document.getElementById("comparator").style.visibility = "visible";
// 		} else {
// 			document.getElementById("comparator").style.visibility = "hidden";
// 		}
// 	});

// 	$("#comparator").hide();
// 	$("#searchType").bind("change", function() {
// 		if ($(this).val() > "4" && $(this).val() < "8") {
// 			$("#comparator").show();
// 		} else {
// 			$("#comparator").hide();
// 		}
// 	});
</script>

<script>
	//http://stackoverflow.com/questions/18042133/check-if-input-is-number-or-letter-javascript
	//http://www.w3schools.com/js/js_validation.asp
	function numCheck() {
		var input = document.forms["searchForm"]["searchTerm"].value;
		var selection = document.forms["searchForm"]["type"].value;
		//console.log("INPUT: " + input);
		//console.log("TYPE: " + selection);
		if ( (selection == 5 || selection == 6 || selection == 7) && isNaN(input) ) {
			alert("The input is not a number");
			return false;
		}
	}
</script>