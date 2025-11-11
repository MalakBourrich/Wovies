package Service;

import model.Account;
import tempDAO.AccountDAO;

public class AccountService {
    private  AccountDAO accountDAO;

    public AccountService() {
        this.accountDAO = new AccountDAO();
    }
    public void registerAccount(Account account) {
        if (account.getEmail() == null || account.getEmail().isEmpty()) {
            throw new IllegalArgumentException("Email cannot be empty");
        }
        accountDAO.save(account);
    }
    public Account login(String email, String password) {
        Account account = getAccountByEmail(email);
        if (account != null && account.getPassword().equals(password)) {
            return account;
        }
        return null;
    }

    public void updateAccount(Account account) {
        accountDAO.update(account);
    }
    public Account getAccountByEmail(String email) {
        return accountDAO.getByEmail(email);
    }
    public String changePassword(String email, String current, String newPassword) {
        try {
            Account account = accountDAO.getByEmail(email);
            if (account == null) {
                return "not_found";
            }
            if (!current.equals(account.getPassword())) {
                return "wrong_password";
            }
            account.setPassword(newPassword);
            accountDAO.update(account);
            return "success";
        }catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
