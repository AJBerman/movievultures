package movievultures.web.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import movievultures.model.Movie;
import movievultures.model.dao.MovieDao;

@Controller
public class SearchController {
	
	@Autowired
	private MovieDao movieDao;
	
	@RequestMapping("/search/searchMovies2")
	public String noSearch( ModelMap models )
	{
		return "../search/searchMovies4";
	}
	
	@RequestMapping(value = "/search/searchMovies4", method = RequestMethod.GET)
	public String search( ModelMap models, @RequestParam String searchTerm, @RequestParam Integer type, @RequestParam Integer comparator )
	{
		//System.out.println("Search Term: " + searchTerm);
		//System.out.println("Type of Search: " + type);
		//System.out.println(movieDao.getAverageRating(1));
		models.put("searchTerm", searchTerm);
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
		models.put("comparator", comp);
		
		switch( type ) {
			case 1:
				// get all movies with this title
				List<Movie> movieTitle = movieDao.getMoviesByTitle(searchTerm);
				models.put("movieResults", movieTitle);
				models.put("type", "title");
				break;
			case 2:
				// get all movies with this genre
				List<Movie> movieGenre = movieDao.getMoviesByGenre(searchTerm);
				models.put("movieResults", movieGenre);
				models.put("type", "genre");
				break;
			case 3:
				// get all movies with this director
				List<Movie> movieDirector = movieDao.getMoviesByDirector(searchTerm);
				models.put("movieResults", movieDirector);
				models.put("type", "director");
				break;
			case 4:
				//get all movies with this actor/actress
				List <Movie> movieArtist = movieDao.getMoviesByActor(searchTerm);
				models.put("movieResults", movieArtist);
				models.put("type", "actor");
				break;
			case 5:
				//get all movies by year of release
				int sT1 = Integer.parseInt(searchTerm);
				List<Movie> smlMovieYear = movieDao.getMoviesByYear(sT1, comp);
				models.put("movieResults", smlMovieYear);
				models.put("type", "year of release");
				break;
			case 6:
				//get all movies by total user rating
				double sT4 = Double.parseDouble(searchTerm);
				List<Movie> smlMovieUR = movieDao.getMoviesByUserRating(sT4, comp);
				models.put("movieResults", smlMovieUR);
				models.put("type", "user rating");
				break;
			case 7:
				//get all movies by total elo rating
				double sT7 = Double.parseDouble(searchTerm);
				List<Movie> smlMovieER = movieDao.getMoviesByEloRating(sT7, comp);
				models.put("movieResults", smlMovieER);
				models.put("type", "Elo rating");
				break;
			case 8:
				//get random list of movies
				List<Movie> ranMovies = movieDao.getRandomMovies(100);
				models.put("movieResults", ranMovies);
				models.put("type", "random movies");
				break;
			case 9:
				//FTS (non-indexable)
				List<Object[]> results = movieDao.fullTextSearch(searchTerm);
				List<Movie> ftsMovieResults = new ArrayList<Movie>();
				List<String> headlines = new ArrayList<String>();
				for(Object[] res: results) {
					ftsMovieResults.add((Movie) res[0]);
					headlines.add((String) res[1]);
				}
				models.put("movieResults", ftsMovieResults);
				models.put("headlines", headlines);
				models.put("type", "Full Text Search");
				break;
			case 10:
				//FTS (indexable)
				List<Object[]> results2 = movieDao.fullTextSearchIndexed(searchTerm);
				List<Movie> ftsMovieResults2 = new ArrayList<Movie>();
				List<String> headlines2 = new ArrayList<String>();
				for(Object[] res: results2) {
					ftsMovieResults2.add((Movie) res[0]);
					headlines2.add((String) res[1]);
				}
				models.put("movieResults", ftsMovieResults2);
				models.put("headlines", headlines2);
				models.put("type", "Full Text Search");
				break;
			default:
				break;
		}
		return "search/searchMovies4";
	}
	
}
