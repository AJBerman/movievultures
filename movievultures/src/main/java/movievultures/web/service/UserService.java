package movievultures.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import movievultures.model.User;
import movievultures.model.dao.UserDao;

@Controller
public class UserService {

	@Autowired
	private UserDao userDao;
	
	@RequestMapping(value = "service/{id}/user.json",
	        method = RequestMethod.GET)
	String getUserJson(@PathVariable Integer id, ModelMap models){
		models.put( "user", userDao.getUser( id ) );
		return "service/user.json";
	}
	
	@RequestMapping(value = "service/{id}/user.xml", 
			method = RequestMethod.GET)
	String getUserXml( @PathVariable Integer id, ModelMap models){
		models.put( "user", userDao.getUser( id ) );
		return "service/user.xml";
	}
//	
//	@RequestMapping("user/user/{id}")
//	@ResponseBody
//	public void removeFav(@RequestParam int index, @RequestBody User user){
//
//		userDao.saveUser(user);
//	}
}
