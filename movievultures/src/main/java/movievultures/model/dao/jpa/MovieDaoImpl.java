package movievultures.model.dao.jpa;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import movievultures.model.EloRunoff;
import movievultures.model.Movie;
import movievultures.model.dao.MovieDao;

@Repository
public class MovieDaoImpl implements MovieDao{

    @PersistenceContext
    private EntityManager entityManager;
    
    @Override
	public Movie getMovie(int id) {
        return entityManager.find( Movie.class, id );
	}

    @Override
	public Movie getRandomMovie() {
		return entityManager
				.createQuery( "from Movie order by random()", Movie.class )
				.setMaxResults(1)
				.getSingleResult();
	}

    @Override
	public List<Movie> getRandomMovies( int i ) {
		return entityManager
			.createQuery( "from Movie order by random()", Movie.class )
			.setMaxResults(i)
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByTitle(String title) {
		return entityManager
			.createQuery( "from Movie where title LIKE :title", Movie.class )
			.setParameter("title", '%' + title + '%')
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByTitle(String title, int limit) {
		return entityManager
			.createQuery( "from Movie where title LIKE :title", Movie.class )
			.setParameter("title", '%' + title + '%')
			.setMaxResults(limit)
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByActor(String actor) {
		return entityManager
			.createQuery( "from Movie join movie_cast on movie_cast.movieid=Movie.movieid where movie_cast.actor LIKE :actor group by Movie.movieid", Movie.class )
			.setParameter("actor", "%" + actor + "%")
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByActor(String actor, int limit) {
		return entityManager
			.createQuery( "from Movie join movie_cast on movie_cast.movieid=Movie.movieid where movie_cast.actor LIKE :actor group by Movie.movieid", Movie.class )
			.setParameter("actor", "%" + actor + "%")
			.setMaxResults(limit)
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByDirector(String director) {
		return entityManager
			.createQuery( "from Movie join movie_directors on movie_directors.movieid=Movie.movieid where moviedirectors.director LIKE :director GROUP BY Movie.movieid", Movie.class )
			.setParameter("director", "%" + director + "%")
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByDirector(String director, int limit) {
		return entityManager
			.createQuery( "from Movie join movie_directors on movie_directors.movieid=Movie.movieid where moviedirectors.director LIKE :director GROUP BY Movie.movieid", Movie.class )
			.setParameter("director", "%" + director + "%")
			.setMaxResults(limit)
			.getResultList();
	}
    
    @Override
	public List<Movie> getMoviesByGenre(String genre) {
		return entityManager
			.createQuery( "from Movie join movie_genres on movie_genres.movieid=Movie.movieid where movie_genres.genre LIKE :genre GROUP BY Movie.movieid", Movie.class )
			.setParameter("genre", "%" + genre + "%")
			.getResultList();
	}
    
    @Override
	public List<Movie> getMoviesByGenre(String genre, int limit) {
		return entityManager
			.createQuery( "from Movie join movie_genres on movie_genres.movieid=Movie.movieid where movie_genres.genre LIKE :genre GROUP BY Movie.movieid", Movie.class )
			.setParameter("genre", "%" + genre + "%")
			.setMaxResults(limit)
			.getResultList();
	}

    @Override
    @Transactional
	public Movie saveMovie(Movie movie) {
        return entityManager.merge( movie );
	}

    @Override
    @Transactional
	public void updateElos(Movie winner, Movie loser) {
    	//make sure we've got the most up-to-date info we can get. Those Movies could have lingered in the ModelMap for hours. Don't want to update based on an old Elo, and DEFINITELY don't want to overwrite changes to the plot or something
    	winner = this.getMovie(winner.getMovieId());
    	loser = this.getMovie(loser.getMovieId());
    	Long winnerCount = (Long) entityManager.createQuery("SELECT COUNT(*) FROM EloRunoff WHERE winner_movieid=:movieid OR loser_movieid=:movieid").setParameter("movieid", winner.getMovieId()).getSingleResult();
    	Long loserCount = (Long) entityManager.createQuery("SELECT COUNT(*) FROM EloRunoff WHERE winner_movieid=:movieid OR loser_movieid=:movieid").setParameter("movieid", loser.getMovieId()).getSingleResult();
    	double winnerEloRating = winner.getEloRating(); //saving this for updating loser after updating winner
    	if(winnerCount > 0) winner.setEloRating(((winnerEloRating*winnerCount)+loser.getEloRating()+400)/(winnerCount+1));
    	else winner.setEloRating(((winnerEloRating)+loser.getEloRating()+400)/1);
    	if(loserCount > 0) loser.setEloRating(((loser.getEloRating()*loserCount)+winnerEloRating-400)/(loserCount+1));
    	else loser.setEloRating(((loser.getEloRating())+winnerEloRating-400)/1);
    	this.saveMovie(winner);
    	this.saveMovie(loser);
	}
    
    @Override
	public void updateElos(EloRunoff runoff) {
    	this.updateElos(runoff.getWinner(), runoff.getLoser());
	}
}
