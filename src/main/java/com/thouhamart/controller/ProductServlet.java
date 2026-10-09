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

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    private ProductService productService;

    @Override
    public void init() throws ServletException {

        Object dataSourceObject =
                getServletContext().getAttribute("dataSource");

        if (!(dataSourceObject instanceof HikariDataSource)) {
            throw new ServletException(
                    "Database connection is not initialized. "
                            + "Check DatabaseListener.java."
            );
        }

        HikariDataSource dataSource =
                (HikariDataSource) dataSourceObject;

        ProductDAO productDAO =
                new ProductDAOImpl(dataSource);

        productService =
                new ProductService(productDAO);
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {

            // Read the optional search keyword.
            String search = request.getParameter("search");

            // Load active products.
            List<Product> products =
                    productService.getActiveProducts();

            // Pass products and search information to the JSP.
            request.setAttribute("products", products);
            request.setAttribute("search", search);

            request.getRequestDispatcher(
                    "/WEB-INF/views/products.jsp"
            ).forward(request, response);

        } catch (Exception e) {

            log("Unable to load product listing.", e);

            if (!response.isCommitted()) {
                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Unable to load products. Please try again later."
                );
            }
        }
    }
}