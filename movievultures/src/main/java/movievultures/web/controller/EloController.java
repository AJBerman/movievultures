package movievultures.web.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import movievultures.model.EloRunoff;
import movievultures.model.Movie;
import movievultures.model.dao.EloRunoffDao;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.ReviewDao;
import movievultures.model.dao.UserDao;
import movievultures.security.SecurityUtils;

@Controller
public class EloController {
	@Autowired
	private MovieDao movieDao;
	@Autowired
	private EloRunoffDao eloDao; 
	
	@RequestMapping(value = "/elo/add.html", method = RequestMethod.GET)
    public String add( @RequestParam(value="movie1", required = false) Integer movie1id, @RequestParam(value="movie2", required = false) Integer movie2id, ModelMap models )
    {
		if( movie1id == null ) { //using Integer so we can check for nullity
			List<Movie> movies = movieDao.getRandomMovies(2);
			models.put("movie1", movies.get(0));
			models.put("movie2", movies.get(1));
		} else if ( movie2id == null ) {
			models.put("movie1", movieDao.getMovie(movie1id));
			models.put("movie2", movieDao.getRandomMovie());
		} else {
			models.put("movie1", movieDao.getMovie(movie1id));
			models.put("movie2", movieDao.getMovie(movie2id));
		}
        return "elo/add";
    }
	
	@RequestMapping(value = "/elo/add.html", method = RequestMethod.POST)
    public String addpost( @RequestParam("winner") int winner, ModelMap models )
    {
		EloRunoff runoff = new EloRunoff();
		runoff.setDate(new Date());
		runoff.setUser(SecurityUtils.getUser());
		if (winner == 1) {
			runoff.setWinner((Movie) models.get("movie1")); 
			runoff.setLoser((Movie) models.get("movie2")); 
		} else {
			runoff.setLoser((Movie) models.get("movie1")); 
			runoff.setWinner((Movie) models.get("movie2")); 
		}
		movieDao.updateElos(runoff);
		eloDao.saveEloRunoff(runoff);
        return "home";
    }

	@RequestMapping(value = "/elo/view.html", method = RequestMethod.GET)
    public String view( @RequestParam("movie1") int movie1id, @RequestParam("movie2") int movie2id, @RequestParam("userid") int userid, ModelMap models )
    {
		models.put("runoff", eloDao.getEloRunoffByUserAndMovies(userid, movie1id, movie2id));
        return "elo/view";
    }
	
}