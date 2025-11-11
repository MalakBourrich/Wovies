package controller;

import Model.Video;
import Service.SearchService;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException, ServletException {

        String query = req.getParameter("q");
        String filterType = req.getParameter("filter");
        
        if (query == null || query.isEmpty()) {
            req.setAttribute("error", "Missing search query.");
            req.getRequestDispatcher("/search.jsp").forward(req, resp);
            return;
        }

        try {
            SearchService searchService = new SearchService(req.getSession());
            List<Video> results = searchService.search(query, filterType);
            
            if (results.isEmpty()) {
                req.setAttribute("error", "No results found");
            }

            // Pass both the results and the service to the view
            req.setAttribute("searchResults", results);
            req.setAttribute("searchService", searchService);
            req.getRequestDispatcher("/search.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error fetching data");
            req.getRequestDispatcher("/search.jsp").forward(req, resp);
        }
    }
}
