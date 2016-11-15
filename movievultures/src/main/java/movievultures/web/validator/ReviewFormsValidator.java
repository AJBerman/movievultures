package movievultures.web.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import movievultures.model.Review;


@Component
public class ReviewFormsValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return Review.class.isAssignableFrom( clazz );
	}

	@Override
	public void validate(Object target, Errors errors) {
		Review review = (Review)target;
		if(review.getRating() < 0 || review.getRating() > 5)
			errors.rejectValue("rating", "error.field.invalidRange");
	}

}
