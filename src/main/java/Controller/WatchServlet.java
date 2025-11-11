package Controller;

import model.Video;
import model.WatchListItem;
import model.Series;
import model.Server;
import model.Movie;
import Service.WatchService;
import Service.SearchService;
import Service.WatchListService;
import java.util.List;
import java.io.IOException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;

@WebServlet("/watch")
public class WatchServlet extends HttpServlet {
    
    private WatchListService watchlistService;
    
    @Override
    public void init() {
        watchlistService = new WatchListService();
    }
    
    private Video findVideo(String videoId, HttpSession session) throws IOException {
        SearchService searchService = new SearchService(session);
        if (searchService.getCurrentResults() == null) {
            return null;
        }
        return searchService.findVideoById(Integer.parseInt(videoId));
    }
    
    private List<Server> fetchServers(Video video) {
        if (video == null) return null;
        
        try {
            WatchService watchService = new WatchService(video);
            return watchService.fetchServersForMovies();
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    private String getDefaultServer(List<Server> servers) {
        return (servers != null && !servers.isEmpty()) ? servers.get(0).getName() : null;
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String videoId = request.getParameter("videoId");
        String watchListId = request.getParameter("watchListId");
        String serverName = request.getParameter("server");
        String season = request.getParameter("season");
        String episode = request.getParameter("episode");
        
        HttpSession session = request.getSession();
        
        // Update server selection
        if (serverName != null) {
            if(watchListId != null) {
                session.setAttribute("currentServer_WatchList_" + watchListId, serverName);
                response.sendRedirect("watch?watchListId=" + watchListId);
                return;
            } else {
                session.setAttribute("currentServer_" + videoId, serverName);
            }
        }
        
        // Update season/episode selection for series
        if (season != null) {
            session.setAttribute("currentSeason_" + videoId, season);
        }
        if (episode != null) {
            session.setAttribute("currentEpisode_" + videoId, episode);
        }
        
        response.sendRedirect("watch?id=" + videoId);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String videoId = request.getParameter("id");
        String watchListId = request.getParameter("watchListId");


        if(watchListId != null) {
            // Handle access via watchlist ID
            HttpSession session = request.getSession();
            String userEmail = (String) session.getAttribute("email");
            
            if (userEmail == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            List<WatchListItem> watchlist = watchlistService.getWatchListByUserEmail(userEmail);
            WatchListItem targetItem = null;
            for (WatchListItem item : watchlist) {
                if (String.valueOf(item.getId()).equals(watchListId)) {
                    targetItem = item;
                    break;
                }
            }
            
            if (targetItem == null) {
                response.sendRedirect("watchlist");
                return;
            }
            
            Video video = new Video();
            video.setId(targetItem.getId());
            video.setLink(targetItem.getVideoLink());
            video.setTitle(targetItem.getVideoTitle());
            video.setImageUrl(targetItem.getImageUrl());
            video.setType(targetItem.getVideoType());
            video.setUplaodDate(targetItem.getVideoYear());
            video.setRating(targetItem.getVideoRating());
            video.setDescription(targetItem.getDescription());
            if ("series".equals(video.getType())) {
                Series series = new Series(video, targetItem.getNumberOfSeasons());
                request.setAttribute("video", series);
            } else if ("movie".equals(video.getType())) {
                Movie movie = new Movie(video, null, null, null, null, null);
                movie.setGenre(targetItem.getGenre());
                movie.setDuration(targetItem.getDuration());
                movie.setAgeRating(targetItem.getAgeRating());
                request.setAttribute("video", movie);
            } else {
                request.setAttribute("video", video);
            }
            List<Server> servers = fetchServers(video);
            request.setAttribute("servers", servers);
            String currentServer = (String) session.getAttribute("currentServer_WatchList_" + watchListId);
            if (currentServer == null) {
                currentServer = getDefaultServer(servers);
                if (currentServer != null) {
                    session.setAttribute("currentServer_WatchList_" + watchListId, currentServer);
                }
            }
            request.setAttribute("currentServer", currentServer);
            request.setAttribute("fromWatchList", "true");

            request.getRequestDispatcher("watch.jsp").forward(request, response);
            return;
        }


        // Handle normal video access by ID From Search
        
        HttpSession session = request.getSession();
        Video video = findVideo(videoId, session);
        
        if (video == null) {
            response.sendRedirect("search?q=");
            return;
        }
        
        boolean isSeries = video instanceof Series;
        List<Server> servers = fetchServers(video);
        
        String currentServer = (String) session.getAttribute("currentServer_" + videoId);
        if (currentServer == null) {
            currentServer = getDefaultServer(servers);
            if (currentServer != null) {
                session.setAttribute("currentServer_" + videoId, currentServer);
            }
        }
        
        if (isSeries) {
            Series series = (Series) video;
            
            String currentSeason = (String) session.getAttribute("currentSeason_" + videoId);
            if (currentSeason == null) {
                currentSeason = "1";
                session.setAttribute("currentSeason_" + videoId, currentSeason);
            }
            
            String currentEpisode = (String) session.getAttribute("currentEpisode_" + videoId);
            if (currentEpisode == null) {
                currentEpisode = "1";
                session.setAttribute("currentEpisode_" + videoId, currentEpisode);
            }
            
            request.setAttribute("currentSeason", currentSeason);
            request.setAttribute("currentEpisode", currentEpisode);
            request.setAttribute("series", series);
        }
        
        // Set common attributes
        request.setAttribute("video", video);
        request.setAttribute("servers", servers);
        request.setAttribute("currentServer", currentServer);
        
        request.getRequestDispatcher("watch.jsp").forward(request, response);
    }
    
}
