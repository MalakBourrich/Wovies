package Controller;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.*;
import model.Account;
import Service.AccountService;

import java.io.IOException;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {
    private AccountService accountService;

    @Override
    public void init() throws ServletException {
        accountService = new AccountService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = (String) req.getSession().getAttribute("email");

        if (email == null) {
            resp.sendRedirect("login");
            return;
        }

        Account account = accountService.getAccountByEmail(email);

        req.setAttribute("account", account);
        req.getRequestDispatcher("account.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            resp.sendRedirect("login");
            return;
        }

        String email = (String) session.getAttribute("email");
        String current = req.getParameter("currentPassword");
        String newPass = req.getParameter("newPassword");

        String result = accountService.changePassword(email, current, newPass);
        resp.setContentType("text/plain");
        switch (result) {
            case "success":
                resp.getWriter().write("success");
                break;
            case "not_found" :
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                resp.getWriter().write("Account not found");
                break;
            case "wrong_password" :
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getWriter().write("Wrong password");
                break;
            default :
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.getWriter().write("failed to update password");
        }
    }
}