
package Service;

import model.Video;
import model.HistoryItem;

import java.util.List;

import DAO.HistoryListDAO;

public class HistoryListService {
    private HistoryListDAO historyListDAO;

    public HistoryListService() {
        this.historyListDAO = new HistoryListDAO();
    }

    public List<HistoryItem> getHistoryByUserEmail(String userEmail) {
        HistoryListDAO historyListDAO = new HistoryListDAO();
        return historyListDAO.gethistoryByUserEmail(userEmail);
    }

    public void addItemToHistory(String userEmail, Video video) {

        historyListDAO.addItem(userEmail, video);
    }

    public void removeItemFromHistory(String userEmail,int videoId) {
        historyListDAO.removeItem(userEmail, videoId);
    }

    public boolean isInHistoryList(String userEmail, Video video) {
        if(historyListDAO.isInhistory(userEmail, video)) {
            return true;
        }
        return false;
    }
}
