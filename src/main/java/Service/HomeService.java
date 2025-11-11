package Service;

import model.Home;
import model.Video;

import java.util.ArrayList;
import java.util.List;

public class HomeService {

    public Home getHomeData(){
        Home home = new Home();
        home.setTrendings(getTrendingVideos());
        home.setVideos(getSeriesVideos());
        home.setFeatures(getNewReleases());

        return home;
    }
    private List<Video> getTrendingVideos(){
        List<Video> videos = new ArrayList<Video>();
        videos.add(new Video(1,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(1,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(1,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(1,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(1,"The Last of Us", "2023", "8.9","","","series", "2023"));

        return videos;
    }
    private List<Video> getSeriesVideos(){
        List<Video> videos = new ArrayList<Video>();
        videos.add(new Video(1,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(2,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(3,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(4,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(5,"The Last of Us", "2023", "8.9","","","series", "2023"));

        return videos;
    }
    private List<Video> getNewReleases(){
        List<Video> videos = new ArrayList<Video>();
        videos.add(new Video(1,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(2,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(3,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(4,"The Last of Us", "2023", "8.9","","","series", "2023"));
        videos.add(new Video(5,"The Last of Us", "2023", "8.9","","","series", "2023"));
        return videos;
    }
}
