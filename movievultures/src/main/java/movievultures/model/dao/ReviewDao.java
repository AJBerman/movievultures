package movievultures.model.dao;

import java.util.List;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;

public interface ReviewDao {
	Review getReview( int id );
	List<Review> getReviewsByUser( User user );
	List<Review> getReviewsByMovie( Movie movie );
	Review getReviewByUserAndMovie(Movie movie, User user);
	Review saveReview( Review review );
}
