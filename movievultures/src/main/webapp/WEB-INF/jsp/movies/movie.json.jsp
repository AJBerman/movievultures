<%@ page contentType="application/json" trimDirectiveWhitespaces="true" %>
{
	"id": ${movie.movieId},
	"title": "${movie.title}",
	"plot": "${movie.plot}",
	"genres": "${movie.genres}",
	"actors": "${movie.actors}",
	"directors": "${movie.directors}",
	"eloRating": ${movie.eloRating},
	"reviews": "${movie.reviews}"
}