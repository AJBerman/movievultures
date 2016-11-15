package movievultures.web.validator;

import java.time.Year;
import java.util.Calendar;

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
		//check title is not null
		Movie movie = (Movie)target;
		if( !StringUtils.hasText(movie.getTitle() ) )
			errors.rejectValue("title", "error.field.empty");
		//check date range
		if(movie.getDate() != null){
			Calendar cal = Calendar.getInstance();
			cal.setTime(movie.getDate()); //first movie made was in 1889 by Thomas Edison
			if(cal.get(Calendar.YEAR) > (Year.now().getValue() + 5)  || cal.get(Calendar.YEAR) < 1889)
				errors.rejectValue("date","error.date.range");
		}
		//check date is not null
		if( movie.getDate() == null )
			errors.rejectValue("date", "error.field.empty");

	}

}
