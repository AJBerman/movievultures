package movievultures.web.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.ReviewDao;
import movievultures.model.dao.UserDao;
import movievultures.security.SecurityUtils;

@Controller
@SessionAttributes("user")
public class ReviewController {
	@Autowired
	private MovieDao movieDao;
	@Autowired
	private UserDao userDao; //just for testing, until security is implemented
	
	@RequestMapping(value = "/review/add.html", method = RequestMethod.GET)
    public String add(@RequestParam("id") int id, ModelMap models ) // e.g. /rate?id=5267
    {
        //User user = SecurityUtils.getUser();
		User user = userDao.getUser(12); //just for testing
        Review review = new Review();
        review.setUser(user);
        review.setDate(new Date());
        Movie movie = movieDao.getMovie(id);
        review.setMovie(movie);
        models.put("movie", movie);
        models.put("review", review);
        return "review/add";
    }
	
	@RequestMapping(value = "/review/add.html", method = RequestMethod.POST)
    public String rate( @ModelAttribute Movie movie ) // e.g. /rate?id=5267
    {
        return "redirect:movie.html?id=${movie.id}";
    }
}
