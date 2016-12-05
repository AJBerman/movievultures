package movievultures.web.service;

import java.util.List;

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
	
	@RequestMapping(value = "/service/{id}/user.json",
	        method = RequestMethod.GET)
	String getUserJson(@PathVariable Integer id, ModelMap models){
		models.put( "user", userDao.getUser( id ) );
		return "service/user.json";
	}
	
	@RequestMapping(value = "/service/{id}/user.xml", 
			method = RequestMethod.GET)
	String getUserXml( @PathVariable Integer id, ModelMap models){
		models.put( "user", userDao.getUser( id ) );
		return "service/user.xml";
	}
	
	//Service to update user role/privileges.
    @RequestMapping(value = "/service/user/{id}/{enabled}/{authorized}", method=RequestMethod.PUT)
    @ResponseBody
    public void updateUser( @PathVariable Integer id, @PathVariable boolean enabled, @PathVariable boolean authorized )
    {
    	System.out.println("Inside the service!");
        User user = userDao.getUser(id);
        user.setEnabled(enabled);
        if(authorized){
        	user.getRoles().add("ROLE_ADMIN");
        }
        userDao.saveUser(user);
    }
    
    //Service to delete movies from favorites or watchLater
    @RequestMapping(value = "/service/user/{id}/table/{tableId}/{index}", method=RequestMethod.PUT)
    @ResponseBody
    public void updateUserTables(@PathVariable int id, @PathVariable String tableId, 
    		@PathVariable int index){
    	User user = userDao.getUser(id);
    	if(tableId.equalsIgnoreCase("fav")) //if one remove from favorites
    		user.getFavorites().remove(index);
    	else  //else remove from watch later
    		user.getWatchLater().remove(index);
    	//save user
    	userDao.saveUser(user);
    }
    
    //Service to return user names or list of strings
    @RequestMapping(value = "/service/users/{term}", method=RequestMethod.GET)
    @ResponseBody
    public List<String> getUserNames(@PathVariable String term){
    	return userDao.getUsernames(term);
    }

}
