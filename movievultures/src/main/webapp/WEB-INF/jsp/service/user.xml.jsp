<%@ page contentType="text/xml" trimDirectiveWhitespaces="true" %>
<?xml version="1.0" encoding="UTF-8" ?>
<user>
	<id>${user.userId}</id>
	<username>${user.username}</username>
	<password>${user.password}</password>
	<email>${user.email}</email>
	<reviews>${user.reviewedMovies}</reviews>
	<watchLater>${user.watchLater}</watchLater>
	<favorites>${user.favorites}</favorites>
	<roles>${user.roles}</roles>
	
</user>