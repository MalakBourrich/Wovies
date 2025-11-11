package model;

public class Movie {
    
    String title;
    String genre;
    String imageUrl;
    String description;
    double rating;
    String movieUrl;
    int releaseYear;


    public Movie() {
        
    }

    public Movie(String title, String genre, String imageUrl, String description, double rating, String movieUrl, int releaseYear) {
        this.title = title;
        this.genre = genre;
        this.imageUrl = imageUrl;
        this.description = description;
        this.rating = rating;
        this.movieUrl = movieUrl;
        this.releaseYear = releaseYear;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }
    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public double getRating() {
        return rating;
    }
    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getMovieUrl() {
        return movieUrl;
    }
    public void setMovieUrl(String movieUrl) {
        this.movieUrl = movieUrl;
    }

    public int getReleaseYear() {
        return releaseYear;
    }
    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }
    
}
