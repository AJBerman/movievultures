package movievultures.web.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import movievultures.model.EloRunoff;
import movievultures.model.Movie;
import movievultures.model.dao.EloRunoffDao;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.UserDao;
import movievultures.security.SecurityUtils;

@Controller
@SessionAttributes({"movie1", "movie2"})
public class EloController {
	@Autowired
	private MovieDao movieDao;
	@Autowired
	private EloRunoffDao eloDao; 
	@Autowired
	private UserDao userDao; 
	
	@RequestMapping(value = "/elo/add.html", method = RequestMethod.GET)
    public String add( @RequestParam(value="movie1", required = false) Integer movie1id,
    		@RequestParam(value="movie2", required = false) Integer movie2id, 
    		ModelMap models )
    {
		if( movie1id == null && movie2id == null) { //using Integer so we can check for nullity
			List<Movie> movies = movieDao.getRandomMovies(2);
			models.put("movie1", movies.get(0));
			models.put("movie2", movies.get(1));
		} else if ( movie2id == null && movie1id != null ) {
			models.put("movie1", movieDao.getMovie(movie1id));
			models.put("movie2", movieDao.getRandomMovie());
		} else if(movie2id != null && movie1id == null) {
			models.put("movie1", movieDao.getRandomMovie());
			models.put("movie2", movieDao.getMovie(movie2id));
		}else {
			models.put("movie1", movieDao.getMovie(movie1id));
			models.put("movie2", movieDao.getMovie(movie2id));
		}
		System.out.println(((Movie)models.get("movie1")).getMovieId());
        return "elo/add";
    }
	
	@RequestMapping(value = "/elo/add.html", method = RequestMethod.POST)
    public String addpost( @RequestParam("winner") int winner, ModelMap models )
    {
		System.out.println(((Movie)models.get("movie1")).getMovieId());
		EloRunoff runoff = new EloRunoff();
		runoff.setDate(new Date());
		runoff.setUser(userDao.getUserByUsername(SecurityUtils.getUserName()));
		if (winner == 1) {
			runoff.setWinner((Movie) models.get("movie1")); 
			runoff.setLoser((Movie) models.get("movie2")); 
		} else {
			runoff.setLoser((Movie) models.get("movie1")); 
			runoff.setWinner((Movie) models.get("movie2")); 
		}
		movieDao.updateElos(runoff);
		eloDao.saveEloRunoff(runoff);
        return "redirect:add.html?movie1="+runoff.getWinner().getMovieId();
    }

	@RequestMapping(value = "/elo/view.html", method = RequestMethod.GET)
    public String view( @RequestParam("movie1") Integer movie1id, @RequestParam("movie2") Integer movie2id, @RequestParam("userid") int userid, ModelMap models )
    {
		models.put("runoff", eloDao.getEloRunoffByUserAndMovies(userid, movie1id, movie2id));
        return "elo/view";
    }
	
}