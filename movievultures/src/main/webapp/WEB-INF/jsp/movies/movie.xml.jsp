<%@ page contentType="text/xml" trimDirectiveWhitespaces="true" %>
<?xml version="1.0" encoding="UTF-8" ?>
<movie>
	<id>${movie.movieId}</id>
	<title>${movie.title}</title>
	<plot>${movie.plot}</plot>
	<genres>${movie.genres }</genres>
	<actors>${movie.actors }</actors>
	<directors>${movie.directors }</directors>
	<reviews>${movie.reviews}</reviews>
	<eloRating>${movie.eloRating }</eloRating>
</movie>
