package movievultures.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/* Sources
 * http://www.journaldev.com/8718/spring-4-security-mvc-login-logout-example
 * http://www.studytrails.com/frameworks/spring/spring-security-custom-login-page/
 * http://www.java2blog.com/2016/01/spring-security-custom-login-form.html
 * http://www.java2s.com/Code/Java/JSP/UsingaResetButton.htm
 */

@Controller
public class LoginController {
	@RequestMapping(value="/login", method = RequestMethod.GET)  
	public String login(ModelMap model) {
		return "login";
	}  

	@RequestMapping(value="/loginError", method = RequestMethod.GET)  
	public String loginError(ModelMap model) {
		model.addAttribute("error", "Username and/or Password does not match. Please try again.");  
		return "login";
	}
}