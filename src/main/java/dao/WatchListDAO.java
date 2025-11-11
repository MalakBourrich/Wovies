package DAO;

import Util.HibernateUtil;
import model.Movie;
import model.Series;
import model.Video;
import model.WatchListItem;

import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class WatchListDAO {


    public List<WatchListItem> getWatchListByUserEmail(String userEmail) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<WatchListItem> watchlist = session.createQuery("FROM WatchListItem WHERE userEmail = :email", WatchListItem.class)
                .setParameter("email", userEmail)
                .getResultList();
        session.close();
        return watchlist;
    }
    public void addItem(String userEmail,Video video) {

        if(isInWatchList(userEmail,video)) {
            return;
        }
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        WatchListItem item = new WatchListItem();
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

        WatchListItem item = session.createQuery("FROM WatchListItem WHERE userEmail = :email AND id = :videoId", WatchListItem.class)
                .setParameter("email", userEmail)
                .setParameter("videoId", videoId)
                .uniqueResult();

        if (item != null) {
            session.delete(item);
        }

        transaction.commit();
        session.close();
    }

    public boolean isInWatchList(String userEmail,Video video) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Long count = session.createQuery("SELECT COUNT(*) FROM WatchListItem WHERE userEmail = :email AND videoLink = :videoLink", Long.class)
                .setParameter("email", userEmail)
                .setParameter("videoLink", video.getLink())
                .uniqueResult();

        session.close();
        return count != null && count > 0;
    }

    
}
