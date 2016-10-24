package movievultures.web.validator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import movievultures.model.User;
import movievultures.model.dao.UserDao;

@Component
public class UserValidator implements Validator{
	
	@Autowired
	UserDao userDao;

	@Override
	public boolean supports(Class<?> clazz) {
		
		return User.class.isAssignableFrom( clazz );
		
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User)target;
		if( !StringUtils.hasText(user.getUsername() ) )
			errors.rejectValue("username", "error.field.empty");
		if( !StringUtils.hasText(user.getPassword() ) )
			errors.rejectValue("password", "error.field.empty");
		if( !StringUtils.hasText(user.getEmail() ) )
			errors.rejectValue("email", "error.field.empty");
		
		//check user-name uniqueness
		if(StringUtils.hasText(user.getUsername())){
			boolean unique = true;
			List<User> users = userDao.getUsersByUsername(user.getUsername().toLowerCase());
			for(User u : users){
				if(user.getUsername().equalsIgnoreCase(u.getUsername()))
					unique = false;
			}
			if(!unique)
				errors.rejectValue("username", "error.field.taken");
		}
		
		
	}

}