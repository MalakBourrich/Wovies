package model;

import Service.HistoryService;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "account")
public class Account {
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private int id_user;
    @Column (nullable = false)
    private String firstName;
    @Column (nullable = false)
    private String lastName;
    @Column (nullable = false)
    private String email;
    @Column (nullable = false)
    private String password;
    //@OneToOne
    //@JoinColumn (name = "id_watch")
    //private WatchList watchList;
    @OneToOne
    @JoinColumn (name = "id_history")
    private History history;

    public Account() {}
    public Account(int id_user, String firstName, String lastName, String email, String password) {
        this.id_user = id_user;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
    }
    public int getId_user() {
        return id_user;
    }
    public void setId_user(int id_user) {
        this.id_user = id_user;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
   public void getWatchList() {
   }
   //public History getHistory() {
     //   History history = getHistoryBy
   //}



}
