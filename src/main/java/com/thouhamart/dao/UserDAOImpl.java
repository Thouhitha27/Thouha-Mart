package com.thouhamart.dao;

import com.thouhamart.model.User;
import com.thouhamart.util.DBUtil;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    private final HikariDataSource dataSource;

    public UserDAOImpl(HikariDataSource dataSource) {
        this.dataSource = dataSource;
    }

    // Find a user using email
    @Override
    public User findByEmail(String email) {

        String sql = "SELECT id, name, email, password_hash, role " +
                     "FROM users WHERE email = ?";

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Unable to find user by email.", e);
        }

        return null;
    }

    // Check whether an email already exists
    @Override
    public boolean emailExists(String email) {

        String sql = "SELECT 1 FROM users WHERE email = ? LIMIT 1";

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }

        } catch (SQLException e) {
            throw new RuntimeException("Unable to check email.", e);
        }
    }

    // Register and save a new user
    @Override
    public boolean save(User user) {

        String sql = "INSERT INTO users " +
                     "(name, email, password_hash, role) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(
                     sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash());
            statement.setString(4, user.getRole());

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                try (ResultSet keys = statement.getGeneratedKeys()) {
                    if (keys.next()) {
                        user.setId(keys.getInt(1));
                    }
                }
                return true;
            }

            return false;

        } catch (SQLException e) {
            throw new RuntimeException("Unable to save user.", e);
        }
    }

    // Admin: retrieve all registered users
    @Override
    public List<User> findAllUsers() {

        List<User> users = new ArrayList<>();

        String sql = "SELECT id, name, email, password_hash, role " +
                     "FROM users ORDER BY id DESC";

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                users.add(mapUser(resultSet));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Unable to retrieve users.", e);
        }

        return users;
    }

    // Convert database row into User object
    private User mapUser(ResultSet resultSet) throws SQLException {

        User user = new User();

        user.setId(resultSet.getInt("id"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setPasswordHash(resultSet.getString("password_hash"));
        user.setRole(resultSet.getString("role"));

        return user;
    }
}