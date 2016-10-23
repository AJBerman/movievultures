package movievultures.model.dao;

import java.util.List;

import movievultures.model.EloRunoff;
import movievultures.model.Movie;
import movievultures.model.User;

public interface EloRunoffDao {
	
	EloRunoff getEloRunoff(int id);
	
	List<EloRunoff> getEloRunoffsByMovie(Movie movie);
	
	List<EloRunoff> getEloRunoffsForMoviePair(Movie movie1, Movie movie2);
	
	EloRunoff getEloRunoffByUserAndMovies(int userid, int movie1id, int movie2id);
	
	EloRunoff getEloRunoffByUserAndMovies(User user, Movie movie1, Movie movie2);
	
	List<EloRunoff> getEloRunoffsByUser(User user);
	
	EloRunoff saveEloRunoff(EloRunoff eloRunoff);

}
