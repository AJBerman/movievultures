package movievultures.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import movievultures.model.Movie;

@Repository
public class MovieDaoImpl {

    @PersistenceContext
    private EntityManager entityManager;
    
	public Movie getMovie(Long id) {
        return entityManager.find( Movie.class, id );
	}

	Movie getRandomMovie() {
		return entityManager
			.createQuery( "from movies order by random() limit 1", Movie.class )
			.getResultList()
			.get(0);
	}
	
	List<Movie> getRandomMovies( int i ) {
		return entityManager
			.createQuery( "from movies order by random() limit :i", Movie.class )
			.setParameter("i", i)
			.getResultList();
	}
	
	List<Movie> getMoviesByTitle(String title) {
		return entityManager
			.createQuery( "from movies where title LIKE '%:title%'", Movie.class )
			.setParameter("title", title)
			.getResultList();
	}

	List<Movie> getMoviesByActor(String actor) {
		return entityManager
			.createQuery( "from movies join movie_cast on movie_cast.movieid=movies.movieid where movie_cast.actor LIKE '%:actor%' group by movie.movieid", Movie.class )
			.setParameter("actor", actor)
			.getResultList();
	}
	
	List<Movie> getMoviesByDirector(String director) {
		return entityManager
			.createQuery( "from movies join movie_directors on movie_directors.movieid=movies.movieid where moviedirectors.director LIKE '%:director%' GROUP BY movie.movieid", Movie.class )
			.setParameter("director", director)
			.getResultList();
	}
	
	public Movie saveMovie(Movie movie) {
        return entityManager.merge( movie );
	}
}
