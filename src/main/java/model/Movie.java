package model;
import java.util.*;

public class Movie extends Video {
    
    private String movieUrl;
    private String director;
    private String genre;
    private String duration;
    private String ageRating;
    List<Server> servers;


    public Movie() {
        super();
    }

    public Movie(Video video, String duration, String director, String genre, String movieUrl, String ageRating) {
        super(video.getId(), video.getTitle(), video.getDescription(), video.getRating(), video.getImageUrl(), video.getLink(), video.getType(), video.getUplaodDate());
        this.duration = duration;
        this.director = director;
        this.genre = genre;
        this.movieUrl = movieUrl;
        this.ageRating = ageRating;
    }


    public void addServer(Server server){
        servers.add(server);
    }
    public List<Server> getServers(){
        return servers;
    }

    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getDirector() {
        return director;
    }
    public void setDirector(String director) {
        this.director = director;
    }

    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getMovieUrl() {
        return movieUrl;
    }
    public void setMovieUrl(String movieUrl) {
        this.movieUrl = movieUrl;
    }

    public String getAgeRating() {
        return ageRating;
    }
    public void setAgeRating(String ageRating) {
        this.ageRating = ageRating;
    }

    public String getMovieInfo() {
        return "Movie: " + getTitle() + ", Duration: " + duration + ", Director: " + director + ", Genre: " + genre + ", Movie URL: " + movieUrl;
    }
}
