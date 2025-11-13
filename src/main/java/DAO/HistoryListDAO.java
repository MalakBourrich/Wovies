package DAO;

import Utility.HibernateUtil;
import model.Movie;
import model.Series;
import model.Video;
import model.HistoryItem;

import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class HistoryListDAO {


    public List<HistoryItem> gethistoryByUserEmail(String userEmail) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<HistoryItem> history = session.createQuery("FROM HistoryItem WHERE userEmail = :email", HistoryItem.class)
                .setParameter("email", userEmail)
                .getResultList();
        session.close();
        return history;
    }
    public void addItem(String userEmail,Video video) {

        if(isInhistory(userEmail,video)) {
            return;
        }
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        HistoryItem item = new HistoryItem();
        item.setUserEmail(userEmail);
        item.setVideoTitle(video.getTitle());
        item.setVideoLink(video.getLink());
        item.setImageUrl(video.getImageUrl());
        item.setVideoType(video.getType());
        item.setVideoYear(video.getUplaodDate());
        item.setVideoRating(video.getRating());
        item.setDescription(video.getDescription());
        if(video.getType().equals("series")) {
            item.setNumberOfSeasons(((Series)video).getNumberOfSeasons());
        }else if(video.getType().equals("movie")) {
            item.setNumberOfSeasons(null);
            item.setGenre(((Movie)video).getGenre());
            item.setDuration(((Movie)video).getDuration());
            item.setAgeRating(((Movie)video).getAgeRating());
            item.setServers(((Movie)video).getServers());
        }

        session.save(item);
        transaction.commit();
        session.close();
    }

    public void removeItem(String userEmail,int videoId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        HistoryItem item = session.createQuery("FROM HistoryItem WHERE userEmail = :email AND id = :videoId", HistoryItem.class)
                .setParameter("email", userEmail)
                .setParameter("videoId", videoId)
                .uniqueResult();

        if (item != null) {
            session.delete(item);
        }

        transaction.commit();
        session.close();
    }

    public boolean isInhistory(String userEmail,Video video) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Long count = session.createQuery("SELECT COUNT(*) FROM HistoryItem WHERE userEmail = :email AND videoLink = :videoLink", Long.class)
                .setParameter("email", userEmail)
                .setParameter("videoLink", video.getLink())
                .uniqueResult();

        session.close();
        return count != null && count > 0;
    }

    
}