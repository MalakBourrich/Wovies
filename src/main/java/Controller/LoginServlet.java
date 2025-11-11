package Controller;

import Service.AccountService;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import model.Account;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AccountService accountService ;

    @Override
    public void init() throws ServletException {
        try {
            accountService = new AccountService();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        if (request.getParameter("succes") != null) {
            request.setAttribute("succes","Account created successfully");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Account account = accountService.login(email, password);


        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("email", account.getEmail());
            session.setAttribute("account", account);
            session.setAttribute("userId", account.getId_user());
            response.sendRedirect("home");
        } else {
            request.setAttribute("error", "Invalid email or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }

}