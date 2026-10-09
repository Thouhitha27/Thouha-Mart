package com.thouhamart.dao;

import com.thouhamart.model.Product;

import java.util.List;

public interface ProductDAO {

    // Get all active products
    List<Product> findActiveProducts();

    // Search active products by name or description
    List<Product> searchActiveProducts(String keyword);

    // Get products belonging to a particular seller
    List<Product> findProductsBySeller(int sellerId);

    // Find a product using its ID
    Product findById(int id);

    // Save a new product
    boolean save(Product product);
}