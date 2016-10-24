package movievultures.model.dao.jpa;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import movievultures.model.Movie;
import movievultures.model.User;


@Repository
public class UserDaoImpl {
    @PersistenceContext
    private EntityManager entityManager;

	public User getUser(Long id) {
        return entityManager.find( User.class, id );
	}
	User getUserByUsername(String username) {
		return entityManager
			.createQuery( "from users where username=:username", User.class )
			.setParameter("username",username)
			.getResultList()
			.get(0);
	}
	List<User> getUsersByUsername(String username) {
		return entityManager
			.createQuery( "from users where username LIKE '%:username%'", User.class )
			.setParameter("username",username)
			.getResultList();
	}

	public User saveUser(User user) {
        return entityManager.merge( user );
	}
}
