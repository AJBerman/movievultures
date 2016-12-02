package movievultures.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import movievultures.model.dao.UserDao;

@Controller
public class UserService {

	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value = "/user/user/{id}.json",
	        method = RequestMethod.GET)
	String getUserJson(@PathVariable Integer id, ModelMap models){
		models.put( "user", userDao.getUser( id ) );
		return "user.json";
	}
	
	
}
