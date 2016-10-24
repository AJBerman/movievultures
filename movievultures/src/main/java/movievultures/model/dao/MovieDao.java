package movievultures.model.dao;

import movievultures.model.Movie;
import java.util.List;

public interface MovieDao {
	
	Movie getMovie(Long id);
	
	Movie getRandomMovie();
	
	List<Movie> getRandomMovies(int i);
	
	List<Movie> getMoviesByTitle(String title);

	List<Movie> getMoviesByActor(String actor);
	
	List<Movie> getMoviesByDirector(String director);
	
	Movie saveMovie(Movie movie);
	
}
