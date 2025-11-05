package Controller;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

import Model.Movie;

import java.util.List;

import Dao.MovieDao;

import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        
        List<Movie> trendingMovies = MovieDao.getTrendingMovies();
        List<Movie> recommendedMovies = MovieDao.getRecommendedMovies();

        request.setAttribute("trendingMovies", trendingMovies);
        request.setAttribute("recommendedMovies", recommendedMovies);

        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);

    }
}