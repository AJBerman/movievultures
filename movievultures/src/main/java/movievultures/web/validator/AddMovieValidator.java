package movievultures.web.validator;

import java.time.Year;
import java.util.Calendar;
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

	@SuppressWarnings("deprecation")
	@Override
	public void validate(Object target, Errors errors) {
		Movie movie = (Movie)target;
		if( !StringUtils.hasText(movie.getTitle() ) )
			errors.rejectValue("title", "error.field.empty");
		if(movie.getDate() != null){
			Calendar cal = Calendar.getInstance();
			cal.setTime(movie.getDate());
			if(cal.get(Calendar.YEAR) > (Year.now().getValue() + 5)  || cal.get(Calendar.YEAR) < 1900)
				errors.rejectValue("date","error.date.range");
		}
//		if( movie.getDate() == null )
//			errors.rejectValue("date", "error.field.empty");

	}

}
