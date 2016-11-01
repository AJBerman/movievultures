package movievultures.model.dao.jpa;

import java.util.ArrayList;
import java.math.BigInteger;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.security.access.prepost.PreAuthorize;
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
			.createQuery( "from Movie where lower(title) LIKE lower(:title)", Movie.class )
			.setParameter("title", '%' + title + '%')
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByTitle(String title, int limit) {
		return entityManager
			.createQuery( "from Movie where lower(title) LIKE lower(:title)", Movie.class )
			.setParameter("title", '%' + title + '%')
			.setMaxResults(limit)
			.getResultList();
	}

    @SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByActor(String actor) {
		return entityManager
				.createNativeQuery("select "
						+ "movie0_.movieId as movieId, "
						+ "movie0_.date as date, "
						+ "movie0_.eloRating as eloRating, "
						+ "movie0_.is_hidden as is_hidden, "
						+ "movie0_.plot as plot, "
						+ "movie0_.title as title "
						+ "from movies movie0_ "
						+ "join movie_cast actors0_ "
						+ "on movie0_.movieId=actors0_.movieid "
						+ "where LOWER(actors0_.actor) LIKE LOWER( :actor ) "
						+ "group by movie0_.movieId", Movie.class)
				.setParameter("actor", "%" + actor + "%")
				.getResultList();
	}

    @SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByActor(String actor, int limit) {
		return entityManager
				.createNativeQuery("select "
						+ "movie0_.movieId as movieId, "
						+ "movie0_.date as date, "
						+ "movie0_.eloRating as eloRating, "
						+ "movie0_.is_hidden as is_hidden, "
						+ "movie0_.plot as plot, "
						+ "movie0_.title as title "
						+ "from movies movie0_ "
						+ "join movie_cast actors0_ "
						+ "on movie0_.movieId=actors0_.movieid "
						+ "where LOWER(actors0_.actor) LIKE LOWER( :actor ) "
						+ "group by movie0_.movieId", Movie.class)
				.setParameter("actor", "%" + actor + "%")
				.setMaxResults(limit)
				.getResultList();
	}

    @SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByDirector(String director) {
		return entityManager
				.createNativeQuery("select "
						+ "movie0_.movieId as movieId, "
						+ "movie0_.date as date, "
						+ "movie0_.eloRating as eloRating, "
						+ "movie0_.is_hidden as is_hidden, "
						+ "movie0_.plot as plot, "
						+ "movie0_.title as title "
						+ "from movies movie0_ "
						+ "join movie_directors directors0_ "
						+ "on movie0_.movieId=directors0_.movieid "
						+ "where LOWER(directors0_.director) LIKE LOWER( :director ) "
						+ "group by movie0_.movieId", Movie.class)
				.setParameter("director", "%" + director + "%")
				.getResultList();
	}

    @SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByDirector(String director, int limit) {
		return entityManager
			.createNativeQuery("select "
					+ "movie0_.movieId as movieId, "
					+ "movie0_.date as date, "
					+ "movie0_.eloRating as eloRating, "
					+ "movie0_.is_hidden as is_hidden, "
					+ "movie0_.plot as plot, "
					+ "movie0_.title as title "
					+ "from movies movie0_ "
					+ "join movie_directors directors0_ "
					+ "on movie0_.movieId=directors0_.movieid "
					+ "where LOWER(directors0_.director) LIKE LOWER( :director ) "
					+ "group by movie0_.movieId", Movie.class)
			.setParameter("director", "%" + director + "%")
			.setMaxResults(limit)
			.getResultList();
	}
    
    @SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByGenre(String genre) {
		return entityManager
				.createNativeQuery("select "
						+ "movie0_.movieId as movieId, "
						+ "movie0_.date as date, "
						+ "movie0_.eloRating as eloRating, "
						+ "movie0_.is_hidden as is_hidden, "
						+ "movie0_.plot as plot, "
						+ "movie0_.title as title "
						+ "from movies movie0_ "
						+ "join movie_genres genres0_ "
						+ "on movie0_.movieId=genres0_.movieid "
						+ "where LOWER(genres0_.genre) LIKE LOWER( :genre ) "
						+ "group by movie0_.movieId", Movie.class)
				.setParameter("genre", "%" + genre + "%")
				.getResultList();
	}
    
    @SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByGenre(String genre, int limit) {
		return entityManager
				.createNativeQuery("select "
						+ "movie0_.movieId as movieId, "
						+ "movie0_.date as date, "
						+ "movie0_.eloRating as eloRating, "
						+ "movie0_.is_hidden as is_hidden, "
						+ "movie0_.plot as plot, "
						+ "movie0_.title as title "
						+ "from movies movie0_ "
						+ "join movie_genres genres0_ "
						+ "on movie0_.movieId=genres0_.movieid "
						+ "where LOWER(genres0_.genre) LIKE LOWER( :genre ) "
						+ "group by movie0_.movieId", Movie.class)
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
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void delMovie(Movie movie)
	{
		movie.setHidden(true); //we hide instead of delete so as not to violate db constraints
		this.saveMovie(movie);
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
    	else winner.setEloRating((loser.getEloRating()+400)/1);
    	if(loserCount > 0) loser.setEloRating(((loser.getEloRating()*loserCount)+winnerEloRating-400)/(loserCount+1));
    	else loser.setEloRating((winnerEloRating-400)/1);
    	this.saveMovie(winner);
    	this.saveMovie(loser);
	}
    
    @Override
    @Transactional
	public void updateElos(EloRunoff runoff) {
    	this.updateElos(runoff.getWinner(), runoff.getLoser());
    }
    
    @Override
	public List<Movie> getMoviesByYear(int year, String comparator) {
		return entityManager
				.createQuery( "from Movie where year(date) " + comparator + " :year", Movie.class )
				.setParameter("year", year)
				.getResultList();
    }


    @SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByUserRating(double userRating, String comparator) {
		return entityManager
				.createNativeQuery("select "
						+ "movie0_.movieId as movieId, "
						+ "movie0_.date as date, "
						+ "movie0_.eloRating as eloRating, "
						+ "movie0_.is_hidden as is_hidden, "
						+ "movie0_.plot as plot, "
						+ "movie0_.title as title "
						+ "from movies movie0_ "
						+ "inner join reviews review0_ "
						+ "on review0_.movie_movieId=movie0_.movieId "
						+ "group by movie0_.movieId "
						+ "having avg(review0_.rating) " + comparator + " :rating", Movie.class)
				.setParameter("rating", userRating)
				.getResultList();
    }

    @Override
	public List<Movie> getMoviesByEloRating(double eloRating, String comparator) {
		return entityManager
				.createQuery( "from Movie where eloRating " + comparator + " :eloRating", Movie.class )
				.setParameter("eloRating", eloRating)
				.getResultList();
    }
    
	@Override
	public Long getTotalRateTimes(int movieId) {
		BigInteger totalRates = (BigInteger)entityManager
			.createNativeQuery("select count(*) from reviews where movie_movieid=:movieid")
			.setParameter("movieid", movieId).getSingleResult();
		return totalRates.longValue();
	}
	
	@Override
	public Double getAverageRating(int movieId) {
		double totalRates = (Double)entityManager
			.createNativeQuery("select AVG(rating) from reviews where movie_movieid=:movieid")
			.setParameter("movieid", movieId).getSingleResult();
		return totalRates;
	}
    
}
