package com.thouhamart.controller;

import com.thouhamart.dao.OrderDAO;
import com.thouhamart.dao.OrderDAOImpl;
import com.thouhamart.model.Order;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        Object dataSourceObject =
                getServletContext().getAttribute("dataSource");

        if (!(dataSourceObject instanceof HikariDataSource)) {
            throw new ServletException(
                    "Database connection pool is unavailable."
            );
        }

        HikariDataSource dataSource =
                (HikariDataSource) dataSourceObject;

        orderDAO = new OrderDAOImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        String role = (String) session.getAttribute("userRole");

        if (!"ADMIN".equalsIgnoreCase(role)) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Admin permission required."
            );
            return;
        }

        try {
            List<Order> orders = orderDAO.findAllOrders();

            request.setAttribute("orders", orders);
            request.setAttribute(
                    "adminName",
                    session.getAttribute("userName")
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/orders.jsp"
            ).forward(request, response);

        } catch (RuntimeException e) {
            throw new ServletException(
                    "Unable to load admin orders.", e
            );
        }
    }
}