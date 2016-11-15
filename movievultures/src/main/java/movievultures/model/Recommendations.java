package movievultures.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="recommendations")
public class Recommendations {
	@Id
	@GeneratedValue
	private int recommId;
	@ManyToOne
	private User user;
	@ManyToOne
	private Movie movie;
	private int rank;

	public int getRecommId() {
		return recommId;
	}

	public void setRecommId(int recommId) {
		this.recommId = recommId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Movie getMovie() {
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}
}