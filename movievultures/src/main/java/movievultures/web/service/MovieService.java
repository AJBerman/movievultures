package movievultures.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import movievultures.model.Movie;
import movievultures.model.dao.MovieDao;

@Controller
public class MovieService {
	
	@Autowired
	private MovieDao movieDao;
	
	//return movie in xml format - might not work?
	@RequestMapping(value="/movies/movie/{id}.xml", method=RequestMethod.GET)
	public String getMovieXml(@PathVariable Integer id, ModelMap models){
		models.put("movie", movieDao.getMovie( id ) );
		return "movie.xml";
	}
	
	//return movie in json format
	@RequestMapping(value="/service/movies/movie/{id}.json", method=RequestMethod.GET)
	public String getMovieJson(@PathVariable Integer id, ModelMap models){
		models.put( "movie", movieDao.getMovie( id ) );
		return "movie.json";
	}
	
    @RequestMapping(value = "/movies/add", method = RequestMethod.POST)
    @ResponseBody
    public Movie addMovie(
    		@ModelAttribute Movie movie, BindingResult result, SessionStatus status,
			@RequestParam(required=false) List<String> addmovie_genres,
			@RequestParam(required=false) List<String> addmovie_actors, 
			@RequestParam(required=false) List<String> addmovie_directors 
    		){
    	//finish this
    	return movieDao.saveMovie(movie);
    }

}
