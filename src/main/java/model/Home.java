package model;

import java.util.Date;
import java.util.List;

import jakarta.persistence.*;


@Entity@Table(name = "home_items")
public class Home {

    public Home() {
        this.addedDate = new Date();
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "video_link", nullable = false, length = 500)
    private String videoLink;
    
    @Column(name = "video_title", nullable = false)
    private String videoTitle;

    @Column(name = "role")
    private String role;
    
    @Column(name = "video_type")
    private String videoType; // "movie" or "series"
    
    @Column(name = "video_year")
    private String videoYear;
    
    @Column(name = "video_rating")
    private String videoRating;
    
    @Column(name = "image_url", length = 500)
    private String imageUrl;
    
    @Column(name = "added_date")
    private Date addedDate;

    @Column(name = "description", length = 2000)
    private String description;

    @Column(name="genre")
    private String genre;
    
    @Column(name="duration")
    private String duration;
    
    @Column(name="age_rating")
    private String ageRating;

    @Column(name = "number_of_seasons")
    private Integer numberOfSeasons;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "video_id")
    private List<Server> servers;

    @Transient
    private Home featured;
    @Transient
    private List<Home> trendings;
    @Transient
    private List<Home> popularMovies;
    @Transient
    private List<Home> newReleases;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getVideoLink() {
        return videoLink;
    }

    
    public void setVideoLink(String videoLink) {
        this.videoLink = videoLink;
    }

    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }

    public String getVideoTitle() {
        return videoTitle;
    }

    public void setVideoTitle(String videoTitle) {
        this.videoTitle = videoTitle;
    }

    public String getVideoType() {
        return videoType;
    }

    public void setVideoType(String videoType) {
        this.videoType = videoType;
    }

    public String getVideoYear() {
        return videoYear;
    }

    public void setVideoYear(String videoYear) {
        this.videoYear = videoYear;
    }

    public String getVideoRating() {
        return videoRating;
    }

    public void setVideoRating(String videoRating) {
        this.videoRating = videoRating;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getAgeRating() {
        return ageRating;
    }
    public void setAgeRating(String ageRating) {
        this.ageRating = ageRating;
    }

    public Integer getNumberOfSeasons() {
        return numberOfSeasons;
    }
    public void setNumberOfSeasons(Integer numberOfSeasons) {
        this.numberOfSeasons = numberOfSeasons;
    }

    public List<Server> getServers() {
        return servers;
    }
    public void setServers(List<Server> servers) {
        this.servers = servers;
    }
    public List<Home> getTrendings() {
        return trendings;
    }
    public void setTrendings(List<Home> trendings) {
        this.trendings = trendings;
    }

    public List<Home> getPopularMovies() {
        return popularMovies;
    }

    public void setPopularMovies(List<Home> popularMovies) {
        this.popularMovies = popularMovies;
    }

    public List<Home> getNewReleases() {
        return newReleases;
    }
    public void setNewReleases(List<Home> newReleases) {
        this.newReleases = newReleases;
    }

    public Home getFeatured() {
        return featured;
    }
    public void setFeatured(Home featured) {
        this.featured = featured;
    }
}
