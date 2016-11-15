package movievultures.recommender;

import java.util.List;

import org.apache.mahout.cf.taste.common.TasteException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import movievultures.model.Movie;
import movievultures.model.User;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.UserDao;

@Service
public class UserService implements ApplicationListener<AuthenticationSuccessEvent> {

	@Autowired
	UserDao userDao;

	@Autowired
	MovieDao movieDao;

	@Autowired
	RecommenderUtils recommender;

	@Override
	public void onApplicationEvent(AuthenticationSuccessEvent event) {

		String userName = ((UserDetails) event.getAuthentication().getPrincipal()).getUsername();
		// upon login success, get user recommendation
		User user = userDao.getUserByUsername(userName);

			System.out.println("In UserService: " + user.getUsername() + " " + user.getUserId());
			List<Integer> movieIds = null;
			try {
				movieIds = recommender.getRecommendation(user.getUserId());
				// System.out.println("Recommendations in movieIds: " +
				// movieIds.size());
			} catch (TasteException e) {
				System.out.println("There was some error here");
				e.printStackTrace();
			}
			// Get movies
			if(movieIds.isEmpty())
				return;
			List<Movie> movies = movieDao.getMoviesByIDList(movieIds);
			if(!movies.equals(user.getRecommendations())) {
				user.setRecommendations(movies);
				userDao.saveUser(user);
			}
		
	}

}
