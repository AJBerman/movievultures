package movievultures.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import movievultures.model.User;
import movievultures.model.dao.UserDao;


@Service("userService")
public class UserDetailsServiceImpl implements UserDetailsService{
	
    @Autowired
    private UserDao userDao;

	@Override
	public UserDetails loadUserByUsername(String username){
		User user = userDao.getUserByUsername( username );
        if( user == null )
        	return null;
        return user;
	}

}
