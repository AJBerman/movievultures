package movievultures.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;

@Repository
public class ReviewDaoImpl {
	
    @PersistenceContext
    private EntityManager entityManager;
    
	Review getReview( Long id ) {
		return entityManager.find( Review.class, id );
	}
	List<Review> getReviewsByUser( User user ) {
		return entityManager
			.createQuery( "from Reviews where user_userid=:userid", Review.class )
			.setParameter("userid",user.getUserId())
			.getResultList();
	}
	List<Review> getReviewsByMovie( Movie movie ) {
		return entityManager
				.createQuery( "from Reviews where movie_movieid=:movieid", Review.class )
				.setParameter("movieid",movie.getMovieId())
				.getResultList();
	}
	Review saveReview( Review review ) {
        return entityManager.merge( review );
	}
}
