package movievultures.web.validator;

import java.util.Date;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import movievultures.model.Movie;

@Component
public class AddMovieValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		
		return Movie.class.isAssignableFrom( clazz );
	}

	@Override
	public void validate(Object target, Errors errors) {
		Movie movie = (Movie)target;
		if( !StringUtils.hasText(movie.getTitle() ) )
			errors.rejectValue("title", "error.field.empty");
		if(movie.getDate() != null){
			Date now = new Date();
			if(movie.getDate().getYear() > now.getYear() + 5  || movie.getDate().getYear() < 1900)
				errors.rejectValue("date","error.date.range");
		}
//		if( movie.getDate() == null )
//			errors.rejectValue("date", "error.field.empty");

	}

}
