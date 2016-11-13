package movievultures.web.controller;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.dao.EmptyResultDataAccessException;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.ReviewDao;
import movievultures.model.dao.UserDao;
import movievultures.security.SecurityUtils;
import movievultures.web.validator.AddReviewValidator;

@Controller
@SessionAttributes("review")
public class ReviewController {
	@Autowired
	private MovieDao movieDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private UserDao userDao;
	
	@Autowired
	AddReviewValidator addReviewValidator;
	
	@RequestMapping(value = "/review/add.html", method = RequestMethod.GET)
    public String add(@RequestParam("id") int id, ModelMap models ) // e.g. /rate?id=5267
    {
        User user = userDao.getUserByUsername(SecurityUtils.getUserName());
		//User user = userDao.getUser(12); //just for testing
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
    public String add( @ModelAttribute("review") Review review, BindingResult result, SessionStatus status ) // e.g. /rate?id=5267
    {
		//Debugging statement
		//System.out.println("Review ID: " + review.getReviewId());
		addReviewValidator.validate(review, result);
		if(result.hasErrors())
			return "review/add";
		try {
			Review oldreview = reviewDao.getReviewByUserAndMovie(review.getMovie(), review.getUser());
			//if we're still here, that means there's already a review.
			//this code "shouldn't" ever run unless someone's doing stuff they shouldn't with the website.
			oldreview.setDate(review.getDate());
			oldreview.setReview(review.getReview());
			oldreview.setRating(review.getRating());
			review = reviewDao.saveReview(oldreview); //preserve the old reviewid, and prevent dupes.
		} catch (EmptyResultDataAccessException e) {
			review = reviewDao.saveReview(review);
		}
		status.setComplete();
        return "redirect:../movies/details2.html?id=" + review.getMovie().getMovieId();
    }

	@RequestMapping(value = "/review/edit.html", method = RequestMethod.GET)
	public String edit(@RequestParam("id") int id, ModelMap models ) 
	{
        User user = userDao.getUserByUsername(SecurityUtils.getUserName());
		//User user = userDao.getUser(12); //just for testing
        Review review = reviewDao.getReviewByUserAndMovie(movieDao.getMovie(id), user);
        models.put("review", review);
		return "review/edit";
	}
	
	@RequestMapping(value = "/review/edit.html", method = RequestMethod.POST)
	public String edit( @ModelAttribute Review review, SessionStatus status )
	{
		//Debugging statement
		//System.out.println("Review ID: " + review.getReviewId());
		try {
			Review oldreview = reviewDao.getReviewByUserAndMovie(review.getMovie(), review.getUser());
			//if we're still here, that means there's already a review.
			oldreview.setDate(review.getDate());
			oldreview.setReview(review.getReview());
			oldreview.setRating(review.getRating());
			review = reviewDao.saveReview(oldreview); //preserve the old reviewid, and prevent dupes.
		} catch (EmptyResultDataAccessException e) {
			//for some reason they're trying to edit a review that didn't exist in the first place. Let's save it anyway.
			review = reviewDao.saveReview(review);
			status.setComplete();
		}
        return "redirect:../movies/details2.html?id=" + review.getMovie().getMovieId();
	}

	@InitBinder
	public void dataBinding(WebDataBinder binder) {
		binder.registerCustomEditor(java.lang.Double.class, "rating", new CustomNumberEditor(java.lang.Double.class, false));
	}
}
