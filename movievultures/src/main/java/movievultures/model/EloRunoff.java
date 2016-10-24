package movievultures.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="elorunoffs")
public class EloRunoff {
	@Id
	@GeneratedValue
	private int runoffId;
	@ManyToOne
	private Movie winner;
	@ManyToOne
	private Movie loser;
	@ManyToOne
	private User user;
	private Date date;
	public int getRunoffId() {
		return runoffId;
	}
	public void setRunoffId(int runoffId) {
		this.runoffId = runoffId;
	}
	public Movie getWinner() {
		return winner;
	}
	public void setWinner(Movie winner) {
		this.winner = winner;
	}
	public Movie getLoser() {
		return loser;
	}
	public void setLoser(Movie loser) {
		this.loser = loser;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
}
