package movievultures.model.dao;

import java.util.List;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;

public interface ReviewDao {
	Review getReview( Long id );
	List<Review> getReviewsByUser( User user );
	List<Review> getReviewsByMovie( Movie movie );
	Review saveReview( Review review );
}
