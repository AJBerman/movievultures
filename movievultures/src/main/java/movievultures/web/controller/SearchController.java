package movievultures.web.controller;

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
import movievultures.security.SecurityUtils;

@Controller
public class SearchController {
	
	@Autowired
	private MovieDao movieDao;
	
	@RequestMapping("/search/searchMovies2.html")
	public String noSearch( ModelMap models )
	{
		return "../search/searchMovies4";
	}
	
	@RequestMapping(value = "/search/searchMovies4.html", method = RequestMethod.GET)
	public String search()
	{
		return "search/searchMovies4";
	}
	
	@RequestMapping(value = "/search/searchMovies4.html", method = RequestMethod.POST)
	public String search( ModelMap models, @RequestParam String searchTerm, @RequestParam Integer type, @RequestParam Integer comparator )
	{
		//System.out.println("Search Term: " + searchTerm);
		//System.out.println("Type of Search: " + type);
		//System.out.println(movieDao.getAverageRating(1));
		String comp = "";
		switch( comparator ) {
			case 1:
				comp=">";
				break;
			case 2:
				comp="<";
				break;
			case 3:
				comp="=";
				break;
			case 4:
				comp="!=";
				break;
			default:
				comp="=";
				break;
		}
		switch( type ) {
			case 1:
				// get all movies with this title
				List<Movie> movieTitle = movieDao.getMoviesByTitle(searchTerm);
				models.put("movieResults", movieTitle);
				break;
			case 2:
				// get all movies with this genre
				List<Movie> movieGenre = movieDao.getMoviesByGenre(searchTerm);
				models.put("movieResults", movieGenre);
				break;
			case 3:
				// get all movies with this director
				List<Movie> movieDirector = movieDao.getMoviesByDirector(searchTerm);
				models.put("movieResults", movieDirector);
				break;
			case 4:
				//get all movies with this actor/actress
				List <Movie> movieArtist = movieDao.getMoviesByActor(searchTerm);
				models.put("movieResults", movieArtist);
				break;
			case 5:
				//get all movies by year of release
				int sT1 = Integer.parseInt(searchTerm);
				List<Movie> smlMovieYear = movieDao.getMoviesByYear(sT1, comp);
				models.put("movieResults", smlMovieYear);
				break;
			case 6:
				//get all movies by total user rating
				double sT4 = Double.parseDouble(searchTerm);
				List<Movie> smlMovieUR = movieDao.getMoviesByUserRating(sT4, comp);
				models.put("movieResults", smlMovieUR);
				break;
			case 11:
				//get all movies by total elo rating
				double sT7 = Double.parseDouble(searchTerm);
				List<Movie> smlMovieER = movieDao.getMoviesByEloRating(sT7, comp);
				models.put("movieResults", smlMovieER);
				break;
			default:
				break;
		}
		
		return "search/searchMovies4";
	}
	
}
