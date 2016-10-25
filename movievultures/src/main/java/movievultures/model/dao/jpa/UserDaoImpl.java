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
			.setParameter("username",'%' + username + '%')
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

//	@Override
//	@Transactional
//	public void saveNewUser(String username) {
//		entityManager.createNativeQuery(
//			    "INSERT INTO authorities (username, authority) VALUES (?, ?)")
//			    .setParameter(1, username)
//			    .setParameter(2, "ROLE_USER")
//			    .executeUpdate();
//		
//	}
}
