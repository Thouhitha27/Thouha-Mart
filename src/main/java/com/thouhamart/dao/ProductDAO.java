package com.thouhamart.dao;

import com.thouhamart.model.Product;

import java.util.List;

public interface ProductDAO {

    List<Product> findActiveProducts();

    List<Product> findProductsBySeller(int sellerId);

    Product findById(int id);

    boolean save(Product product);
}