package movievultures.web.validator;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import movievultures.model.User;

@Component
public class EditUserValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {

		return User.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		User user = (User) target;
		if (!StringUtils.hasText(user.getPassword()))
			errors.rejectValue("password", "error.field.empty");
		if (!StringUtils.hasText(user.getEmail()))
			errors.rejectValue("email", "error.field.empty");

		// check email
		if (StringUtils.hasText(user.getEmail())) {
			if (!isValidEmailAddress(user.getEmail()))
				errors.rejectValue("email", "error.invalid.email");
		}

	}

	public static boolean isValidEmailAddress(String email) {
		boolean result = true;
		try {
			InternetAddress emailAddr = new InternetAddress(email);
			emailAddr.validate();
		} catch (AddressException ex) {
			result = false;
		}
		return result;
	}

}
