package com.thouhamart.controller;

import com.thouhamart.dao.UserDAO;
import com.thouhamart.dao.UserDAOImpl;
import com.thouhamart.model.User;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {

        Object dataSourceObject =
                getServletContext().getAttribute("dataSource");

        if (!(dataSourceObject instanceof HikariDataSource)) {
            throw new ServletException(
                    "Database connection is not initialized."
            );
        }

        HikariDataSource dataSource =
                (HikariDataSource) dataSourceObject;

        userDAO = new UserDAOImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Authentication check
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        // Only ADMIN can access this page
        String role = (String) session.getAttribute("userRole");

        if (!"ADMIN".equalsIgnoreCase(role)) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied. Admin permission required."
            );
            return;
        }

        try {
            List<User> users = userDAO.findAllUsers();

            request.setAttribute("users", users);
            request.setAttribute("adminName",
                    session.getAttribute("userName"));

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/users.jsp"
            ).forward(request, response);

        } catch (RuntimeException e) {
            getServletContext().log(
                    "Unable to load admin user management page.", e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load users. Please try again."
            );
        }
    }
}