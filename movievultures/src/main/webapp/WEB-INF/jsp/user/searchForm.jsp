<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

	<form class="form-inline" action="<c:url value="/user/searchResults" />" method="POST">
		<div class="input-group">
			<div class="input-group-addon"><i>Search users by Username:</i></div>
		<input class="form-control" type="text" name="nameQuery" >
		</div>
		
		<input class="btn btn-primary" name="search" type="submit" value="Search"/>
	</form>
