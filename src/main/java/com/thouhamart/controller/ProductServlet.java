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

        List<Product> products =
                productService.getActiveProducts();

        request.setAttribute("products", products);

        request.getRequestDispatcher(
                "/WEB-INF/views/products.jsp"
        ).forward(request, response);
    }
}