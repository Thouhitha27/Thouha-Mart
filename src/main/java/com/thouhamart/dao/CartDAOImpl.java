package com.thouhamart.dao;

import com.thouhamart.model.CartItem;
import com.thouhamart.util.DBUtil;
import com.zaxxer.hikari.HikariDataSource;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    private final HikariDataSource dataSource;

    public CartDAOImpl(HikariDataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public int getOrCreateCart(int userId) {

        String findSql = """
                SELECT id
                FROM cart
                WHERE buyer_id = ?
                """;

        String insertSql = """
                INSERT INTO cart (buyer_id)
                VALUES (?)
                """;

        try (Connection connection = DBUtil.getConnection(dataSource)) {

            try (PreparedStatement statement =
                         connection.prepareStatement(findSql)) {

                statement.setInt(1, userId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (resultSet.next()) {
                        return resultSet.getInt("id");
                    }
                }
            }

            try (PreparedStatement statement =
                         connection.prepareStatement(
                                 insertSql,
                                 Statement.RETURN_GENERATED_KEYS)) {

                statement.setInt(1, userId);

                statement.executeUpdate();

                try (ResultSet keys =
                             statement.getGeneratedKeys()) {

                    if (keys.next()) {
                        return keys.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error getting or creating cart", e
            );
        }

        return 0;
    }

    @Override
    public boolean addItem(int cartId,
                           int productId,
                           int quantity) {

        String checkSql = """
                SELECT id, quantity
                FROM cart_items
                WHERE cart_id = ?
                  AND product_id = ?
                """;

        String updateSql = """
                UPDATE cart_items
                SET quantity = quantity + ?
                WHERE cart_id = ?
                  AND product_id = ?
                """;

        String insertSql = """
                INSERT INTO cart_items
                (cart_id, product_id, quantity)
                VALUES (?, ?, ?)
                """;

        try (Connection connection = DBUtil.getConnection(dataSource)) {

            try (PreparedStatement statement =
                         connection.prepareStatement(checkSql)) {

                statement.setInt(1, cartId);
                statement.setInt(2, productId);

                try (ResultSet resultSet =
                             statement.executeQuery()) {

                    if (resultSet.next()) {

                        try (PreparedStatement updateStatement =
                                     connection.prepareStatement(updateSql)) {

                            updateStatement.setInt(1, quantity);
                            updateStatement.setInt(2, cartId);
                            updateStatement.setInt(3, productId);

                            return updateStatement.executeUpdate() > 0;
                        }
                    }
                }
            }

            try (PreparedStatement statement =
                         connection.prepareStatement(insertSql)) {

                statement.setInt(1, cartId);
                statement.setInt(2, productId);
                statement.setInt(3, quantity);

                return statement.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error adding item to cart", e
            );
        }
    }

    @Override
    public List<CartItem> findCartItems(int cartId) {

        List<CartItem> items = new ArrayList<>();

        String sql = """
                SELECT ci.id,
                       ci.cart_id,
                       ci.product_id,
                       p.name,
                       p.price,
                       ci.quantity,
                       (p.price * ci.quantity) AS subtotal,
                       p.image_url
                FROM cart_items ci
                JOIN products p
                  ON ci.product_id = p.id
                WHERE ci.cart_id = ?
                ORDER BY ci.id DESC
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    CartItem item = new CartItem();

                    item.setId(
                            resultSet.getInt("id")
                    );

                    item.setCartId(
                            resultSet.getInt("cart_id")
                    );

                    item.setProductId(
                            resultSet.getInt("product_id")
                    );

                    item.setProductName(
                            resultSet.getString("name")
                    );

                    item.setPrice(
                            resultSet.getBigDecimal("price")
                    );

                    item.setQuantity(
                            resultSet.getInt("quantity")
                    );

                    item.setSubtotal(
                            resultSet.getBigDecimal("subtotal")
                    );

                    item.setImageUrl(
                            resultSet.getString("image_url")
                    );

                    items.add(item);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error loading cart items", e
            );
        }

        return items;
    }

    @Override
    public boolean removeItem(int cartId,
                              int productId) {

        String sql = """
                DELETE FROM cart_items
                WHERE cart_id = ?
                  AND product_id = ?
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);
            statement.setInt(2, productId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error removing cart item", e
            );
        }
    }

    @Override
    public boolean updateQuantity(int cartId,
                                  int productId,
                                  int quantity) {

        String sql = """
                UPDATE cart_items
                SET quantity = ?
                WHERE cart_id = ?
                  AND product_id = ?
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, quantity);
            statement.setInt(2, cartId);
            statement.setInt(3, productId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error updating cart quantity", e
            );
        }
    }

    @Override
    public boolean clearCart(int cartId) {

        String sql = """
                DELETE FROM cart_items
                WHERE cart_id = ?
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, cartId);

            return statement.executeUpdate() >= 0;

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Error clearing cart", e
            );
        }
    }
}