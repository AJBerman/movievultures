package movievultures.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import movievultures.model.User;
import movievultures.model.dao.UserDao;

@Controller
public class UserController {
	
	@Autowired
	UserDao userDao;
	
	@RequestMapping("users/list.html")
	public String listUsers(ModelMap models){
		
		List<User> users = userDao.getUsers();
		models.put("users", users);
		
		return "users/list";
	}

}
