package Controller;

import Service.HistoryService;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import model.History;
import model.Video;

import java.io.IOException;


@WebServlet("/history")
public class HistoryServlet extends HttpServlet {

    private HistoryService historyService = new HistoryService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }
        Integer userId = (Integer) request.getSession().getAttribute("userId");


        History history = historyService.getHistoryByUserId(userId);

        request.setAttribute("history", history);
        RequestDispatcher dispatcher = request.getRequestDispatcher("history.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("=== HistoryServlet doPost called ===");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Not authenticated");
            return;
        }
        String action = request.getParameter("action");
        int userId = (int) session.getAttribute("userId");

        if ("remove".equals(action)) {
            String videoIdStr = request.getParameter("videoId");
            if (videoIdStr == null || videoIdStr.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Video ID is required");
                return;
            }
            try {
                int videoId = Integer.parseInt(videoIdStr);
                historyService.removeVideoFromHistory(userId, videoId);
                response.setStatus(HttpServletResponse.SC_OK);
                response.setContentType("text/plain");
                response.getWriter().write("Video removed successfully");

            }catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid video ID");
            }
        } else if ("clear".equals(action)) {
            historyService.clearUserHistory(userId);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("History cleared successfully");
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Unknown action");
        }

    }
}
