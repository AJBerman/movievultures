package movievultures.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import movievultures.model.User;
import movievultures.model.dao.UserDao;

@Controller
public class UserController {
	
	@Autowired
	UserDao userDao;
	
	@RequestMapping("user/list.html")
	public String listUsers(ModelMap models){
		
		List<User> users = userDao.getUsers();
		models.put("users", users);
		
		return "user/list";
	}
	
	//this will take user to user's home page, can view everything
	@RequestMapping("user/home.html")
	public String home(@RequestParam String username, ModelMap models){
		models.put("user", userDao.getUserByUsername(username));
		
		return "user/home";
	}
	
	//Can view other users movie ratings? Can't edit.
	@RequestMapping("user/view.html")
	public String view(@RequestParam int userId, ModelMap models){
		models.put("user", userDao.getUser(userId));
		return "user/view";
	}
	//register user
	
	//edit user

}
