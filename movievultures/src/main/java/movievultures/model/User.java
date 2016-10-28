package movievultures.model;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
@Entity
@Table(name="users")

public class User implements UserDetails {

	private static final long serialVersionUID = 1L;
	
	@Id
	@TableGenerator(name = "EVENT_GEN",
            table = "SEQUENCES",
            pkColumnName = "SEQ_NAME",
            valueColumnName = "SEQ_NUMBER",
            pkColumnValue = "SEQUENCE",
            allocationSize=1)
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "EVENT_GEN")
	private int userId;
	@Column(unique=true, nullable=false)
	private String username;
	private String password;
	private String email;
	@Column(columnDefinition = "boolean default true")
	private boolean enabled = true;
	@OneToMany(mappedBy="user",
			cascade=CascadeType.ALL)
	private List<Review> reviewedMovies;
	@ManyToMany(cascade=CascadeType.ALL)
	@JoinTable(name="recommendations",
	joinColumns={@JoinColumn(name="userId")},
	inverseJoinColumns={@JoinColumn(name="movieId")})
	private List<Movie> recommendations;
	@ManyToMany(cascade=CascadeType.ALL)
	@JoinTable(name="favorites",
	joinColumns={@JoinColumn(name="userId")},
	inverseJoinColumns={@JoinColumn(name="movieId")})
	private List<Movie> favorites;
	@ManyToMany(cascade=CascadeType.ALL)
	@JoinTable(name="watchLater",
	joinColumns={@JoinColumn(name="userId")},
	inverseJoinColumns={@JoinColumn(name="movieId")})
	private List<Movie> watchLater;
	//authorities!
    @ElementCollection
    @CollectionTable(name = "authorities",
        joinColumns = @JoinColumn(name = "userid"))
    @Column(name = "authority")
    private Set<String> roles;
    
	public Set<String> getRoles() {
		return roles;
	}
	public void setRoles(Set<String> roles) {
		this.roles = roles;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
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
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
        for( String role : roles )
            authorities.add( new SimpleGrantedAuthority( role ) );
        return authorities;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	
}
