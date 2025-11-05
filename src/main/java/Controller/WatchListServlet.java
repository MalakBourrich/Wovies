package Controller;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

import java.io.IOException;

@WebServlet("/watchlist")
public class WatchListServlet extends HttpServlet{

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("watchlist.jsp");
        dispatcher.forward(request, response);
    }
}