package movievultures.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
@Entity
@Table(name="movies")
public class Movie {
	@Id
	@GeneratedValue
	private int movieId;
	private String title;
	
	@OneToMany(mappedBy="movie",
			cascade=CascadeType.ALL)
	private List<Review> reviews;
	private Date date;
	private double eloRating;
	private int eloTimesRated;
	@Column(name="is_hidden", columnDefinition = "boolean default false", nullable=false)
	private boolean hidden;
	@ManyToMany
	@JoinTable(name="favorites",
	joinColumns={@JoinColumn(name="movieId")},
	inverseJoinColumns={@JoinColumn(name="username")})
	private List<User>favoredBy;
	
	@ManyToMany(cascade=CascadeType.ALL)
	@JoinTable(name="watchLater",
	joinColumns={@JoinColumn(name="movieId")},
	inverseJoinColumns={@JoinColumn(name="username")})
	private List<User>watchQueue;
	
	@ManyToMany(cascade=CascadeType.ALL)
	@JoinTable(name="recommendations",
	joinColumns={@JoinColumn(name="movieId")},
	inverseJoinColumns={@JoinColumn(name="username")})
	private List<User>recommendedTo;
	
	@ElementCollection
	@CollectionTable(
			name="movie_genres",
			joinColumns=@JoinColumn(name = "movieId")
			)
	@Column(name="genre")
	private List<String> genres;
	
	@ElementCollection
	@CollectionTable(
			name="movie_directors",
			joinColumns=@JoinColumn(name="movieId")
			)
	@Column(name="director")
	private List<String> directors;
	
	@ElementCollection
	@CollectionTable(
			name="movie_cast",
			joinColumns=@JoinColumn(name="movieId")
			)
	@Column(name="actor")
	private List<String>actors;
	
	@Lob //http://www.concretepage.com/hibernate/lob-hibernate-annotation
	private String plot;
	
	public int getMovieId() {
		return movieId;
	}
	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}
	public List<User> getRecommendedTo() {
		return recommendedTo;
	}
	public void setRecommendedTo(List<User> recommendedTo) {
		this.recommendedTo = recommendedTo;
	}
	public List<String> getGenres() {
		return genres;
	}
	public void setGenres(List<String> genres) {
		this.genres = genres;
	}
	public List<String> getDirectors() {
		return directors;
	}
	public void setDirectors(List<String> directors) {
		this.directors = directors;
	}
	public List<String> getActors() {
		return actors;
	}
	public void setActors(List<String> actors) {
		this.actors = actors;
	}
	public String getPlot() {
		return plot;
	}
	public void setPlot(String plot) {
		this.plot = plot;
	}
	public List<User> getFavoredBy() {
		return favoredBy;
	}
	public void setFavoredBy(List<User> favoredBy) {
		this.favoredBy = favoredBy;
	}
	public List<User> getWatchQueue() {
		return watchQueue;
	}
	public void setWatchQueue(List<User> watchQueue) {
		this.watchQueue = watchQueue;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public List<Review> getReviews() {
		return reviews;
	}
	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public double getEloRating() {
		return eloRating;
	}
	public void setEloRating(double eloRating) {
		this.eloRating = eloRating;
	}
	public int getEloTimesRated() {
		return eloTimesRated;
	}
	public void setEloTimesRated(int eloTimesRated) {
		this.eloTimesRated = eloTimesRated;
	}
	public boolean isHidden() {
		return hidden;
	}
	public void setHidden(boolean hidden) {
		this.hidden = hidden;
	}

}
