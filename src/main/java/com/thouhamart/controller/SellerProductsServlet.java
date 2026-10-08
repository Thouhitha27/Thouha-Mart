package com.thouhamart.controller;

import com.thouhamart.dao.ProductDAO;
import com.thouhamart.dao.ProductDAOImpl;
import com.thouhamart.service.ProductService;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/seller/products")
public class SellerProductsServlet extends HttpServlet {

    private ProductService productService;

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

        ProductDAO productDAO =
                new ProductDAOImpl(dataSource);

        productService =
                new ProductService(productDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // Check login
        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        // Check seller role
        String role =
                (String) session.getAttribute("userRole");

        if (!"SELLER".equals(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only sellers can access their products."
            );

            return;
        }

        // Get seller ID
        int sellerId =
                (Integer) session.getAttribute("userId");

        try {

            // Load seller's products
            request.setAttribute(
                    "products",
                    productService.getProductsBySeller(sellerId)
            );

            // Open seller products page
            request.getRequestDispatcher(
                    "/WEB-INF/views/seller-products.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to load your products."
            );

            request.getRequestDispatcher(
                    "/WEB-INF/views/seller-products.jsp"
            ).forward(request, response);
        }
    }
}