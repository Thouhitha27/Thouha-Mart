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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@WebServlet("/seller/products/add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 7 * 1024 * 1024
)
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
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        if (!isSeller(request, response)) {
            return;
        }

        loadCategories(request);

        request.getRequestDispatcher(
                "/WEB-INF/views/seller-add-product.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!isSeller(request, response)) {
            return;
        }

        HttpSession session = request.getSession(false);

        int sellerId =
                (Integer) session.getAttribute("userId");

        Path savedImage = null;

        try {

            String name = request.getParameter("name");
            String description =
                    request.getParameter("description");
            String categoryValue =
                    request.getParameter("categoryId");
            String priceValue =
                    request.getParameter("price");
            String stockValue =
                    request.getParameter("stock");

            if (name == null || name.trim().isEmpty()
                    || categoryValue == null
                    || priceValue == null
                    || stockValue == null) {

                throw new IllegalArgumentException(
                        "Please fill in all required product details."
                );
            }

            int categoryId =
                    Integer.parseInt(categoryValue);

            BigDecimal price =
                    new BigDecimal(priceValue);

            int stock =
                    Integer.parseInt(stockValue);

            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException(
                        "Price must be greater than zero."
                );
            }

            if (stock < 0) {
                throw new IllegalArgumentException(
                        "Stock cannot be negative."
                );
            }

            // Get the uploaded image.
            Part imagePart = request.getPart("productImage");

            if (imagePart == null
                    || imagePart.getSize() == 0) {

                throw new IllegalArgumentException(
                        "Please select a product image."
                );
            }

            if (imagePart.getSize() > 5 * 1024 * 1024) {
                throw new IllegalArgumentException(
                        "Image size must be 5 MB or less."
                );
            }

            // Validate the image type.
            String contentType = imagePart.getContentType();

            String extension;

            if ("image/jpeg".equalsIgnoreCase(contentType)) {
                extension = ".jpg";
            } else if ("image/png".equalsIgnoreCase(contentType)) {
                extension = ".png";
            } else if ("image/webp".equalsIgnoreCase(contentType)) {
                extension = ".webp";
            } else {
                throw new IllegalArgumentException(
                        "Only JPG, PNG and WEBP images are allowed."
                );
            }

            // Create a unique filename.
            String fileName =
                    UUID.randomUUID().toString() + extension;

            /*
             * Save the image inside the deployed application's
             * images directory.
             */
            String imagesDirectory =
                    getServletContext().getRealPath("/images");

            if (imagesDirectory == null) {
                throw new ServletException(
                        "Unable to locate the application's images directory."
                );
            }

            Path imageDirectory =
                    Paths.get(imagesDirectory);

            Files.createDirectories(imageDirectory);

            savedImage = imageDirectory.resolve(fileName);

            try (InputStream input =
                         imagePart.getInputStream()) {

                Files.copy(
                        input,
                        savedImage,
                        StandardCopyOption.REPLACE_EXISTING
                );
            }

            // Store a web path, not a computer filesystem path.
            String imageUrl = "images/" + fileName;

            // Save product details and image path.
            boolean saved = productService.addProduct(
                    sellerId,
                    categoryId,
                    name.trim(),
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

            // Remove the image if the product was not saved.
            Files.deleteIfExists(savedImage);

            request.setAttribute(
                    "error",
                    "Unable to add product. Please check the details."
            );

        } catch (IllegalArgumentException e) {

            request.setAttribute(
                    "error",
                    e.getMessage()
            );

        } catch (IllegalStateException e) {

            request.setAttribute(
                    "error",
                    "The uploaded file is too large. Maximum size is 5 MB."
            );

        } catch (Exception e) {

            e.printStackTrace();

            if (savedImage != null) {
                try {
                    Files.deleteIfExists(savedImage);
                } catch (IOException ignored) {
                    // Logically handled by the application server logs.
                }
            }

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

    private boolean isSeller(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login"
            );

            return false;
        }

        String role =
                (String) session.getAttribute("userRole");

        if (!"SELLER".equals(role)) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Only sellers can add products."
            );

            return false;
        }

        return true;
    }

    private void loadCategories(
            HttpServletRequest request) {

        List<Category> categories =
                categoryService.getAllCategories();

        request.setAttribute(
                "categories",
                categories
        );
    }
}