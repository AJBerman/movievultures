package movievultures.web.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Year;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import movievultures.model.Movie;
import movievultures.model.dao.MovieDao;

@Controller
public class MovieService {
	
	@Autowired
	MovieDao movieDao;

	@RequestMapping(value="/service/movies/edit", method=RequestMethod.PUT) 
	@ResponseBody
	public void editMovie(HttpServletRequest request) {
		String params;
		JsonObject o;
		JsonParser parser = new JsonParser();
		Gson gson = new Gson();
		Movie m;
		try 
	    {
	        params = IOUtils.toString( request.getInputStream());
	        System.out.println(params);
	        o = (JsonObject) parser.parse(params);
	        m = movieDao.getMovie(o.get("movieId").getAsInt());
	        m.setActors(gson.fromJson(o.get("actors"), new TypeToken<List<String>>() {}.getType() ));
	        m.setGenres(gson.fromJson(o.get("genres"), new TypeToken<List<String>>() {}.getType() ));
	        m.setDirectors(gson.fromJson(o.get("directors"), new TypeToken<List<String>>() {}.getType() ));
	        try {
	        	String year = o.get("year").getAsString();
	        	assert Integer.parseInt(year) >= 1889;
	        	assert Integer.parseInt(year) <= Year.now().getValue() + 5;
	        	Date date = new SimpleDateFormat("yyyy").parse(year);
				m.setDate(date);
			} catch (ParseException e) {
				//okay, so we're not updating the date.
			}
			catch (AssertionError e) {
				//year is out of range
			}
	        m.setPlot(o.get("plot").getAsString());
	        m.setTitle(o.get("title").getAsString());
	        movieDao.saveMovie(m);
	    } 
	    catch (IOException e) 
	    {
	        e.printStackTrace();
	    }
	}
}
