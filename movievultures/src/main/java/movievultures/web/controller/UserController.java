package movievultures.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import movievultures.model.User;
import movievultures.model.dao.UserDao;
import movievultures.web.validator.UserValidator;

@Controller
public class UserController {
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	UserValidator userValidator;
	
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
	@RequestMapping(value="user/register.html", method=RequestMethod.GET)
	public String register(ModelMap models){
		models.put("user", new User());
		return "user/register";
	}
	
	@RequestMapping(value="user/register.html", method=RequestMethod.POST)
	public String register(@ModelAttribute User user, BindingResult result, SessionStatus status){
		userValidator.validate(user, result);
		if(result.hasErrors())
			return "user/register";
		//If no errors save user
		userDao.saveUser(user);
		//free resources
		status.setComplete();
		
		return "redirect:list.html";
	}
	
	//edit user
	@RequestMapping(value="user/edit.html", method=RequestMethod.GET)
	public String edit(@RequestParam int userId, ModelMap models){
		models.put("user", userDao.getUser(userId));
		return "user/edit";
	}

}
