package DAO;

import Utility.HibernateUtil;
import model.Account;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class AccountDAO {
    public void save(Account account) {
        Transaction transaction = null;
        try(Session session = HibernateUtil.getSessionFactory().openSession()){
            transaction = session.beginTransaction();
            session.save(account);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }
    public Account getById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            return session.get(Account.class, id);
        }
    }
    public Account getByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Account a WHERE a.email = :email", Account.class)
                    .setParameter("email", email)
                    .uniqueResult();
        }
    }


    public void update(Account account) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(account);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    public Account findById(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Account.class, userId);
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
