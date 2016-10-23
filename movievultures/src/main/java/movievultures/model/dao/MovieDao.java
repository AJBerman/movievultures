package movievultures.model.dao;

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
	
	List<Movie> getMoviesByArtist(String artist);
	List<Movie> getMoviesByArtist(String artist, int limit);
	
	List<Movie> getMoviesSmallerYear(int year);
	List<Movie> getMoviesGreaterYear(int year);
	List<Movie> getMovieEqualYear(int year);
	
	List<Movie> getMoviesSmallerUserRating(int userRating);
	List<Movie> getMoviesGreaterUserRating(int userRating);
	List<Movie> getMovieEqualUserRating(int userRating);
	
	List<Movie> getMoviesSmallerEloRating(int eloRating);
	List<Movie> getMoviesGreaterEloRating(int eloRating);
	List<Movie> getMovieEqualEloRating(int eloRating);
	
	Movie saveMovie(Movie movie);
	
}
