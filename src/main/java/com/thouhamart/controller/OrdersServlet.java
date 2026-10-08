package com.thouhamart.controller;

import com.thouhamart.dao.OrderDAOImpl;
import com.thouhamart.service.OrderService;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() throws ServletException {

        HikariDataSource dataSource =
                (HikariDataSource) getServletContext()
                        .getAttribute("dataSource");

        if (dataSource == null) {
            throw new ServletException(
                    "Database connection pool is not available.");
        }

        OrderDAOImpl orderDAO =
                new OrderDAOImpl(dataSource);

        orderService =
                new OrderService(orderDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login");

            return;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"BUYER".equals(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only buyers can view orders.");

            return;
        }

        int buyerId =
                (Integer) session.getAttribute("userId");

        request.setAttribute(
                "orders",
                orderService.getBuyerOrders(buyerId));

        request.getRequestDispatcher(
                "/WEB-INF/views/orders.jsp")
                .forward(request, response);
    }
}