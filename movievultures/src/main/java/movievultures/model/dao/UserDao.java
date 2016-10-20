package movievultures.model.dao;

import java.util.List;

import movievultures.model.User;

public interface UserDao {
	User getUser(int id);
	User getUserByUsername(String username);
	List<User> getUsersByUsername(String username);
	User saveUser(User user);
}
