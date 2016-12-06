package movievultures.web.service;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import movievultures.model.Review;
import movievultures.model.dao.ReviewDao;
import movievultures.security.SecurityUtils;

@Controller
public class ReviewService {

	@Autowired 
	private ReviewDao reviewDao;
	
	@RequestMapping(value="/service/reviews", method=RequestMethod.POST)
	@ResponseBody
	public Review addReview(@RequestBody Review review){
		//following sun's example, exactly
		return reviewDao.saveReview(review);
	}
	
	@RequestMapping(value="/service/reviews/edit", method=RequestMethod.PUT) 
	@ResponseBody
	public void editReview(HttpServletRequest request) {
		String params;
		JsonObject o;
		JsonParser parser = new JsonParser();
		Review r;
		try 
	    {
	        params = IOUtils.toString( request.getInputStream());
	        System.out.println(params);
	        o = (JsonObject) parser.parse(params);
			r = reviewDao.getReview(o.get("reviewId").getAsInt());
	        assert SecurityUtils.getUserName().equals(r.getUser().getUsername());
			r.setRating(o.get("rating").getAsDouble());
			r.setReview(o.get("review").getAsString());
			r.setDate(new Date());
			reviewDao.saveReview(r);
	    } 
	    catch (IOException e) 
	    {
	        e.printStackTrace();
	    }
		catch (AssertionError e) {
			//Do nothing, but we don't want the rest of the code to execute.
		}
	}
}
