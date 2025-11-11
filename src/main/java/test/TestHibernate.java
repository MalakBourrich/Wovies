package test;

import org.hibernate.Session;
import Utility.HibernateUtil;

public class TestHibernate {
    public static void main(String[] args) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            System.out.println("✅ Hibernate session created successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
