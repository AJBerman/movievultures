package movievultures.model.dao;

import movievultures.model.Movie;
import java.util.List;

public interface MovieDao {
	
	Movie getMovie(int id);
	
	Movie getRandomMovie();
	
	List<Movie> getRandomMovies(int i);
	
	List<Movie> getMoviesByTitle(String title);

	List<Movie> getMoviesByActor(String actor);

	List<Movie> getMoviesByDirector(String director);
	
	List<Movie> getMoviesByGenre(String genre);
	
	Movie saveMovie(Movie movie);
	
}
