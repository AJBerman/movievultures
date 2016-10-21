package movievultures.web.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.beans.propertyeditors.CustomNumberEditor;

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
	@Autowired
	private ReviewDao reviewDao;
	
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
    public String add( @ModelAttribute Review review ) // e.g. /rate?id=5267
    {
		reviewDao.saveReview(review);
        return "redirect:movie.html?id=${movie.id}";
    }

	@RequestMapping(value = "/review/edit.html", method = RequestMethod.GET)
	public String edit(@RequestParam("id") int id, ModelMap models ) 
	{
        //User user = SecurityUtils.getUser();
		User user = userDao.getUser(12); //just for testing
        Review review = reviewDao.getReview(id);
        //for testing
        models.put("movie", review.getMovie());
        models.put("review", review);
		return "review/edit";
		/*if(user.equals(review.getUser())) 
		{
	        models.put("movie", review.getMovie());
	        models.put("review", review);
			return "review/edit";
		}
		else 
		{
			return "redirect:movie.html?id=${movie.id}";
		}*/
	}
	@RequestMapping(value = "/review/edit.html", method = RequestMethod.POST)
	public String edit(@ModelAttribute Review review ) 
	{
		reviewDao.saveReview(review);
        return "redirect:movie.html?id=${review.movie.id}";
	}

	@InitBinder
	public void dataBinding(WebDataBinder binder) {
		binder.registerCustomEditor(java.lang.Double.class, "rating", new CustomNumberEditor(java.lang.Double.class, false));
	}
}
