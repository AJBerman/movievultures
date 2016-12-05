package movievultures.model.dao;

import java.util.List;

import movievultures.model.User;

public interface UserDao {
	User getUser(int id);
	User getUserByUsername(String username);
	List<User> getUsersByUsername(String username);
	User saveUser(User user);
	List<User> getUsers();
	List<User> getUsersByUsernames(String username);
	
	//new code
	User existingUser(String userName, String email);
}
