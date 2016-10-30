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
import movievultures.model.dao.MovieDao;

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
	public String search( ModelMap models, @RequestParam String searchTerm, @RequestParam Integer type )
	{
		//System.out.println("Search Term: " + searchTerm);
		//System.out.println("Type of Search: " + type);
		
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
				//get all movies less than this year of release
				int sT1 = Integer.parseInt(searchTerm);
				List<Movie> smlMovieYear = movieDao.getMoviesSmallerYear(sT1);
				models.put("movieResults", smlMovieYear);
				break;
			case 6:
				//get all movies greater than this year of release
				int sT2 = Integer.parseInt(searchTerm);
				List<Movie> grtMovieYear = movieDao.getMoviesGreaterYear(sT2);
				models.put("movieResults", grtMovieYear);
				break;
			case 7:
				//get all movies equal to this year of release
				int sT3 = Integer.parseInt(searchTerm);
				List<Movie> eqMovieYear = movieDao.getMovieEqualYear(sT3);
				models.put("movieResults", eqMovieYear);
				break;
			case 8:
				//get all movies less than this total user rating
				double sT4 = Double.parseDouble(searchTerm);
				List<Movie> smlMovieUR = movieDao.getMoviesSmallerUserRating(sT4);
				models.put("movieResults", smlMovieUR);
				break;
			case 9:
				//get all movies greater than this total user rating
				double sT5 = Double.parseDouble(searchTerm);
				List<Movie> grtMovieUR = movieDao.getMoviesGreaterUserRating(sT5);
				models.put("movieResults", grtMovieUR);
				break;
			case 10:
				//get all movies equal to this total user rating
				double sT6 = Double.parseDouble(searchTerm);
				List<Movie> eqMovieUR = movieDao.getMovieEqualUserRating(sT6);
				models.put("movieResults", eqMovieUR);
				break;
			case 11:
				//get all movies less than this total elo rating
				double sT7 = Double.parseDouble(searchTerm);
				List<Movie> smlMovieER = movieDao.getMoviesSmallerEloRating(sT7);
				models.put("movieResults", smlMovieER);
				break;
			case 12:
				//get all movies greater than this total elo rating
				double sT8 = Double.parseDouble(searchTerm);
				List<Movie> grtMovieER = movieDao.getMoviesGreaterEloRating(sT8);
				models.put("movieResults", grtMovieER);
				break;
			case 13:
				//get all movies equal this total elo rating
				double sT9 = Double.parseDouble(searchTerm);
				List<Movie> eqMovieER = movieDao.getMovieEqualEloRating(sT9);
				models.put("movieResults", eqMovieER);
				break;
			default:
				break;
		}
		
		return "search/searchMovies4";
	}
	
}
