package controller;

import Model.Video;
import Model.WatchListItem;
import Service.SearchService;
import Service.WatchListService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;

<<<<<<<< HEAD:src/main/java/Controller/WatchListServlet.java
@WebServlet("/watchlist")
public class WatchListServlet extends HttpServlet {
    private WatchListService watchlistService = new WatchListService();
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");
        
        if (userEmail == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        List<WatchListItem> watchlist = watchlistService.getWatchListByUserEmail(userEmail);
        
        // Apply filtering
        String filter = request.getParameter("filter");
        if (filter != null && !filter.isEmpty()) {
            watchlist = applyFilter(watchlist, filter);
        }
        
        // Apply sorting
        String sort = request.getParameter("sort");
        if (sort != null && !sort.isEmpty()) {
            watchlist = applySorting(watchlist, sort);
        }
        
        request.setAttribute("watchlistItems", watchlist);
        request.getRequestDispatcher("/watchlist.jsp").forward(request, response);
    }
    
    private List<WatchListItem> applyFilter(List<WatchListItem> watchlist, String filter) {
        switch (filter.toLowerCase()) {
            case "movies":
                watchlist.removeIf(item -> "series".equalsIgnoreCase(item.getVideoType()));
                break;
            case "series":
                watchlist.removeIf(item -> !"series".equalsIgnoreCase(item.getVideoType()));
                break;
            case "unwatched":
                watchlist.removeIf(item -> item.isWatched());
                break;
            case "all":
            default:
                // Return all items
                break;
        }
        return watchlist;
    }
    
    private List<WatchListItem> applySorting(List<WatchListItem> watchlist, String sort) {
        switch (sort.toLowerCase()) {
            case "title":
                watchlist.sort((a, b) -> {
                    String titleA = a.getVideoTitle() != null ? a.getVideoTitle() : "";
                    String titleB = b.getVideoTitle() != null ? b.getVideoTitle() : "";
                    return titleA.compareToIgnoreCase(titleB);
                });
                break;
            case "rating":
                watchlist.sort((a, b) -> {
                    Double ratingA = a.getVideoRating() != null ? Double.parseDouble(a.getVideoRating().toString()) : 0.0;
                    Double ratingB = b.getVideoRating() != null ? Double.parseDouble(b.getVideoRating().toString()) : 0.0;
                    return ratingB.compareTo(ratingA); // Descending order
                });
                break;
            case "year":
                watchlist.sort((a, b) -> {
                    Integer yearA = a.getVideoYear() != null ? Integer.parseInt(a.getVideoYear().toString()) : 0;
                    Integer yearB = b.getVideoYear() != null ? Integer.parseInt(b.getVideoYear().toString()) : 0;
                    return yearB.compareTo(yearA); // Descending order
                });
                break;
            case "recent":
            default:
                watchlist.sort((a, b) -> {
                    if (a.getAddedDate() == null && b.getAddedDate() == null) return 0;
                    if (a.getAddedDate() == null) return 1;
                    if (b.getAddedDate() == null) return -1;
                    return b.getAddedDate().compareTo(a.getAddedDate()); // Most recent first
                });
                break;
        }
        return watchlist;
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");
        
        if (userEmail == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String action = request.getParameter("action");
        String videoId = request.getParameter("videoId");
        
        if ("add".equals(action)) {
            SearchService searchService = new SearchService(session);
            if (searchService.getCurrentResults() == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            }
            Video video = searchService.findVideoById(Integer.parseInt(videoId));
            if(video != null){
                watchlistService.addItemToWatchList(userEmail, video);
            }
        } else if ("remove".equals(action)) {
            watchlistService.removeItemFromWatchList(userEmail, Integer.parseInt(videoId));
        }
        
        response.sendRedirect("watchlist");
    }
}
========
@WebServlet("/watch")
public class WatchController extends HttpServlet{

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("watch.jsp");
        dispatcher.forward(request, response);
    }
}
>>>>>>>> 2819776 (account + watchlist pages & login session added):src/main/java/Controller/WatchController.java
