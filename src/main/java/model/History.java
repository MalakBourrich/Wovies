package model;

import jakarta.persistence.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.DeserializationFeature;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "history")
public class History {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_history;

    @Column(name = "watched_list", columnDefinition = "TEXT")
    private String watchedListJson;

    @OneToOne
    @JoinColumn(name = "id_user")
    private Account account;

    @Transient
    private List<Video> watched_list;


    private static final ObjectMapper mapper = new ObjectMapper()
            .setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY)
            .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

    public History() {
        this.watched_list = new ArrayList<>();
    }

    public void addVideo(Video video) {
        // Initialize if null
        if (watched_list == null) {
            watched_list = new ArrayList<>();
        }

        boolean exists = watched_list.stream()
                .anyMatch(v -> v.getId() == video.getId());

        if (!exists) {
            watched_list.add(video);
            serializeWatchedList();
        }
    }

    public void removeVideo(Video video) {
        if (watched_list != null) {
            watched_list.removeIf(v -> v.getId() == video.getId());
            serializeWatchedList();
        }
    }

    public void clearHistory() {
        if (watched_list != null) {
            watched_list.clear();
        }
        serializeWatchedList();
    }

    public List<Video> getWatched_list() {
        if (watched_list == null) {
            deserializeWatchedList();
        }
        return watched_list != null ? watched_list : new ArrayList<>();
    }

    public void setWatched_list(List<Video> watched_list) {
        this.watched_list = watched_list != null ? watched_list : new ArrayList<>();
        serializeWatchedList();
    }

    @PrePersist
    @PreUpdate
    private void serializeWatchedList() {
        try {
            if (watched_list == null) {
                this.watchedListJson = "[]";
            } else {
                this.watchedListJson = mapper.writeValueAsString(watched_list);
                System.out.println("✅ Serialized " + watched_list.size() + " videos to JSON");
            }
        } catch (Exception e) {
            e.printStackTrace();
            this.watchedListJson = "[]";
        }
    }

    @PostLoad
    private void deserializeWatchedList() {
        try {
            if (watchedListJson != null && !watchedListJson.isEmpty() && !watchedListJson.equals("[]")) {
                this.watched_list = mapper.readValue(watchedListJson, new TypeReference<List<Video>>() {});
            } else {
                this.watched_list = new ArrayList<>();
            }
        } catch (Exception e) {
            e.printStackTrace();
            this.watched_list = new ArrayList<>();
        }
    }

    public int getId_history() {
        return id_history;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

}