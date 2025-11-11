package model;

import java.util.List;

public class Season extends Series {
    private int seasonNumber;
    private int numberOfEpisodes;
    private List<Episode> episodes;

    public Season() {
        super();
    }

    public Season(int id, String title, String description, String rating, String imageUrl, String link, String type, String uplaodDate, int numberOfSeasons, int seasonNumber, int numberOfEpisodes) {
        super(id, title, description, rating, imageUrl, link, type, uplaodDate, numberOfSeasons);
        this.seasonNumber = seasonNumber;
        this.numberOfEpisodes = numberOfEpisodes;
    }

    public int getSeasonNumber() {
        return seasonNumber;
    }
    public void setSeasonNumber(int seasonNumber) {
        this.seasonNumber = seasonNumber;
    }

    public int getNumberOfEpisodes() {
        return numberOfEpisodes;
    }
    public void setNumberOfEpisodes(int numberOfEpisodes) {
        this.numberOfEpisodes = numberOfEpisodes;
    }

    public List<Episode> getEpisodes() {
        return episodes;
    }
    public void setEpisodes(List<Episode> episodes) {
        this.episodes = episodes;
    }

    public String getSeasonInfo() {
        return "Season " + seasonNumber + ": " + getTitle() + ", Number of Episodes: " + numberOfEpisodes;
    }
    
}
