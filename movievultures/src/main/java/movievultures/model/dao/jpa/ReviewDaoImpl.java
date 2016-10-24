package movievultures.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;
import movievultures.model.dao.ReviewDao;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	
    @PersistenceContext
    private EntityManager entityManager;

    @Override
	public Review getReview( int id ) {
		return entityManager.find( Review.class, id );
	}

    @Override
	public List<Review> getReviewsByUser( User user ) {
		return entityManager
				.createQuery( "from Review where user_userid=:userid", Review.class )
				.setParameter("userid",user.getUserId())
				.getResultList();
	}
    
    @Override
	public List<Review> getReviewsByMovie( Movie movie ) {
		return entityManager
				.createQuery( "from Review where movie_movieid=:movieid", Review.class )
				.setParameter("movieid",movie.getMovieId())
				.getResultList();
	}
    
    @Override
    @Transactional
	public Review saveReview( Review review ) {
        return entityManager.merge( review );
	}
}
