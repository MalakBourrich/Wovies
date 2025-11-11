package Model;

import java.util.List;

public class Series extends Video {

    private int numberOfSeasons;
    private List<Season> seasons;

    public Series() {
        super();
    }
    public Series(Video video, int numberOfSeasons) {
        super(video.getId(), video.getTitle(), video.getDescription(), video.getRating(), video.getImageUrl(), video.getLink(), video.getType(), video.getUplaodDate());
        this.numberOfSeasons = numberOfSeasons;
    }
    public Series(int id, String title, String description, String rating, String imageUrl, String link, String type, String uplaodDate, int numberOfSeasons) {
        super(id, title, description, rating, imageUrl, link, type, uplaodDate);
        this.numberOfSeasons = numberOfSeasons;
    }

    public int getNumberOfSeasons() {
        return numberOfSeasons;
    }
    public void setNumberOfSeasons(int numberOfSeasons) {
        this.numberOfSeasons = numberOfSeasons;
    }

    public List<Season> getSeasons() {
        return seasons;
    }
    public void addSeason(Season season) {
        this.seasons.add(season);
    }

    public String getSeriesInfo() {
        return "Series: " + getTitle() + ", Number of Seasons: " + numberOfSeasons;
    }

    
}
