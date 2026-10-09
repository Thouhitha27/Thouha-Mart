package com.thouhamart.service;

import com.thouhamart.dao.ProductDAO;
import com.thouhamart.model.Product;

import java.math.BigDecimal;
import java.util.List;

public class ProductService {

    private final ProductDAO productDAO;

    public ProductService(ProductDAO productDAO) {
        this.productDAO = productDAO;
    }

    public List<Product> getActiveProducts() {
        return productDAO.findActiveProducts();
    }

    public List<Product> searchActiveProducts(String keyword) {

        if (keyword == null || keyword.isBlank()) {
            return getActiveProducts();
        }

        String cleanedKeyword = keyword.trim();

        if (cleanedKeyword.length() > 100) {
            cleanedKeyword = cleanedKeyword.substring(0, 100);
        }

        return productDAO.searchActiveProducts(cleanedKeyword);
    }

    public List<Product> getProductsBySeller(int sellerId) {

        if (sellerId <= 0) {
            return List.of();
        }

        return productDAO.findProductsBySeller(sellerId);
    }

    public Product getProductById(int id) {

        if (id <= 0) {
            return null;
        }

        return productDAO.findById(id);
    }

    public boolean addProduct(
            int sellerId,
            int categoryId,
            String name,
            String description,
            BigDecimal price,
            int stock,
            String imageUrl
    ) {

        if (sellerId <= 0 || categoryId <= 0) {
            return false;
        }

        if (name == null || name.isBlank()) {
            return false;
        }

        if (name.trim().length() > 150) {
            return false;
        }

        if (price == null ||
                price.compareTo(BigDecimal.ZERO) <= 0) {
            return false;
        }

        if (stock < 0) {
            return false;
        }

        Product product = new Product();

        product.setSellerId(sellerId);
        product.setCategoryId(categoryId);
        product.setName(name.trim());
        product.setDescription(
                description == null ? "" : description.trim()
        );
        product.setPrice(price);
        product.setStock(stock);
        product.setImageUrl(
                imageUrl == null ? "" : imageUrl.trim()
        );
        product.setStatus("ACTIVE");

        return productDAO.save(product);
    }
}