package Service;

import model.Home;
import DAO.HomeDAO;

public class HomeService {

    public Home getHomeData(){
        Home home = new Home();
        HomeDAO homeDAO = new HomeDAO();
        home.setFeatured(homeDAO.getFeaturedVideo());
        home.setTrendings(homeDAO.getTrendingVideos());
        home.setPopularMovies(homeDAO.getPopularMovies());
        home.setNewReleases(homeDAO.getNewReleases());

        return home;
    }
}
