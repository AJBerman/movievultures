package movievultures.web.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.NestedServletException;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;
import movievultures.model.dao.EloRunoffDao;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.ReviewDao;
import movievultures.model.dao.UserDao;
import movievultures.security.SecurityUtils;

@Controller
public class MovieController {

	@Autowired
	private MovieDao movieDao;

	@Autowired
	private ReviewDao reviewDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private EloRunoffDao eloRunoffDao;
	
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

	@RequestMapping(value = "/movies/add.html", method = RequestMethod.GET)
	public String getAddMovies() {
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		return "movies/add";
	}

	@RequestMapping(value = "/movies/add.html", method = RequestMethod.POST)
	public String postAddMovies(@RequestParam String addmovie_title, 
			@RequestParam String addmovie_plot,
			@RequestParam String addmovie_date, 
			@RequestParam List<String> addmovie_genres,
			@RequestParam List<String> addmovie_actors, 
			@RequestParam List<String> addmovie_directors, ModelMap models)
					throws ParseException {
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		Movie movie = new Movie();
		movie.setTitle(addmovie_title);
		movie.setPlot(addmovie_plot);
		DateFormat format = new SimpleDateFormat("yyyy");
		// Date d=format.parse(source)
		System.out.println(format.parse(addmovie_date));
		movie.setDate(format.parse(addmovie_date));
		movie.setEloRating(1200.0); //1200 is the default Elo Rating
		movie.setHidden(false);
		Collections.sort(addmovie_genres);
		movie.setGenres(addmovie_genres);
		Collections.sort(addmovie_actors);
		movie.setActors(addmovie_actors);
		Collections.sort(addmovie_directors);
		movie.setDirectors(addmovie_directors);
		movie=movieDao.saveMovie(movie);
		// movie saved to db
		return "redirect:details2.html?id="+movie.getMovieId();
	}

	@RequestMapping(value = "/movies/details2.html")
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

	@RequestMapping(value = "/movies/delete.html")
	public String getDelete(@RequestParam int id, ModelMap models) {
		Movie movie = movieDao.getMovie(id);
		movieDao.delMovie(movie);
		System.out.println("deleted");
		return "redirect:../home.html";
	}

	@RequestMapping(value="/movies/edit.html",method=RequestMethod.GET)
	public String getEdit(@RequestParam int id, ModelMap models)
	{
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		models.put("movie", movieDao.getMovie(id));
		return "movies/edit";
	}

	@RequestMapping(value="/movies/edit.html",method=RequestMethod.POST)
	public String postEdit(@RequestParam int id,
							@RequestParam String editmovie_title, 
							@RequestParam String editmovie_plot, 
							@RequestParam String editmovie_date,
							@RequestParam List<String> editmovie_genres,
							@RequestParam List<String> editmovie_actors,
							@RequestParam List<String> editmovie_directors,
							ModelMap models) throws ParseException
							{
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		Movie movie=movieDao.getMovie(id);
		movie.setTitle(editmovie_title);
		movie.setPlot(editmovie_plot);
		//DateFormat format = new SimpleDateFormat("yyyy-MM-DD");
		DateFormat format = new SimpleDateFormat("yyyy");
		movie.setDate(format.parse(editmovie_date));
		Collections.sort(editmovie_genres);
		movie.setGenres(editmovie_genres);
		Collections.sort(editmovie_actors);
		movie.setActors(editmovie_actors);
		Collections.sort(editmovie_directors);
		movie.setDirectors(editmovie_directors);
		movie=movieDao.saveMovie(movie);
		return "redirect:../movies/details2.html?id="+id;
	}
	
}
