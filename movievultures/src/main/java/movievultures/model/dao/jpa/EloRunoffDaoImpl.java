package movievultures.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import movievultures.model.EloRunoff;
import movievultures.model.Movie;
import movievultures.model.User;
import movievultures.model.dao.EloRunoffDao;

@Repository
public class EloRunoffDaoImpl implements EloRunoffDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public EloRunoff getEloRunoff(int id) {
        return entityManager.find( EloRunoff.class, id );
	}

    @Override
	public List<EloRunoff> getEloRunoffsByMovie(Movie movie) {
		return entityManager
			.createQuery( "from EloRunoff where winner_movieid=:movieid OR loser_movieid=:movieid", EloRunoff.class )
			.setParameter("movieid", movie.getMovieId())
			.getResultList();
	}

    @Override
    public List<EloRunoff> getEloRunoffsForMoviePair(Movie movie1, Movie movie2) {
		return entityManager
				.createQuery( "from EloRunoff where winner_movieid=:movie1id AND loser_movieid=:movie2id OR winner_movieid=:movie2id AND loser_movieid=:movie1id", EloRunoff.class )
				.setParameter("movie1id", movie1.getMovieId())
				.setParameter("movie2id", movie2.getMovieId())
				.getResultList();
	}

    @Override
    public List<EloRunoff> getEloRunoffsByUser(User user) {
		return entityManager
				.createQuery( "from EloRunoff where user_userid=:userid", EloRunoff.class )
				.setParameter("userid", user.getUserId())
				.getResultList();
	}

    @Override
    @Transactional
	public EloRunoff saveEloRunoff(EloRunoff eloRunoff) {
        return entityManager.merge( eloRunoff );
	}
}
