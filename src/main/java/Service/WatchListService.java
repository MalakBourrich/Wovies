
package Service;

import java.util.List;

import DAO.WatchListDAO;
import model.Video;
import model.WatchListItem;

public class WatchListService {
    private WatchListDAO watchListDAO;

    public WatchListService() {
        this.watchListDAO = new WatchListDAO();
    }

    public List<WatchListItem> getWatchListByUserEmail(String userEmail) {
        WatchListDAO watchListDao = new WatchListDAO();
        return watchListDao.getWatchListByUserEmail(userEmail);
    }

    public void addItemToWatchList(String userEmail, Video video) {

        watchListDAO.addItem(userEmail, video);
    }

    public void removeItemFromWatchList(String userEmail,int videoId) {
        watchListDAO.removeItem(userEmail, videoId);
    }

    public boolean isInWatchList(String userEmail, String videoLink) {

        return false;
    }
}