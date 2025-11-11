package Controller;

import Service.HomeService;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import model.Home;


import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private HomeService homeService = new HomeService();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        Home home = homeService.getHomeData();
        request.setAttribute("home", home);

        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);

    }
}