package movievultures.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
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
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.UserDao;
import movievultures.web.validator.EditUserValidator;
import movievultures.web.validator.UserValidator;

@Controller
public class UserController {
	
	@Autowired
	UserDao userDao;
	@Autowired
	MovieDao movieDao;
	
	@Autowired
	UserValidator userValidator;
	
	@Autowired
	EditUserValidator editUserValidator;
	@RequestMapping("user/list.html")
	public String listUsers(ModelMap models){
		
		List<User> users = userDao.getUsers();
		models.put("users", users);
		
		return "user/list";
	}
	
	//this will take user to user's home page, can view everything
	@RequestMapping("user/home.html")
	public String home(@RequestParam String username, ModelMap models){
		String username_sec = "";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)){
			username_sec = authentication.getName();
		}else{
			return "redirect:../login";
		}
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
		editUserValidator.validate(user, result);
		if(result.hasErrors())
			return "user/profile";
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	
	//These methods only delete items from their lists - adding should be done at a movie page.
	
	@RequestMapping("user/addFav")
	public String addFav(@RequestParam int movieId){
		String username = "";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//String currentPrincipalName = authentication.getName();
		if(!(authentication instanceof AnonymousAuthenticationToken)){
			username = authentication.getName();
		}else{
			return "redirect:../login";
		}
		User user = userDao.getUserByUsername(username);
		user.getFavorites().add(movieDao.getMovie(movieId));
		userDao.saveUser(user);
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	
	@RequestMapping("user/removeFav")
	public String removeFav(@RequestParam int index, @RequestParam int userId, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getFavorites().remove(index);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	
	//update recommendations	
	@RequestMapping("user/removeRec")
	public String removeRec(@RequestParam int index, @RequestParam int userId, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getRecommendations().remove(index);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	
	@RequestMapping("user/removeWL")
	public String watchLater(@RequestParam int index, @RequestParam int userId, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getWatchLater().remove(index);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/home.html?username=" + user.getUsername();
	}
	
	@RequestMapping("user/addWL")
	public String addWL(@RequestParam int movieId){
		String username = "";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)){
			username = authentication.getName();
		}else{
			return "redirect:../login";
		}
		User user = userDao.getUserByUsername(username);
		user.getWatchLater().add(movieDao.getMovie(movieId));
		userDao.saveUser(user);
		return "redirect:/user/home.html?username=" + user.getUsername();
	}

}
