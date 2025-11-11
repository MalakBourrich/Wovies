package model;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Video {
    private int id;
    private String type;
    private String title;
    private String description;
    private String uplaodDate;
    private String rating;
    private String imageUrl;
    private String link;


    public Video() {
    }

    public Video(int id, String title, String description, String rating, String imageUrl, String link, String type, String uplaodDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.rating = rating;
        this.imageUrl = imageUrl;
        this.link = link;
        this.type = type;
        this.uplaodDate = uplaodDate;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getRating() {
        if( rating == "N/A" ){
            return "*";
        }
        return rating;
    }
    public void setRating(String rating) {
        this.rating = rating;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getLink() {
        return link;
    }
    public void setLink(String link) {
        this.link = link;
    }

    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }

    public String getUplaodDate() {
        return uplaodDate;
    }
    public void setUplaodDate(String uplaodDate) {
        this.uplaodDate = uplaodDate;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public String getDescription() {
        return description;
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Video video = (Video) o;
        return id == video.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }

    String getDetails() {
        return "Video{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", rating='" + rating + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", link='" + link + '\'' +
                ", type='" + type + '\'' +
                ", uplaodDate='" + uplaodDate + '\'' +
                ", description='" + description + '\'' +
                '}';
    }

}