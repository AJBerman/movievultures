package movievultures.model.dao.jpa;

import java.math.BigInteger;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
		return this.getRandomMovies(1).get(0);
	}

    @Override
	public List<Movie> getRandomMovies( int i ) {
		return entityManager
			.createQuery( "from Movie order by random()", Movie.class )
			.setMaxResults(i)
			.getResultList();
	}
    
    @Override
    @Transactional
	public Movie saveMovie(Movie movie) {
        return entityManager.merge( movie );
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
			.createQuery( "from Movie mv where :actor in elements(mv.actors)", Movie.class )
			.setParameter("actor", actor)
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByActor(String actor, int limit) {
		return entityManager
			.createQuery( "from Movie mv where :actor in elements(mv.actors)", Movie.class )
			.setParameter("actor", actor)
			.setMaxResults(limit)
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByDirector(String director) {
		return entityManager
			.createQuery( "from Movie mv where :director in elements(mv.directors)", Movie.class )
			.setParameter("director", director)
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByDirector(String director, int limit) {
		return entityManager
			.createQuery( "from Movie mv where :director in elements(mv.directors)", Movie.class )
			.setParameter("director", director)
			.setMaxResults(limit)
			.getResultList();
	}
    
    @Override
	public List<Movie> getMoviesByGenre(String genre) {
		return entityManager
			.createQuery( "from Movie mv where :genre in elements(mv.genres)", Movie.class )
			.setParameter("genre", genre)
			.getResultList();
	}
    
    @Override
	public List<Movie> getMoviesByGenre(String genre, int limit) {
		return entityManager
			.createQuery( "from Movie mv where :genre in elements(mv.genres)", Movie.class )
			.setParameter("genre", genre)
			.setMaxResults(limit)
			.getResultList();
	}

	@Override
	public List<Movie> getMoviesSmallerYear(int year) {
		return entityManager
			.createQuery( "from Movie where year(date) < :year", Movie.class )
			.setParameter("year", year)
			.getResultList();
	}

	@Override
	public List<Movie> getMoviesGreaterYear(int year) {
		return entityManager
			.createQuery( "from Movie where year(date) > :year", Movie.class )
			.setParameter("year", year)
			.getResultList();
	}

	@Override
	public List<Movie> getMovieEqualYear(int year) {
		return entityManager
			.createQuery( "from Movie where year(date) = :year", Movie.class )
			.setParameter("year", year)
			.getResultList();
	}

	@Override
	public List<Movie> getMoviesSmallerUserRating(double userRating) {
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesGreaterUserRating(double userRating) {
		return entityManager
			.createQuery("select m from Movie m join fetch m.reviews r group by m.movieId having avg(r.rating) > :rating order by avg(r.rating) desc", Movie.class )
			.setParameter("rating", userRating)
			.getResultList();
	}

	@Override
	public List<Movie> getMovieEqualUserRating(double userRating) {
		return null;
	}
	
	@Override
	public Long getTotalRateTimes(int movieId) {
		BigInteger totalRates = (BigInteger)entityManager
			.createNativeQuery("select count(*) from reviews where movie_movieid=:movieid")
			.setParameter("movieid", movieId).getSingleResult();
		return totalRates.longValue();
	}

	@Override
	public List<Movie> getMoviesSmallerEloRating(double eloRating) {
		return entityManager
			.createQuery( "from Movie where eloRating < :eloRating", Movie.class )
			.setParameter("eloRating", eloRating)
			.getResultList();
	}

	@Override
	public List<Movie> getMoviesGreaterEloRating(double eloRating) {
		return entityManager
			.createQuery( "from Movie where eloRating > :eloRating", Movie.class )
			.setParameter("eloRating", eloRating)
			.getResultList();
	}

	@Override
	public List<Movie> getMovieEqualEloRating(double eloRating) {
		return entityManager
			.createQuery( "from Movie where eloRating = :eloRating", Movie.class )
			.setParameter("eloRating", eloRating)
			.getResultList();
	}
}
