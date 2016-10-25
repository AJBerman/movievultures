package movievultures.web.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import movievultures.model.Movie;
import movievultures.model.Review;
import movievultures.model.User;
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

	@RequestMapping(value = "/home.html", method = RequestMethod.GET)
	public String getHome() {
		return "home";
	}

	@RequestMapping(value = "/movies.html", method = RequestMethod.GET)
	public String getMovies(ModelMap models) {

		List<Movie> movies = movieDao.getRandomMovies(10);
		for (int i = 0; i < movies.size(); i++) {
			// to remove {" and "} at the beginning an d end of the plot
			if (movies.get(i).getPlot().contains("{")) {
				movies.get(i).setPlot(movies.get(i).getPlot().substring(2, movies.get(i).getPlot().length() - 2));
			}
			// to remove "," from the plot - Figure this one later
			movies.get(i).setPlot(movies.get(i).getPlot().replace(" [\",\"] ", ""));
		}
		models.put("movies", movies);
		return "movies";
	}

	@RequestMapping(value = "/movies/add.html", method = RequestMethod.GET)
	public String getAddMovies() {
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		return "movies/add";
	}

	@RequestMapping(value = "/movies/add.html", method = RequestMethod.POST)
	public String postAddMovies(@RequestParam String addmovie_title, @RequestParam String addmovie_plot,
			@RequestParam String addmovie_date, @RequestParam String addmovie_genres,
			@RequestParam String addmovie_actors, @RequestParam String addmovie_directors, ModelMap models)
					throws ParseException {
		Movie movie = new Movie();
		movie.setTitle(addmovie_title);
		movie.setPlot(addmovie_plot);
		DateFormat format = new SimpleDateFormat("yyyy-MM-DD");
		// Date d=format.parse(source)
		System.out.println(format.parse(addmovie_date));
		movie.setDate(format.parse(addmovie_date));
		movie.setEloRating(1200.0); //1200 is the default Elo Rating
		movie.setHidden(false);

		List<String> genres = new ArrayList<>();
		String[] gen = addmovie_genres.split(",");
		for (int i = 0; i < gen.length; i++) {
			genres.add(gen[i]);
		}
		movie.setGenres(genres);

		List<String> cast = new ArrayList<>();
		String[] actors = addmovie_actors.split(",");
		for (int i = 0; i < actors.length; i++) {
			cast.add(actors[i]);
		}
		movie.setActors(cast);
		
		List<String> directors = new ArrayList<>();
		String[] dir = addmovie_directors.split(",");
		for (int i = 0; i < dir.length; i++) {
			directors.add(dir[i]);
		}
		movie.setDirectors(directors);
		
		movieDao.saveMovie(movie);

		
		// movie saved to db
		// return to home

		List<Movie> movies = movieDao.getRandomMovies(10);
		for (int i = 0; i < movies.size(); i++) {
			// to remove {" and "} at the beginning an d end of the plot
			if (movies.get(i).getPlot().contains("{")) {
				movies.get(i).setPlot(movies.get(i).getPlot().substring(2, movies.get(i).getPlot().length() - 2));
			}
			// to remove "," from the plot - Figure this one later
			movies.get(i).setPlot(movies.get(i).getPlot().replace(" [\",\"] ", ""));
		}

		models.put("movies", movies);
		return "redirect:../movies.html";
	}

	@RequestMapping(value = "/movies/details.html")
	public String getDetails(@RequestParam String id, ModelMap models) {
		int Id = Integer.parseInt(id);
		// System.out.println("in here");
		Movie movie = movieDao.getMovie(Id);
		models.put("movie", movie);
		models.put("user", SecurityUtils.getUser());
		return "movies/details";
	}

	@RequestMapping(value = "/movies/delete.html")
	public String getDelete(@RequestParam String id, ModelMap models) {
		int Id = Integer.parseInt(id);
		Movie movie = movieDao.getMovie(Id);
		movieDao.delMovie(movie);
		System.out.println("deleted");
		List<Movie> movies = movieDao.getRandomMovies(10);
		for (int i = 0; i < movies.size(); i++) {
			// to remove {" and "} at the beginning an d end of the plot
			if (movies.get(i).getPlot().contains("{")) {
				movies.get(i).setPlot(movies.get(i).getPlot().substring(2, movies.get(i).getPlot().length() - 2));
			}
			// to remove "," from the plot - Figure this one later
			movies.get(i).setPlot(movies.get(i).getPlot().replace(" [\",\"] ", ""));
		}
		models.put("movies", movies);
		return "redirect:../movies.html";
	}

	@RequestMapping(value="/movies/edit.html",method=RequestMethod.GET)
	public String getEdit(@RequestParam String id, ModelMap models)
	{
		if(!SecurityUtils.isAuthenticated())
			return "redirect:../login";
		int Id=Integer.parseInt(id);
		Movie movie=movieDao.getMovie(Id);
		int i;
		List<String> gen=movie.getGenres();
		String genres="";
		if(gen.size()!=0)
		{
			for( i=0;i<gen.size()-1;i++)
			{
				genres+=gen.get(i)+",";
			}
			genres+=gen.get(i);
		}
		
		
		
		String actors="";
		List<String> act=movie.getActors();
		if(act.size()!=0)
		{
			for( i=0;i<act.size()-1;i++)
			{
				actors+=act.get(i)+",";
			}
			actors+=act.get(i);
		}
		
		String directors="";
		List<String> dir=movie.getDirectors();
		if(dir.size()!=0)
		{
			for( i=0;i<dir.size()-1;i++)
			{
				directors+=dir.get(i)+",";
			}
			directors+=dir.get(i);
		}
		
		
		models.put("movie", movie);
		models.put("genres", genres);
		models.put("actors", actors);
		models.put("directors", directors);
		return "movies/edit";
	}

	@RequestMapping(value="/movies/edit.html",method=RequestMethod.POST)
	public String postEdit(@RequestParam String id,
							@RequestParam String editmovie_title, 
							@RequestParam String editmovie_plot, 
							@RequestParam String editmovie_date,
							@RequestParam String editmovie_genres,
							@RequestParam String editmovie_actors,
							@RequestParam String editmovie_directors,
							ModelMap models) throws ParseException
	{
		int Id=Integer.parseInt(id);
		Movie movie=movieDao.getMovie(Id);
		movie.setTitle(editmovie_title);
		movie.setPlot(editmovie_plot);
		DateFormat format = new SimpleDateFormat("yyyy-MM-DD");
		movie.setDate(format.parse(editmovie_date));
		
		List<String> genres = new ArrayList<>();
		String[] gen = editmovie_genres.split(",");
		for (int i = 0; i < gen.length; i++) {
			genres.add(gen[i]);
		}
		movie.setGenres(genres);

		List<String> cast = new ArrayList<>();
		String[] actors = editmovie_actors.split(",");
		for (int i = 0; i < actors.length; i++) {
			cast.add(actors[i]);
		}
		movie.setActors(cast);
		
		List<String> directors = new ArrayList<>();
		String[] dir = editmovie_directors.split(",");
		for (int i = 0; i < dir.length; i++) {
			directors.add(dir[i]);
		}
		movie.setDirectors(directors);
		
		movie=movieDao.saveMovie(movie);

		return "redirect:../movies/details.html?id="+Id;
	}
	
}
