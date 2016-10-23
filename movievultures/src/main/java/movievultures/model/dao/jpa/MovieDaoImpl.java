package movievultures.model.dao.jpa;

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
			.createQuery( "from Movie join movie_cast on movie_cast.movieid=movies.movieid where movie_cast.actor LIKE :actor group by movie.movieid", Movie.class )
			.setParameter("actor", "%" + actor + "%")
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByActor(String actor, int limit) {
		return entityManager
			.createQuery( "from Movie join movie_cast on movie_cast.movieid=movies.movieid where movie_cast.actor LIKE :actor group by movie.movieid", Movie.class )
			.setParameter("actor", "%" + actor + "%")
			.setMaxResults(limit)
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByDirector(String director) {
		return entityManager
			.createQuery( "from Movie join movie_directors on movie_directors.movieid=movies.movieid where moviedirectors.director LIKE :director GROUP BY movie.movieid", Movie.class )
			.setParameter("director", "%" + director + "%")
			.getResultList();
	}

    @Override
	public List<Movie> getMoviesByDirector(String director, int limit) {
		return entityManager
			.createQuery( "from Movie join movie_directors on movie_directors.movieid=movies.movieid where moviedirectors.director LIKE :director GROUP BY movie.movieid", Movie.class )
			.setParameter("director", "%" + director + "%")
			.setMaxResults(limit)
			.getResultList();
	}
    
    @Override
	public List<Movie> getMoviesByGenre(String genre) {
		return entityManager
			.createQuery( "from Movie join movie_genres on movie_genres.movieid=movies.movieid where movie_genres.genre LIKE :genre GROUP BY movie.movieid", Movie.class )
			.setParameter("genre", "%" + genre + "%")
			.getResultList();
	}
    
    @Override
	public List<Movie> getMoviesByGenre(String genre, int limit) {
		return entityManager
			.createQuery( "from Movie join movie_genres on movie_genres.movieid=movies.movieid where movie_genres.genre LIKE :genre GROUP BY movie.movieid", Movie.class )
			.setParameter("genre", "%" + genre + "%")
			.setMaxResults(limit)
			.getResultList();
	}

	@Override
	public List<Movie> getMoviesByArtist(String artist) {
		return null;
	}

	@Override
	public List<Movie> getMoviesByArtist(String artist, int limit) {
		return null;
	}

	@Override
	public List<Movie> getMoviesSmallerYear(int year) {
		return null;
	}

	@Override
	public List<Movie> getMoviesGreaterYear(int year) {
		return null;
	}

	@Override
	public List<Movie> getMovieEqualYear(int year) {
		return null;
	}

	@Override
	public List<Movie> getMoviesSmallerUserRating(int userRating) {
		return null;
	}

	@Override
	public List<Movie> getMoviesGreaterUserRating(int userRating) {
		return null;
	}

	@Override
	public List<Movie> getMovieEqualUserRating(int userRating) {
		return null;
	}

	@Override
	public List<Movie> getMoviesSmallerEloRating(int eloRating) {
		return null;
	}

	@Override
	public List<Movie> getMoviesGreaterEloRating(int eloRating) {
		return null;
	}

	@Override
	public List<Movie> getMovieEqualEloRating(int eloRating) {
		return null;
	}
}
