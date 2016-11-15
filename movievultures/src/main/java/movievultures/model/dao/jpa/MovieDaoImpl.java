package movievultures.model.dao.jpa;

import java.util.ArrayList;
import java.math.BigInteger;
import java.util.Calendar;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityResult;
import javax.persistence.ColumnResult;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.SqlResultSetMapping;


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
				.createNativeQuery("select movie0_.* "
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
				.createNativeQuery("select movie0_.* "
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
				.createNativeQuery("select movie0_.* "
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
			.createNativeQuery("select movie0_.* "
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
				.createNativeQuery("select movie0_.* "
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
				.createNativeQuery("select movie0_.* "
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
    	/*create or replace function elowinner(winnerid integer, loserid integer)
    	returns void LANGUAGE plpgsql AS $$
    	DECLARE oldWinnerElo double precision;
    	DECLARE eloCount integer;
    	BEGIN
    		select elorating from movies where movieid=winnerid into oldWinnerElo;
    		select count(*) from elorunoffs where winner_movieid=winnerid or loser_movieid=winnerid into eloCount;
    	    if eloCount=0 then
    	    	update movies set elorating=400+(SELECT elorating from movies where movieid=loserid) where movieid=winnerid;
    	    else
    	    	update movies set elorating=((elorating*eloCount)+400+(SELECT elorating from movies where movieid=loserid))/(eloCount+1) where movieid=winnerid;
    	    end if;
    	    
    		select count(*) from elorunoffs where winner_movieid=loserid or loser_movieid=loserid into eloCount;
    	    
    	    if eloCount=0 then
    	    	update movies set elorating=oldWinnerElo-400 where movieid=loserid;
    	    else
    	    	update movies set elorating=((elorating*eloCount)-400+oldWinnerElo)/(eloCount+1) where movieid=loserid;
    	   	end if;
    	END;
    	$$;*/
    	entityManager.createNativeQuery("select 1 from elowinner(:winner,:loser);").setParameter("winner", winner.getMovieId()).setParameter("loser", loser.getMovieId()).getResultList();
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
				.createNativeQuery("select movie0_.* "
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


	@SuppressWarnings("unchecked")
	@Override
	public List<Movie> getMoviesByIDList(List<Integer> movieIds) {
		Query query = entityManager.createQuery("FROM Movie WHERE movieId IN :movieIds")
				.setParameter("movieIds", movieIds);
		List<Movie> movies = query.getResultList();
		return movies;
	}
	

    @Override
    //Yes, Seriously, List<Object[]>. The List is a list of results, and the Object[] is each result. For each result, there's a movie at res[0], a headline at res[1], and a rank at res[2] 
	public List<Object[]> fullTextSearch(String text) {
		return entityManager
			.createNativeQuery( "select m.*, "
					+ "ts_headline(m.plot || ' || ' || m.title || ' || ' || string_agg(distinct(d.director), ' | ') || ' || ' || string_agg(distinct(g.genre), ' | ') || ' || ' || string_agg(distinct(a.actor), ' | '), plainto_tsquery( :text )) as headline, "
					+ "ts_rank(to_tsvector('english', m.plot || ' || ' || m.title || ' || ' || string_agg(distinct(d.director), ' | ') || ' || ' || string_agg(distinct(g.genre), ' | ') || ' || ' || string_agg(distinct(a.actor), ' | ')), plainto_tsquery( :text )) AS rank "
					+ "from movies m join movie_directors d on d.movieid=m.movieid join movie_genres g on g.movieid=m.movieid join movie_cast a on a.movieid=m.movieid "
					+ "group by m.movieid "
					+ "having to_tsvector('english', m.plot || ' || ' || m.title || ' || ' || string_agg(distinct(d.director), ' | ') || ' || ' || string_agg(distinct(g.genre), ' | ') || ' || ' || string_agg(distinct(a.actor), ' | ')) @@ plainto_tsquery( :text ) "
					+ "order by rank desc;", "SearchResults" )
			.setParameter("text", text)
			.getResultList();
	}
	
    @Override
    //Yes, Seriously, List<Object[]>. The List is a list of results, and the Object[] is each result. For each result, there's a movie at res[0], a headline at res[1], and a rank at res[2] 
	//to create index:
    //create index fts_index on movies using gin(to_tsvector('english', plot || ' || ' || title));
    public List<Object[]> fullTextSearchIndexed(String text) {
		return entityManager
			.createNativeQuery( "select m.*, "
					+ "ts_headline(m.plot || ' || ' || m.title, plainto_tsquery( :text )) as headline, "
					+ "ts_rank(to_tsvector('english', m.plot || ' || ' || m.title), plainto_tsquery( :text )) AS rank "
					+ "from movies m "
					+ "having to_tsvector('english', m.plot || ' || ' || m.title) @@ plainto_tsquery( :text ) "
					+ "order by rank desc;", "SearchResults" )
			.setParameter("text", text)
			.getResultList();

	}
    
}
