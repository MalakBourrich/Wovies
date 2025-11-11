package Model;

public class Episode extends Season{
    private int episodeNumber;
    private String duration;

    public Episode() {
        super();
    }

    public Episode(int id, String title, String description, String rating, String imageUrl, String link, String type, String uplaodDate, int numberOfSeasons, int seasonNumber, int numberOfEpisodes, int episodeNumber, String duration) {
        super(id, title, description, rating, imageUrl, link, type, uplaodDate, numberOfSeasons, seasonNumber, numberOfEpisodes);
        this.episodeNumber = episodeNumber;
        this.duration = duration;
    }

    public int getEpisodeNumber() {
        return episodeNumber;
    }
    public void setEpisodeNumber(int episodeNumber) {
        this.episodeNumber = episodeNumber;
    }

    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getEpisodeInfo() {
        return "Episode " + episodeNumber + ": " + getTitle() + ", Duration: " + duration;
    }
    
}
