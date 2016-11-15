package movievultures.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ColumnResult;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.EntityResult;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

@Entity
@SqlResultSetMapping(
		name="SearchResults", 
        entities={@EntityResult(entityClass=Movie.class)},
        columns={@ColumnResult(name="headline"), @ColumnResult(name="rank")}
) //This is for MovieDaoImpl.fullTextSearch
@Table(name="movies")
public class Movie {
	@Id
	@TableGenerator(name = "EVENT_GEN2",
    	table = "SEQUENCES",
    	pkColumnName = "SEQ_NAME",
    	valueColumnName = "SEQ_NUMBER",
    	pkColumnValue = "SEQ_MOVIE",
    	allocationSize=1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "EVENT_GEN2")
	private int movieId;
	private String title;
	@OneToMany(mappedBy="movie",
			cascade=CascadeType.ALL)
	private List<Review> reviews;
	private Date date;
	private double eloRating;
	////These are not included on purpose; because each EloRunoff includes another movie, 
	////querying these would effectively mean dumping the database 
    ////or at least whatever subset of it is even weakly connected by Elo Runoffs)
	////That would be bad.
	//@OneToMany(mappedBy="winner")
	//private List<EloRunoff> wonEloRunoffs;
	//@OneToMany(mappedBy="loser")
	//private List<EloRunoff> lostEloRunoffs;
	@Column(name="is_hidden", columnDefinition = "boolean default false", nullable=false)
	private boolean hidden;
	@ManyToMany
	@JoinTable(name="favorites",
	joinColumns={@JoinColumn(name="movieId")},
	inverseJoinColumns={@JoinColumn(name="userId")})
	private List<User>favoredBy;
	
	@ManyToMany(cascade=CascadeType.ALL)
	@JoinTable(name="watchLater",
	joinColumns={@JoinColumn(name="movieId")},
	inverseJoinColumns={@JoinColumn(name="userId")})
	private List<User>watchQueue;
	
	@ManyToMany(cascade=CascadeType.ALL)
	@JoinTable(name="recommendations",
	joinColumns={@JoinColumn(name="movieId")},
	inverseJoinColumns={@JoinColumn(name="userId")})
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
	private List<String> actors;
	
	@Column(columnDefinition = "text")
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
	public boolean isHidden() {
		return hidden;
	}
	public void setHidden(boolean hidden) {
		this.hidden = hidden;
	}
	public String getShortPlot() {
		return this.plot.split("\"")[3];
	}
	public String getLongPlot() {
		return this.plot.split("\"")[1];
	}

}
