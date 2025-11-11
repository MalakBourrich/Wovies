package Service;

import DAO.AccountDAO;
import DAO.HistoryDAO;
import model.Account;
import model.History;
import model.Video;

public class HistoryService {
    private HistoryDAO historyDAO;
    public HistoryService() {
        this.historyDAO = new HistoryDAO();
    }
    public History getHistoryDAO(int id) {
        return historyDAO.findById(id);
    }
    public History getHistoryByUserId(int userId) {
        return historyDAO.findByUserId(userId);
    }

    public void addVideoToHistory(int userId, Video video) {
        History history = getHistoryByUserId(userId);
        if (history == null) {
            history = new History();
            AccountDAO accountDAO = new AccountDAO(); // You need this
            Account account = accountDAO.findById(userId);
            history.setAccount(account);
            historyDAO.save(history);
        }
        history.addVideo(video);
        historyDAO.update(history);
    }

    public void removeVideoFromHistory(int userId, int videoId) {
        History history = getHistoryByUserId(userId);
        if (history != null) {
            Video video = new Video();
            video.setId(videoId);
            history.removeVideo(video);
            historyDAO.update(history);
        }
    }

    public void clearUserHistory(int userId) {
        History history = getHistoryByUserId(userId);
        if (history != null) {
            history.clearHistory();
            historyDAO.update(history);
        }
    }
}
