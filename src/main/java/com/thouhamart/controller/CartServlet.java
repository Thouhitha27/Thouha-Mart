package com.thouhamart.controller;

import com.thouhamart.dao.CartDAO;
import com.thouhamart.dao.CartDAOImpl;
import com.thouhamart.model.CartItem;
import com.thouhamart.service.CartService;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart/*")
public class CartServlet extends HttpServlet {

    private CartService cartService;

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

        CartDAO cartDAO =
                new CartDAOImpl(dataSource);

        cartService =
                new CartService(cartDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null || userId <= 0) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        List<CartItem> cartItems =
                cartService.getCartItems(userId);

        request.setAttribute(
                "cartItems",
                cartItems
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/cart.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        Integer userId =
                (Integer) session.getAttribute("userId");

        if (userId == null || userId <= 0) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        String path =
                request.getPathInfo();

        if (path == null) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart request."
            );
            return;
        }

        if ("/add".equals(path)) {

            addToCart(request, response, userId);

        } else if ("/remove".equals(path)) {

            removeFromCart(request, response, userId);

        } else if ("/update".equals(path)) {

            updateQuantity(request, response, userId);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Cart action not found."
            );
        }
    }

    private void addToCart(HttpServletRequest request,
                           HttpServletResponse response,
                           int userId)
            throws IOException {

        try {

            int productId =
                    Integer.parseInt(
                            request.getParameter("productId")
                    );

            int quantity =
                    Integer.parseInt(
                            request.getParameter("quantity")
                    );

            boolean added =
                    cartService.addToCart(
                            userId,
                            productId,
                            quantity
                    );

            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/cart"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/products?cartError=true"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/products?cartError=true"
            );
        }
    }

    private void removeFromCart(
            HttpServletRequest request,
            HttpServletResponse response,
            int userId)
            throws IOException {

        try {

            int productId =
                    Integer.parseInt(
                            request.getParameter("productId")
                    );

            cartService.removeFromCart(
                    userId,
                    productId
            );

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );
        }
    }

    private void updateQuantity(
            HttpServletRequest request,
            HttpServletResponse response,
            int userId)
            throws IOException {

        try {

            int productId =
                    Integer.parseInt(
                            request.getParameter("productId")
                    );

            int quantity =
                    Integer.parseInt(
                            request.getParameter("quantity")
                    );

            if (quantity <= 0) {

                cartService.removeFromCart(
                        userId,
                        productId
                );

            } else {

                cartService.updateQuantity(
                        userId,
                        productId,
                        quantity
                );
            }

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );
        }
    }
}