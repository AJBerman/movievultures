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
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import movievultures.model.User;
import movievultures.model.dao.UserDao;
import movievultures.web.validator.UserValidator;

@Controller
@SessionAttributes("user")
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
	
	//updateProfile
	@RequestMapping(value="user/profile.html", method=RequestMethod.GET)
	public String profile(@RequestParam int userId, ModelMap models){
		models.put("user", userDao.getUser(userId));
		return "user/profile";
	}
	
	@RequestMapping(value="user/profile.html", method=RequestMethod.POST)
	public String profile(@ModelAttribute User user, BindingResult result, SessionStatus status){
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	//These methods only delete items from their lists - adding should be done at a movie page.
	
	//updateFavorites
	@RequestMapping("user/favorites.html")
	public String favorites(@RequestParam int userId, ModelMap models){
		models.put("user", userDao.getUser(userId));
		return "user/favorites";
	}
	
	@RequestMapping(value="user/removeFav", method=RequestMethod.GET)
	public String removeFav(@RequestParam int index, @RequestParam int userId, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getFavorites().remove(index);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	
	//update recommendations
	
	@RequestMapping("user/recommendations.html")
	public String recommendations(@RequestParam int userId, ModelMap models){
		models.put("user", userDao.getUser(userId));
		return "user/recommendations";
	}
	
	@RequestMapping(value="user/removeRec", method=RequestMethod.GET)
	public String removeRec(@RequestParam int index, @RequestParam int userId, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getRecommendations().remove(index);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	
	//update watchLater
	
	@RequestMapping(value="user/watchLater", method=RequestMethod.GET)
	public String watchLater(@RequestParam int userId, ModelMap models){
		models.put("user", userDao.getUser(userId));
		return "user/watchLater";
	}
	
	@RequestMapping(value="user/watchLater", method=RequestMethod.POST)
	public String watchLater(@RequestParam int index, @RequestParam int userId, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getFavorites().remove(index);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}

}
