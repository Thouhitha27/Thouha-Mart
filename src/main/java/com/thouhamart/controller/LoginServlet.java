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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
private AuthService authService;

@Override
public void init() throws ServletException {

    Object dataSourceObject =
            getServletContext().getAttribute("dataSource");

    if (!(dataSourceObject instanceof HikariDataSource)) {
        throw new ServletException(
                "HikariDataSource not found in ServletContext. " +
                "Check DatabaseListener configuration."
        );
    }

    HikariDataSource dataSource =
            (HikariDataSource) dataSourceObject;

    UserDAO userDAO = new UserDAOImpl(dataSource);

    authService = new AuthService(userDAO);
}

@Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response)
        throws ServletException, IOException {

    request.getRequestDispatcher("/WEB-INF/views/login.jsp")
           .forward(request, response);
}

@Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email == null || email.isBlank()
            || password == null || password.isBlank()) {

        request.setAttribute(
                "error",
                "Please enter your email and password."
        );

        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
               .forward(request, response);
        return;
    }

    try {

        User user = authService.login(email.trim(), password);

        if (user == null) {
            request.setAttribute(
                    "error",
                    "Invalid email or password."
            );

            request.getRequestDispatcher("/WEB-INF/views/login.jsp")
                   .forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);

        // Prevent session fixation after successful authentication.
        request.changeSessionId();

        session.setAttribute("user", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole());

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

    } catch (Exception e) {

        log("Login processing failed.", e);

        request.setAttribute(
                "error",
                "Login failed because of a server problem. Please try again."
        );

        request.getRequestDispatcher("/WEB-INF/views/login.jsp")
               .forward(request, response);
    }
}


}
