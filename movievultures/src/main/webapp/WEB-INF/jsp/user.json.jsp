<%@ page contentType="application/json" trimDirectiveWhitespaces="true" %>
{
	"id" : ${user.userId},
	"username" : "${user.username}",
	"password" : "${user.password}",
	"email" : "${user.email}",
	"reviews" : ${user.reviewedMovies},
	"recommendations" : ${user.recommendations},
	"watchLater" : ${user.watchLater},
	"favorites" : ${user.favorites},
	"roles" : ${user.roles}
}