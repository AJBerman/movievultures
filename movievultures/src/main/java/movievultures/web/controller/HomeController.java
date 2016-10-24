package movievultures.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping({"/index.html", "/home.html"})
	public String home(){ 
		return "home";
	}
	
}
