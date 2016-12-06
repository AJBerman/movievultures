package movievultures.web.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.util.NestedServletException;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;
import movievultures.model.dao.EloRunoffDao;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.ReviewDao;
import movievultures.model.dao.UserDao;
import movievultures.security.SecurityUtils;
import movievultures.web.validator.AddMovieValidator;

@Controller
@SessionAttributes("movie")
public class MovieController {

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private ReviewDao reviewDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private EloRunoffDao eloRunoffDao;
	
	@Autowired
	private AddMovieValidator movieValidator;
	
//	@RequestMapping(value = "/home.html", method = RequestMethod.GET)
//	public String getHome() {
//		return "home";
//	}

	@RequestMapping("/movies/movies")
	public String getMovies(ModelMap models) {

		List<Movie> movies = movieDao.getRandomMovies(10);
		System.out.println(movies.size());
		for (int i = 0; i < movies.size(); i++) {
			// to remove {" and "} at the beginning an d end of the plot
			if (movies.get(i).getPlot().contains("{")) {
				movies.get(i).setPlot(movies.get(i).getPlot().substring(2, movies.get(i).getPlot().length() - 2));
			}
			// to remove "," from the plot - Figure this one later
			movies.get(i).setPlot(movies.get(i).getPlot().replace(" [\",\"] ", ""));
		}
		models.put("movies", movies);
		return "movies/movies";
	}

	@RequestMapping(value = "movies/add", method = RequestMethod.GET)
	public String getAddMovies(ModelMap models) {
		models.put("movie", new Movie());
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		return "movies/add";
	}

	@RequestMapping(value = "movies/add", method = RequestMethod.POST)
	public String postAddMovies(
			@ModelAttribute Movie movie, BindingResult result, SessionStatus status,
			@RequestParam(required=false) List<String> addmovie_genres,
			@RequestParam(required=false) List<String> addmovie_actors, 
			@RequestParam(required=false) List<String> addmovie_directors 
			)throws ParseException {
		movieValidator.validate(movie, result);
		if(result.hasErrors())
			return "movies/add";
		
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		movie.setEloRating(1200.0); //1200 is the default Elo Rating
		movie.setHidden(false);
		if(addmovie_genres != null) {
			Collections.sort(addmovie_genres);
			movie.setGenres(addmovie_genres);
		}
		if(addmovie_actors != null) {
			Collections.sort(addmovie_actors);
			movie.setActors(addmovie_actors);
		}
		if(addmovie_directors != null) {
			Collections.sort(addmovie_directors);
			movie.setDirectors(addmovie_directors);
		}
		movie=movieDao.saveMovie(movie);
		status.setComplete();
		// movie saved to db
		return "redirect:details2?id="+movie.getMovieId();
	}

	@RequestMapping(value = "/movies/details2")
	public String getDetails(@RequestParam int id, ModelMap models) {
		// System.out.println("in here");
		
		Movie movie = movieDao.getMovie(id);
		models.put("movie", movie);
		if(SecurityUtils.isAuthenticated()) {
			User user = userDao.getUserByUsername(SecurityUtils.getUserName());
			models.put("user", user);
			try {
				models.put("userreview", reviewDao.getReviewByUserAndMovie(movie, user));
			} catch (EmptyResultDataAccessException e) {
				models.put("userreview", null);
			}
		}
		else {
			models.put("user", null);
			models.put("userreview", null);
		}
		models.put("eloratings", eloRunoffDao.getEloRunoffsByMovie(movie));
		return "movies/details2";
	}

	@RequestMapping(value = "/movies/delete")
	public String getDelete(@RequestParam int id, ModelMap models) {
		Movie movie = movieDao.getMovie(id);
		movieDao.delMovie(movie);
		System.out.println("deleted");
		return "redirect:../home";
	}

	@RequestMapping(value="/movies/edit",method=RequestMethod.GET)
	public String getEdit(@RequestParam int id, ModelMap models)
	{
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		models.put("movie", movieDao.getMovie(id));
		return "movies/edit";
	}

	@RequestMapping(value="/movies/edit",method=RequestMethod.POST)
	public String postEdit(@ModelAttribute Movie movie, BindingResult results, 
							@RequestParam(required=false) String editmovie_plot, 
							@RequestParam(required=false) List<String> editmovie_genres,
							@RequestParam(required=false) List<String> editmovie_actors,
							@RequestParam(required=false) List<String> editmovie_directors,
							ModelMap models, SessionStatus status) throws ParseException
							{
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		movieValidator.validate(movie, results);
		if(results.hasErrors())
			return "movies/edit";

		if(editmovie_plot != null) movie.setPlot(editmovie_plot);
		if(editmovie_genres != null) {
			Collections.sort(editmovie_genres);
			movie.setGenres(editmovie_genres);
		}
		if(editmovie_actors != null) {
			Collections.sort(editmovie_actors);
			movie.setActors(editmovie_actors);
		}
		if(editmovie_directors != null) {
			Collections.sort(editmovie_directors);
			movie.setDirectors(editmovie_directors);
		}
		movieDao.saveMovie(movie);
		status.setComplete();
		return "redirect:../movies/details2?id=" + movie.getMovieId();
	}
	
	//PRACTICE
	@RequestMapping(value="/movies/{id}/plot", method=RequestMethod.GET)
	@ResponseBody
	public String getPlot(@PathVariable int id){
		Movie movie = movieDao.getMovie(id);
		String formatMovie = "<p><b>Title:  </b>"
				+ "<a href='/movievultures/movies/details2?id=" + movie.getMovieId() +"'>" 
				+ movie.getTitle() + "</a>" +
				"<br /><br /><b>Plot:  </b><p>" + movie.getPlot() + "</p></p>";
		return formatMovie;
	}
	
	@InitBinder
	public void dataBinding(WebDataBinder binder) {
		binder.registerCustomEditor(java.util.Date.class, "date", new CustomDateEditor(new SimpleDateFormat("yyyy"), false));
	}
	
}
