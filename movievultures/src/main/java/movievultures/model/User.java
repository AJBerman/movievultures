package movievultures.model;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
@Entity
@Table(name="users")
public class User {

	@Id
	private String username;
	private String password;
	private String email;
	@OneToMany(mappedBy="user")
	private List<Review> reviewedMovies;
	@ManyToMany
	@JoinTable(name="recommendations",
	joinColumns={@JoinColumn(name="username")},
	inverseJoinColumns={@JoinColumn(name="id")})
	private List<Movie> recommendations;
	@ManyToMany
	@JoinTable(name="favorites",
	joinColumns={@JoinColumn(name="username")},
	inverseJoinColumns={@JoinColumn(name="id")})
	private List<Movie> favorites;
	@ManyToMany
	@JoinTable(name="watchLater",
	joinColumns={@JoinColumn(name="username")},
	inverseJoinColumns={@JoinColumn(name="id")})
	private List<Movie> watchLater;
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public List<Review> getReviewedMovies() {
		return reviewedMovies;
	}
	public void setReviewedMovies(List<Review> reviewedMovies) {
		this.reviewedMovies = reviewedMovies;
	}
	public List<Movie> getRecommendations() {
		return recommendations;
	}
	public void setRecommendations(List<Movie> recommendations) {
		this.recommendations = recommendations;
	}
	public List<Movie> getFavorites() {
		return favorites;
	}
	public void setFavorites(List<Movie> favorites) {
		this.favorites = favorites;
	}
	public List<Movie> getWatchLater() {
		return watchLater;
	}
	public void setWatchLater(List<Movie> watchLater) {
		this.watchLater = watchLater;
	}
	
}
