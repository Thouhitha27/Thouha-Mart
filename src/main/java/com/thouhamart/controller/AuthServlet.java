package com.thouhamart.controller;

import com.thouhamart.dao.UserDAO;
import com.thouhamart.dao.UserDAOImpl;
import com.thouhamart.model.User;
import com.thouhamart.service.AuthService;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {

    private AuthService authService;

    @Override
    public void init() throws ServletException {

        HikariDataSource dataSource =
                (HikariDataSource) getServletContext()
                        .getAttribute("dataSource");

        if (dataSource == null) {
            throw new ServletException(
                    "Database connection is not initialized."
            );
        }

        UserDAO userDAO = new UserDAOImpl(dataSource);
        authService = new AuthService(userDAO);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("register".equalsIgnoreCase(action)) {
            handleRegister(request, response);
        } else if ("login".equalsIgnoreCase(action)) {
            handleLogin(request, response);
        } else {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid authentication action."
            );
        }
    }

    private void handleRegister(HttpServletRequest request,
                                HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        boolean registered = authService.register(
                name,
                email,
                password,
                role
        );

        if (registered) {
            response.sendRedirect(
                    request.getContextPath() + "/login?registered=true"
            );
        } else {
            response.sendRedirect(
                    request.getContextPath() + "/register?error=true"
            );
        }
    }

    private void handleLogin(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = authService.login(email, password);

        if (user == null) {
            response.sendRedirect(
                    request.getContextPath() +"/login?error=true"
            );
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("loggedInUser", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole());
        session.setAttribute("userName", user.getName());

        String role = user.getRole();

        if ("ADMIN".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/admin/dashboard"
            );

        } else if ("SELLER".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath() + "/seller/dashboard"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath() + "/buyer/home"
            );
        }
    }
}
