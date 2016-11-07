package movievultures.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

/*
 * Redirecting based on
 * http://stackoverflow.com/questions/21986362/spring-security-redirect-based-on-role
 */

public class AuthenticSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{

	@Override
    protected String determineTargetUrl(HttpServletRequest request, HttpServletResponse response) {
        // Get the role of logged in user
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().toString();

        String targetUrl = "";
        if(role.contains("ROLE_ADMIN")) {
            targetUrl = "/user/list.html";
        }else{
        	targetUrl = "/home.html";
        }
        //additional checking for disabled users? If user is disabled
        return targetUrl;
    }
	
	
}
