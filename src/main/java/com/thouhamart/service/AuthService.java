package com.thouhamart.service;

import com.thouhamart.dao.UserDAO;
import com.thouhamart.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class AuthService {

    private final UserDAO userDAO;

    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public boolean register(String name,
                            String email,
                            String password,
                            String role) {

        if (name == null || name.isBlank()
                || email == null || email.isBlank()
                || password == null || password.length() < 6
                || role == null || role.isBlank()) {
            return false;
        }

        email = email.trim().toLowerCase();
        role = role.trim().toUpperCase();

        if (!role.equals("BUYER")
                && !role.equals("SELLER")
                && !role.equals("ADMIN")) {
            return false;
        }

        if (userDAO.emailExists(email)) {
            return false;
        }

        String passwordHash = BCrypt.hashpw(
                password,
                BCrypt.gensalt(12)
        );

        User user = new User(
                name.trim(),
                email,
                passwordHash,
                role
        );

        return userDAO.save(user);
    }

    public User login(String email, String password) {

        if (email == null || email.isBlank()
                || password == null || password.isBlank()) {
            return null;
        }

        email = email.trim().toLowerCase();

        User user = userDAO.findByEmail(email);

        if (user == null) {
            return null;
        }

        boolean passwordMatches = BCrypt.checkpw(
                password,
                user.getPasswordHash()
        );

        return passwordMatches ? user : null;
    }
}