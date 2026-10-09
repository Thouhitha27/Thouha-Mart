package com.thouhamart.dao;

import com.thouhamart.model.Order;
import com.thouhamart.util.DBUtil;
import com.zaxxer.hikari.HikariDataSource;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class OrderDAOImpl implements OrderDAO {

    private final HikariDataSource dataSource;

    public OrderDAOImpl(HikariDataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public int createOrder(Order order, List<Integer> cartItemIds) {

        if (order == null || cartItemIds == null || cartItemIds.isEmpty()) {
            return -1;
        }

        String orderSql = """
                INSERT INTO orders
                (buyer_id, total_amount, status, shipping_address, payment_method)
                VALUES (?, ?, ?, ?, ?)
                """;

        String cartItemsSql = """
                SELECT ci.id,
                       ci.product_id,
                       ci.quantity,
                       p.seller_id,
                       p.price,
                       p.stock
                FROM cart_items ci
                JOIN cart c ON ci.cart_id = c.id
                JOIN products p ON ci.product_id = p.id
                WHERE ci.id IN (%s)
                  AND c.buyer_id = ?
                FOR UPDATE
                """;

        String orderItemSql = """
                INSERT INTO order_items
                (order_id, product_id, seller_id, quantity, unit_price)
                VALUES (?, ?, ?, ?, ?)
                """;

        String stockSql = """
                UPDATE products
                SET stock = stock - ?
                WHERE id = ?
                  AND stock >= ?
                """;

        String deleteCartItemSql = """
                DELETE FROM cart_items
                WHERE id = ?
                """;

        String placeholders = cartItemIds.stream()
                .map(id -> "?")
                .collect(Collectors.joining(", "));

        cartItemsSql = String.format(cartItemsSql, placeholders);

        try (Connection connection = DBUtil.getConnection(dataSource)) {

            connection.setAutoCommit(false);

            try {
                int orderId;

                // 1. Create the order
                try (PreparedStatement statement =
                             connection.prepareStatement(
                                     orderSql,
                                     Statement.RETURN_GENERATED_KEYS)) {

                    statement.setInt(1, order.getBuyerId());
                    statement.setBigDecimal(2, order.getTotalAmount());
                    statement.setString(3, order.getStatus());
                    statement.setString(4, order.getShippingAddress());
                    statement.setString(5, order.getPaymentMethod());

                    statement.executeUpdate();

                    try (ResultSet keys = statement.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException("Order ID was not generated.");
                        }

                        orderId = keys.getInt(1);
                    }
                }

                // 2. Lock and validate the selected cart items
                try (PreparedStatement statement =
                             connection.prepareStatement(cartItemsSql)) {

                    int parameterIndex = 1;

                    for (Integer cartItemId : cartItemIds) {
                        if (cartItemId == null || cartItemId <= 0) {
                            throw new SQLException("Invalid cart item ID.");
                        }

                        statement.setInt(parameterIndex++, cartItemId);
                    }

                    statement.setInt(parameterIndex, order.getBuyerId());

                    try (ResultSet resultSet = statement.executeQuery()) {

                        int processedItems = 0;

                        while (resultSet.next()) {

                            int cartItemId = resultSet.getInt("id");
                            int productId = resultSet.getInt("product_id");
                            int quantity = resultSet.getInt("quantity");
                            int sellerId = resultSet.getInt("seller_id");
                            BigDecimal price =
                                    resultSet.getBigDecimal("price");
                            int stock = resultSet.getInt("stock");

                            if (quantity <= 0) {
                                throw new SQLException("Invalid cart quantity.");
                            }

                            if (price == null || price.signum() < 0) {
                                throw new SQLException("Invalid product price.");
                            }

                            if (stock < quantity) {
                                throw new SQLException(
                                        "Insufficient stock for product ID: "
                                                + productId);
                            }

                            // 3. Insert order item
                            try (PreparedStatement orderItemStatement =
                                         connection.prepareStatement(orderItemSql)) {

                                orderItemStatement.setInt(1, orderId);
                                orderItemStatement.setInt(2, productId);
                                orderItemStatement.setInt(3, sellerId);
                                orderItemStatement.setInt(4, quantity);
                                orderItemStatement.setBigDecimal(5, price);

                                orderItemStatement.executeUpdate();
                            }

                            // 4. Reduce product stock safely
                            try (PreparedStatement stockStatement =
                                         connection.prepareStatement(stockSql)) {

                                stockStatement.setInt(1, quantity);
                                stockStatement.setInt(2, productId);
                                stockStatement.setInt(3, quantity);

                                int updatedRows =
                                        stockStatement.executeUpdate();

                                if (updatedRows != 1) {
                                    throw new SQLException(
                                            "Unable to update stock for product ID: "
                                                    + productId);
                                }
                            }

                            // 5. Remove purchased cart item
                            try (PreparedStatement deleteStatement =
                                         connection.prepareStatement(
                                                 deleteCartItemSql)) {

                                deleteStatement.setInt(1, cartItemId);

                                int deletedRows =
                                        deleteStatement.executeUpdate();

                                if (deletedRows != 1) {
                                    throw new SQLException(
                                            "Unable to remove purchased cart item.");
                                }
                            }

                            processedItems++;
                        }

                        if (processedItems != cartItemIds.size()) {
                            throw new SQLException(
                                    "Some cart items are no longer available.");
                        }
                    }
                }

                connection.commit();
                return orderId;

            } catch (Exception exception) {
                connection.rollback();
                throw exception;
            }

        } catch (Exception exception) {
            throw new RuntimeException("Error creating order", exception);
        }
    }

    @Override
    public List<Order> findOrdersByBuyer(int buyerId) {

        List<Order> orders = new ArrayList<>();

        String sql = """
                SELECT id, buyer_id, total_amount, status,
                       shipping_address, payment_method,
                       created_at, updated_at
                FROM orders
                WHERE buyer_id = ?
                ORDER BY created_at DESC
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, buyerId);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    orders.add(mapOrder(resultSet));
                }
            }

        } catch (SQLException exception) {
            throw new RuntimeException(
                    "Error fetching buyer orders", exception);
        }

        return orders;
    }

    @Override
    public Order findById(int orderId, int buyerId) {

        String sql = """
                SELECT id, buyer_id, total_amount, status,
                       shipping_address, payment_method,
                       created_at, updated_at
                FROM orders
                WHERE id = ?
                  AND buyer_id = ?
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, orderId);
            statement.setInt(2, buyerId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapOrder(resultSet);
                }
            }

        } catch (SQLException exception) {
            throw new RuntimeException("Error fetching order", exception);
        }

        return null;
    }

    // Admin: retrieve all customer orders
    @Override
    public List<Order> findAllOrders() {

        List<Order> orders = new ArrayList<>();

        String sql = """
                SELECT id, buyer_id, total_amount, status,
                       shipping_address, payment_method,
                       created_at, updated_at
                FROM orders
                ORDER BY created_at DESC
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                orders.add(mapOrder(resultSet));
            }

        } catch (SQLException exception) {
            throw new RuntimeException(
                    "Error fetching all orders", exception);
        }

        return orders;
    }

    private Order mapOrder(ResultSet resultSet) throws SQLException {

        return new Order(
                resultSet.getInt("id"),
                resultSet.getInt("buyer_id"),
                resultSet.getBigDecimal("total_amount"),
                resultSet.getString("status"),
                resultSet.getString("shipping_address"),
                resultSet.getString("payment_method"),
                resultSet.getTimestamp("created_at"),
                resultSet.getTimestamp("updated_at")
        );
    }
}