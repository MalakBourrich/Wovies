package Controller;

import Service.SearchService;
import Service.HistoryListService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.http.*;
import model.Video;
import model.HistoryItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    private HistoryListService historyListService = new HistoryListService();
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");
        
        if (userEmail == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        List<HistoryItem> history = historyListService.getHistoryByUserEmail(userEmail);
        
        // Apply filtering
        String filter = request.getParameter("filter");
        if (filter != null && !filter.isEmpty()) {
            history = applyFilter(history, filter);
        }
        
        // Apply sorting
        String sort = request.getParameter("sort");
        if (sort != null && !sort.isEmpty()) {
            history = applySorting(history, sort);
        }
        
        request.setAttribute("historyItems", history);
        request.getRequestDispatcher("/history.jsp").forward(request, response);
    }
    
    private List<HistoryItem> applyFilter(List<HistoryItem> history, String filter) {
        switch (filter.toLowerCase()) {
            case "movies":
                history.removeIf(item -> "series".equalsIgnoreCase(item.getVideoType()));
                break;
            case "series":
                history.removeIf(item -> !"series".equalsIgnoreCase(item.getVideoType()));
                break;
            case "unwatched":
                history.removeIf(item -> item.isWatched());
                break;
            case "all":
            default:
                // Return all items
                break;
        }
        return history;
    }
    
    private List<HistoryItem> applySorting(List<HistoryItem> history, String sort) {
        switch (sort.toLowerCase()) {
            case "title":
                history.sort((a, b) -> {
                    String titleA = a.getVideoTitle() != null ? a.getVideoTitle() : "";
                    String titleB = b.getVideoTitle() != null ? b.getVideoTitle() : "";
                    return titleA.compareToIgnoreCase(titleB);
                });
                break;
            case "rating":
                history.sort((a, b) -> {
                    Double ratingA = a.getVideoRating() != null ? Double.parseDouble(a.getVideoRating().toString()) : 0.0;
                    Double ratingB = b.getVideoRating() != null ? Double.parseDouble(b.getVideoRating().toString()) : 0.0;
                    return ratingB.compareTo(ratingA); // Descending order
                });
                break;
            case "year":
                history.sort((a, b) -> {
                    Integer yearA = a.getVideoYear() != null ? Integer.parseInt(a.getVideoYear().toString()) : 0;
                    Integer yearB = b.getVideoYear() != null ? Integer.parseInt(b.getVideoYear().toString()) : 0;
                    return yearB.compareTo(yearA); // Descending order
                });
                break;
            case "recent":
            default:
                history.sort((a, b) -> {
                    if (a.getAddedDate() == null && b.getAddedDate() == null) return 0;
                    if (a.getAddedDate() == null) return 1;
                    if (b.getAddedDate() == null) return -1;
                    return b.getAddedDate().compareTo(a.getAddedDate()); // Most recent first
                });
                break;
        }
        return history;
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
                historyListService.addItemToHistory(userEmail, video);
            }
        } else if ("remove".equals(action)) {
            historyListService.removeItemFromHistory(userEmail, Integer.parseInt(videoId));
        }
        
        response.sendRedirect("history");
    }
}

