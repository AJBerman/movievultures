package movievultures.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import movievultures.model.Movie;
import movievultures.model.User;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.UserDao;



@Controller
public class HomeController {
	
	@Autowired
	MovieDao movieDao;
	
	@Autowired
	UserDao userDao;

	@RequestMapping({"/index.html", "/home.html"})
	public String home(ModelMap models){ 
		//check to see if we're authenticated
		List<Movie> movies;
		List<Movie> movies2;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)){
			User user = userDao.getUserByUsername(authentication.getName());
			movies = user.getFavorites();
			models.put("movies", movies);
			movies2 = user.getWatchLater();
			models.put("movies2", movies2);
		}else{
			movies = movieDao.getRandomMovies(5);
			models.put("movies", movies);
		}
		
		return "home";
	}
	
}
