package com.thouhamart.controller;

import com.thouhamart.dao.CategoryDAO;
import com.thouhamart.dao.CategoryDAOImpl;
import com.thouhamart.dao.ProductDAO;
import com.thouhamart.dao.ProductDAOImpl;
import com.thouhamart.model.Category;
import com.thouhamart.service.CategoryService;
import com.thouhamart.service.ProductService;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/seller/products/add")
public class SellerProductServlet extends HttpServlet {

    private CategoryService categoryService;
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

        CategoryDAO categoryDAO =
                new CategoryDAOImpl(dataSource);

        categoryService =
                new CategoryService(categoryDAO);

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

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"SELLER".equals(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only sellers can add products."
            );

            return;
        }

        loadCategories(request);

        request.getRequestDispatcher(
                "/WEB-INF/views/seller-add-product.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"SELLER".equals(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only sellers can add products."
            );

            return;
        }

        int sellerId =
                (Integer) session.getAttribute("userId");

        try {

            String name =
                    request.getParameter("name");

            String description =
                    request.getParameter("description");

            String categoryValue =
                    request.getParameter("categoryId");

            String priceValue =
                    request.getParameter("price");

            String stockValue =
                    request.getParameter("stock");

            String imageUrl =
                    request.getParameter("imageUrl");

            int categoryId =
                    Integer.parseInt(categoryValue);

            BigDecimal price =
                    new BigDecimal(priceValue);

            int stock =
                    Integer.parseInt(stockValue);

            boolean saved =
                    productService.addProduct(
                            sellerId,
                            categoryId,
                            name,
                            description,
                            price,
                            stock,
                            imageUrl
                    );

            if (saved) {

                response.sendRedirect(
                        request.getContextPath()
                                + "/products?added=true"
                );

                return;
            }

            request.setAttribute(
                    "error",
                    "Please enter valid product details."
            );

        } catch (NumberFormatException e) {

            request.setAttribute(
                    "error",
                    "Please enter valid numbers for price, stock and category."
            );

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Unable to add product. Please try again."
            );
        }

        loadCategories(request);

        request.getRequestDispatcher(
                "/WEB-INF/views/seller-add-product.jsp"
        ).forward(request, response);
    }

    private void loadCategories(HttpServletRequest request) {

        List<Category> categories =
                categoryService.getAllCategories();

        request.setAttribute(
                "categories",
                categories
        );
    }
}