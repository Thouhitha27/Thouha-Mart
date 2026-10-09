package com.thouhamart.controller;

import com.thouhamart.dao.ProductDAO;
import com.thouhamart.dao.ProductDAOImpl;
import com.thouhamart.model.Product;
import com.thouhamart.service.ProductService;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductsServlet extends HttpServlet {

    private ProductService productService;

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

        ProductDAO productDAO = new ProductDAOImpl(dataSource);
        productService = new ProductService(productDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        String role = (String) session.getAttribute("userRole");

        if (!"ADMIN".equalsIgnoreCase(role)) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied. Admin permission required."
            );
            return;
        }

        try {
            List<Product> products =
                    productService.getActiveProducts();

            request.setAttribute("products", products);
            request.setAttribute("adminName",
                    session.getAttribute("userName"));

            request.getRequestDispatcher(
                    "/WEB-INF/views/admin/products.jsp"
            ).forward(request, response);

        } catch (RuntimeException e) {

            getServletContext().log(
                    "Unable to load admin products.", e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load products. Please try again."
            );
        }
    }
}