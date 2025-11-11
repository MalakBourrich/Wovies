package controller;

import Service.AccountService;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import model.Account;

import java.io.IOException;

@WebServlet("/sign-up")
public class SignupServlet extends HttpServlet {
    private AccountService accountService ;

    @Override
    public void init() throws ServletException {
        accountService = new AccountService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("signup.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Account newAccount = new Account();
        newAccount.setFirstName(firstName);
        newAccount.setLastName(lastName);
        newAccount.setEmail(email);
        newAccount.setPassword(password);

        try {
            accountService.registerAccount(newAccount);

            HttpSession session = req.getSession();
            session.setAttribute("email", newAccount.getEmail());
            session.setAttribute("account", newAccount);

            resp.sendRedirect(req.getContextPath() + "/home");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            RequestDispatcher dispatcher = req.getRequestDispatcher("signup.jsp");
            dispatcher.forward(req, resp);
        }


    }
}