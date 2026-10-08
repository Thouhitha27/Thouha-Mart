package com.thouhamart.controller;

import com.thouhamart.dao.CartDAOImpl;
import com.thouhamart.dao.OrderDAOImpl;
import com.thouhamart.service.CartService;
import com.thouhamart.service.OrderService;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private CartService cartService;
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

        CartDAOImpl cartDAO = new CartDAOImpl(dataSource);

        OrderDAOImpl orderDAO = new OrderDAOImpl(dataSource);

        cartService = new CartService(cartDAO);

        orderService = new OrderService(orderDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

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
                    "Only buyers can checkout.");

            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        var cartItems =
                cartService.getCartItems(userId);

        if (cartItems == null || cartItems.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/cart");

            return;
        }

        request.setAttribute("cartItems", cartItems);

        request.getRequestDispatcher(
                "/WEB-INF/views/checkout.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

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
                    "Only buyers can place orders.");

            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        String shippingAddress =
                request.getParameter("shippingAddress");

        String paymentMethod =
                request.getParameter("paymentMethod");

        if (shippingAddress == null ||
                shippingAddress.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please enter your shipping address.");

            showCheckoutPage(request, response, userId);

            return;
        }

        if (paymentMethod == null ||
                paymentMethod.trim().isEmpty()) {

            paymentMethod = "COD";
        }

        var cartItems =
                cartService.getCartItems(userId);

        if (cartItems == null || cartItems.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/cart");

            return;
        }

        BigDecimal totalAmount = BigDecimal.ZERO;

        List<Integer> cartItemIds =
                new ArrayList<>();

        for (var item : cartItems) {

            totalAmount =
                    totalAmount.add(item.getSubtotal());

            cartItemIds.add(item.getId());
        }

        try {

            int orderId =
                    orderService.placeOrder(
                            userId,
                            totalAmount,
                            shippingAddress,
                            paymentMethod,
                            cartItemIds
                    );

            if (orderId > 0) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/orders");

            } else {

                request.setAttribute(
                        "error",
                        "Unable to place your order.");

                showCheckoutPage(
                        request,
                        response,
                        userId);
            }

        } catch (RuntimeException exception) {

            exception.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to place order. Please try again.");

            showCheckoutPage(
                    request,
                    response,
                    userId);
        }
    }

    private void showCheckoutPage(
            HttpServletRequest request,
            HttpServletResponse response,
            int userId)
            throws ServletException, IOException {

        var cartItems =
                cartService.getCartItems(userId);

        request.setAttribute(
                "cartItems",
                cartItems);

        request.getRequestDispatcher(
                "/WEB-INF/views/checkout.jsp")
                .forward(request, response);
    }
}