package movievultures.web;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

public class HomeController {

	@RequestMapping({"/index.html", "/home.html"})
	public String home(ModelMap models){ //method name doesn't really matter
		models.put("user", "cysun");
		return "home";
	}
	
}
