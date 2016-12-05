package movievultures.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import movievultures.model.Review;
import movievultures.model.dao.ReviewDao;

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

}
