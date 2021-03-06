package movievultures.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import movievultures.model.User;
import movievultures.model.dao.UserDao;


@Repository
public class UserDaoImpl implements UserDao {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
	public User getUser(int id) {
        return entityManager.find( User.class, id );
	}
    
    @Override
	public User getUserByUsername(String username) {
		return entityManager
			.createQuery( "from User where username=:username", User.class )
			.setParameter("username",username)
			.getSingleResult();
	}
    
    @Override
	public List<User> getUsersByUsername(String username) {
		return entityManager
			.createQuery( "from User where username LIKE :username", User.class )
			.setParameter("username", username + '%')
			.getResultList();
	}

    @Override
    @Transactional
	public User saveUser(User user) {
        return entityManager.merge( user );
	}
    
	@Override
	public List<User> getUsers() {
		return entityManager.createQuery("from User order by id", User.class).getResultList();
	}

	@Override
	public List<User> getUsersByUsernames(String username) {
		return entityManager.createQuery("from User where lower(username) LIKE lower(:username)", User.class )
				.setParameter("username", username + '%')
				.getResultList();
	}
	
	//new code
	@Override
    public User existingUser(String username, String email) {
        try {
            User existingUser = entityManager
                    .createQuery("from User where username=:username and email=:email", User.class)
                    .setParameter("username", username)
                    .setParameter("email", email)
                    .getSingleResult();
            System.out.println("Exisitng user :: " + existingUser.getEmail());
            return existingUser;
        } catch (Exception e) {
            System.out.println("No existing user found");

        }
        return null;
    }

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getUsernames(String term) {
		return entityManager
				.createNativeQuery("select username from users where username LIKE lower(:term)")
				.setParameter("term", term + '%')
				.getResultList();
	}

	
}
