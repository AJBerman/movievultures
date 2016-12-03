package movievultures.web.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import movievultures.model.Movie;
import movievultures.model.User;
import movievultures.model.dao.EloRunoffDao;
import movievultures.model.dao.MovieDao;
import movievultures.model.dao.UserDao;
import movievultures.recommender.RecommenderUtils;
import movievultures.security.SecurityUtils;
import movievultures.web.validator.EditUserValidator;
import movievultures.web.validator.UserValidator;

@Controller
@SessionAttributes("user")
public class UserController {
	
	@Autowired
	UserDao userDao;
	@Autowired
	MovieDao movieDao;
	@Autowired
	EloRunoffDao eloRunoffDao;
	
	@Autowired
	UserValidator userValidator;
	
	@Autowired
	EditUserValidator editUserValidator;
	
	@Autowired
	RecommenderUtils recommender;
	
	@Autowired
	private MailSender mailSender;
	
	@RequestMapping("user/list")
	public String listUsers(ModelMap models){
		
		List<User> users = userDao.getUsers();
		models.put("users", users);
		
		return "user/list";
	}
	
	//this will take user to user's home page, can view everything
	@RequestMapping("user/{username}/home")
	public String home(@PathVariable String username, ModelMap models){
		String username_sec = "";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken) && username.equals(authentication.getName())){
			username_sec = authentication.getName();
			User user = userDao.getUserByUsername(username_sec);
			models.put("user", user);
			models.put("elos", eloRunoffDao.getEloRunoffsByUser(user));
			return "user/home";
		}else if(!(authentication instanceof AnonymousAuthenticationToken) && !username.equals(authentication.getName())){
			return "redirect:/";
		}else{
			return "redirect:/login";
		}
		
	}
	
	//register user
	@RequestMapping(value="user/register", method=RequestMethod.GET)
	public String register(ModelMap models){
		models.put("user", new User());
		return "user/register";
	}
	
	@RequestMapping(value="user/register", method=RequestMethod.POST)
	public String register(@ModelAttribute User user, BindingResult result, SessionStatus status){
		userValidator.validate(user, result);
		if(result.hasErrors())
			return "user/register";
		//If no errors save user
		Set<String> roles = new HashSet<String>();
		roles.add("ROLE_USER");
		user.setRoles(roles);
		userDao.saveUser(user);
		//free resources
		status.setComplete();
		
		String msgSubject = "Thank you for Joining Movie Vultures!";
		String msgBody = "Hi " + user.getUsername() + "!\r\n\r\nWe are excited to learn that you have joined Movie Vultures! We hope you enjoy "
				+ "the features we will be providing you and we hope that you will be an active member in our community. Thank you again for joining! "
				+ "We look forward to having you as part of our community.\r\n\r\nWith much excitement,\r\nMovie Vultures\r\n\r\nThis is an automated "
				+ "message. If this email was sent in error, please disregard and "
				+ "delete this email. Thank you.";
		SimpleMailMessage msg = new SimpleMailMessage();
		msg.setTo( user.getEmail() );
		msg.setSubject( msgSubject );
		msg.setText( msgBody );
		mailSender.send( msg );
		
		return "redirect:/home";
	}
	
	//updateProfile
	@RequestMapping(value="user/{userId}/profile", method=RequestMethod.GET)
	public String profile(@PathVariable int userId, ModelMap models){
		models.put("user", userDao.getUser(userId));
		return "/user/profile";
	}
	
	@RequestMapping(value="user/{userId}/profile", method=RequestMethod.POST)
	public String profile(@ModelAttribute User user, BindingResult result, SessionStatus status){
		editUserValidator.validate(user, result);
		if(result.hasErrors())
			return "/user/profile";
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/" + user.getUsername() + "/home";
	}
	
	//These methods only delete items from their lists - adding should be done at a movie page.
	
	@RequestMapping("user/addFav")
	public String addFav(@RequestParam int movieId){
		String username = "";
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)){
			username = authentication.getName();
		}else{
			return "redirect:../login";
		}
		User user = userDao.getUserByUsername(username);
		Movie movie = movieDao.getMovie(movieId);
		if(!user.getFavorites().contains(movie))
			user.getFavorites().add(movie);
		userDao.saveUser(user);
		return "redirect:/user/" + user.getUsername() + "/home";
	}
	
	@RequestMapping("user/{userId}/{movieIndex}/removeFav")
	public String removeFav(@PathVariable int userId, @PathVariable int movieIndex, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getFavorites().remove(movieIndex);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/" + user.getUsername() + "/home";
	}
	
	//update recommendations	
	@RequestMapping("user/{userId}/{movieIndex}/removeRec")
	public String removeRec(@PathVariable int userId, @PathVariable int movieIndex, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getRecommendations().remove(movieIndex);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/"+ user.getUsername() + "/home";
	}
	
	@RequestMapping("user/removeWL")
	public String watchLater(@RequestParam int index, @RequestParam int userId, SessionStatus status){
		User user = userDao.getUser(userId);
		user.getWatchLater().remove(index);
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/" + user.getUsername() + "/home";
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
		Movie movie = movieDao.getMovie(movieId);
		if(!user.getWatchLater().contains(movie))
			user.getWatchLater().add(movie);
		userDao.saveUser(user);
		return "redirect:/user/" + user.getUsername() + "/home";
	}
	
	//authorize user
	@RequestMapping("user/authorize")
	public String authorize(@RequestParam int userid){
		User user = userDao.getUser(userid);
		user.getRoles().add("ROLE_ADMIN");
		userDao.saveUser(user);
		return "redirect:/user/list";
	}
	
	@RequestMapping(value="user/{userId}/management", method=RequestMethod.GET)
	public String manage(@PathVariable int userId, ModelMap models){
		//only authenticated users allowed here
		if(!SecurityUtils.getRoles().contains("ROLE_ADMIN"))
			return "redirect:/home";
		models.put("user", userDao.getUser(userId));
		return "user/management";
	}
	
	@RequestMapping(value="user/{userId}/management", method=RequestMethod.POST)
	public String manage( @ModelAttribute User user,
			@RequestParam(required = false) boolean authority,
			SessionStatus status){
		if(authority){
			user.getRoles().add("ROLE_ADMIN");
		}
		userDao.saveUser(user);
		status.setComplete();
		return "redirect:/user/list";
	}

	
	@RequestMapping(value="user/searchForm", method=RequestMethod.GET)
	public String searchUsers(){
		return "user/searchResults";
	}
	
	@RequestMapping(value="user/searchResults", method=RequestMethod.POST)
	public String searchResults(ModelMap models, 
			@RequestParam(value="nameQuery", required = false) String username){
		List<User> users;
		if(username != null)
			users = userDao.getUsersByUsername(username);
		else
			users = userDao.getUsers();
		models.put("users", users);

		return "user/searchResults";
	}

}
