package com.thouhamart.dao;

import com.thouhamart.model.Product;
import com.thouhamart.util.DBUtil;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    private final HikariDataSource dataSource;

    public ProductDAOImpl(HikariDataSource dataSource) {
        this.dataSource = dataSource;
    }

    // Get all active products
    @Override
    public List<Product> findActiveProducts() {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT id,
                       seller_id,
                       category_id,
                       name,
                       description,
                       price,
                       stock,
                       image_url,
                       status,
                       created_at,
                       updated_at
                FROM products
                WHERE status = 'ACTIVE'
                ORDER BY created_at DESC
                """;

        try (
                Connection connection =
                        DBUtil.getConnection(dataSource);
                PreparedStatement statement =
                        connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {

            while (resultSet.next()) {
                products.add(mapProduct(resultSet));
            }

        } catch (Exception e) {
            throw new RuntimeException(
                    "Error retrieving active products", e
            );
        }

        return products;
    }

    // Search active products by name or description
    @Override
    public List<Product> searchActiveProducts(String keyword) {

        List<Product> products = new ArrayList<>();

        if (keyword == null || keyword.isBlank()) {
            return findActiveProducts();
        }

        String sql = """
                SELECT id,
                       seller_id,
                       category_id,
                       name,
                       description,
                       price,
                       stock,
                       image_url,
                       status,
                       created_at,
                       updated_at
                FROM products
                WHERE status = 'ACTIVE'
                  AND (
                      name LIKE ?
                      OR description LIKE ?
                  )
                ORDER BY created_at DESC
                """;

        String searchPattern = "%" + keyword.trim() + "%";

        try (
                Connection connection =
                        DBUtil.getConnection(dataSource);
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(
                    "Error searching active products", e
            );
        }

        return products;
    }

    // Get products belonging to a particular seller
    @Override
    public List<Product> findProductsBySeller(int sellerId) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT id,
                       seller_id,
                       category_id,
                       name,
                       description,
                       price,
                       stock,
                       image_url,
                       status,
                       created_at,
                       updated_at
                FROM products
                WHERE seller_id = ?
                ORDER BY created_at DESC
                """;

        try (
                Connection connection =
                        DBUtil.getConnection(dataSource);
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, sellerId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    products.add(mapProduct(resultSet));
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(
                    "Error retrieving seller products", e
            );
        }

        return products;
    }

    // Find a product using its ID
    @Override
    public Product findById(int id) {

        String sql = """
                SELECT id,
                       seller_id,
                       category_id,
                       name,
                       description,
                       price,
                       stock,
                       image_url,
                       status,
                       created_at,
                       updated_at
                FROM products
                WHERE id = ?
                """;

        try (
                Connection connection =
                        DBUtil.getConnection(dataSource);
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapProduct(resultSet);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(
                    "Error retrieving product by ID", e
            );
        }

        return null;
    }

    // Save a new product
    @Override
    public boolean save(Product product) {

        String sql = """
                INSERT INTO products (
                    seller_id,
                    category_id,
                    name,
                    description,
                    price,
                    stock,
                    image_url,
                    status
                )
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection connection =
                        DBUtil.getConnection(dataSource);
                PreparedStatement statement =
                        connection.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            statement.setInt(1, product.getSellerId());
            statement.setInt(2, product.getCategoryId());
            statement.setString(3, product.getName());
            statement.setString(4, product.getDescription());
            statement.setBigDecimal(5, product.getPrice());
            statement.setInt(6, product.getStock());
            statement.setString(7, product.getImageUrl());
            statement.setString(8, product.getStatus());

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {

                try (ResultSet generatedKeys =
                             statement.getGeneratedKeys()) {

                    if (generatedKeys.next()) {
                        product.setId(generatedKeys.getInt(1));
                    }
                }

                return true;
            }

        } catch (Exception e) {
            throw new RuntimeException(
                    "Error saving product", e
            );
        }

        return false;
    }

    // Convert a database row into a Product object
    private Product mapProduct(ResultSet resultSet)
            throws java.sql.SQLException {

        Product product = new Product();

        product.setId(resultSet.getInt("id"));
        product.setSellerId(resultSet.getInt("seller_id"));
        product.setCategoryId(resultSet.getInt("category_id"));
        product.setName(resultSet.getString("name"));
        product.setDescription(resultSet.getString("description"));
        product.setPrice(resultSet.getBigDecimal("price"));
        product.setStock(resultSet.getInt("stock"));
        product.setImageUrl(resultSet.getString("image_url"));
        product.setStatus(resultSet.getString("status"));
        product.setCreatedAt(resultSet.getTimestamp("created_at"));
        product.setUpdatedAt(resultSet.getTimestamp("updated_at"));

        return product;
    }
}