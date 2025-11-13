package DAO;

import model.Home;

import java.util.List;
import org.hibernate.Session;

import Utility.HibernateUtil;

public class HomeDAO {
    public HomeDAO(){
    }
    
    public Home getFeaturedVideo() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Home featured = session.createQuery("FROM Home WHERE role = 'featured'", Home.class)
                .setMaxResults(1)
                .uniqueResult();
        session.close();
        return featured;
    }
    public List<Home> getTrendingVideos() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<Home> trendings = session.createQuery("FROM Home WHERE role = 'trending'", Home.class)
                .getResultList();
        session.close();
        return trendings;
    }
    public List<Home> getPopularMovies() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<Home> popularMovies = session.createQuery("FROM Home WHERE role = 'popular'", Home.class)
                .getResultList();
        session.close();
        return popularMovies;
    }
    public List<Home> getNewReleases() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<Home> newReleases = session.createQuery("FROM Home WHERE role = 'new_release'", Home.class)
                .getResultList();
        session.close();
        return newReleases;
    }

}
