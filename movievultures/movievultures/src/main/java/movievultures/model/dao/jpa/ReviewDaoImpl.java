package movievultures.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;
import movievultures.model.dao.ReviewDao;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	
    @PersistenceContext
    private EntityManager entityManager;
    
	public Review getReview( Long id ) {
		return entityManager.find( Review.class, id );
	}
	public List<Review> getReviewsByUser( User user ) {
		return entityManager
			.createQuery( "from Reviews where user_userid=:userid", Review.class )
			.setParameter("userid",user.getUserId())
			.getResultList();
	}
	
	public List<Review> getReviewsByMovie( Movie movie ) {
		return entityManager
				.createQuery( "from Review where movie_movieid=:movieid", Review.class )
				.setParameter("movieid",movie.getMovieId())
				.getResultList();
	}
	public Review saveReview( Review review ) {
        return entityManager.merge( review );
	}
}
