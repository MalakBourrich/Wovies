package model;

import jakarta.persistence.*;

import java.util.List;


public class Home {

    private static List<Video> trendings;
    private static List<Video> videos;
    private static List<Video> features;


    public Home() {}


    public List<Video> getTrendings() {
        return trendings;
    }

    public void setTrendings(List<Video> trendings) {
        this.trendings = trendings;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public List<Video> getFeatures() {
        return features;
    }

    public void setFeatures(List<Video> features) {
        this.features = features;
    }

}
