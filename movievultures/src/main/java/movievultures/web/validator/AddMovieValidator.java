package movievultures.web.validator;

import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import movievultures.model.Movie;

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
		if( !StringUtils.hasText((CharSequence) movie.getDate() ) )
			errors.rejectValue("date", "error.field.empty");
		if( !StringUtils.hasText((CharSequence) movie.getGenres() ) )
			errors.rejectValue("genre", "error.field.empty");
	}

}
