package movievultures.model.dao;

import movievultures.model.EloRunoff;
import movievultures.model.Movie;
import java.util.List;

public interface MovieDao {
	
	Movie getMovie(int id);
	
	Movie getRandomMovie();
	
	List<Movie> getRandomMovies(int i);
	
	List<Movie> getMoviesByTitle(String title);
	List<Movie> getMoviesByTitle(String title, int limit);

	List<Movie> getMoviesByActor(String actor);
	List<Movie> getMoviesByActor(String actor, int limit);

	List<Movie> getMoviesByDirector(String director);
	List<Movie> getMoviesByDirector(String director, int limit);

	List<Movie> getMoviesByGenre(String genre);
	List<Movie> getMoviesByGenre(String genre, int limit);
	
	List<Movie> getMoviesByYear(int year, String comparator);
	
	List<Movie> getMoviesByUserRating(double userRating, String comparator);
	
	List<Movie> getMoviesByEloRating(double eloRating, String comparator);
	
	Movie saveMovie(Movie movie);

	void updateElos(Movie winner, Movie loser);
	
	void updateElos(EloRunoff runoff);
	
	void delMovie(Movie movie);

	Long getTotalRateTimes(int movieId);

	Double getAverageRating(int movieId);

	List<Object[]> fullTextSearch(String text);

	List<Object[]> fullTextSearchIndexed(String text);
	
}
