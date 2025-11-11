package DAO;

import Utility.HibernateUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import model.History;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class HistoryDAO {
    public void save(History history) {
        Transaction transaction = null ;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(history);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    public  History findById(int id) {
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(History.class, id);
        }
    }
    public History findByUserId(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM History h WHERE h.account.id_user = :userId";
            Query<History> query = session.createQuery(hql, History.class);
            query.setParameter("userId", userId);
            History result = query.uniqueResult();
            if (result != null) {
                System.out.println("✅ Found history for user " + userId);
                System.out.println("✅ Videos in history: " + result.getWatched_list().size());
            } else {
                System.out.println("❌ No history found for user " + userId);
            }
            return query.uniqueResult(); // renvoie null si aucun résultat
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }



    public void update(History history) {
        Transaction transaction = null ;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(history);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    public void delete(History history) {
        Transaction transaction = null ;
        try(Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.delete(history);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    public void deleteById(int id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            History history = session.get(History.class, id);
            if (history != null) {
                session.delete(history);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
    public void deleteAllByUserId(int userId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            String hql = "DELETE FROM History h WHERE h.account.id= :userId";
            Query query = session.createQuery(hql);
            query.setParameter("userId", userId);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }
}
