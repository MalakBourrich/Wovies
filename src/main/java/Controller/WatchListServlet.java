package Controller;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

import java.io.IOException;

<<<<<<<< HEAD:src/main/java/Controller/WatchListServlet.java
@WebServlet("/watchlist")
public class WatchListServlet extends HttpServlet{

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("watchlist.jsp");
        dispatcher.forward(request, response);
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
