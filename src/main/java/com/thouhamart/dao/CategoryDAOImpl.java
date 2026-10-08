package com.thouhamart.dao;

import com.thouhamart.model.Category;
import com.thouhamart.util.DBUtil;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    private final HikariDataSource dataSource;

    public CategoryDAOImpl(HikariDataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public List<Category> findAll() {

        List<Category> categories = new ArrayList<>();

        String sql = """
                SELECT id, name, description
                FROM categories
                ORDER BY name
                """;

        try (Connection connection = DBUtil.getConnection(dataSource);
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Category category = new Category();

                category.setId(resultSet.getInt("id"));
                category.setName(resultSet.getString("name"));
                category.setDescription(
                        resultSet.getString("description")
                );

                categories.add(category);
            }

        } catch (Exception e) {
            throw new RuntimeException(
                    "Error loading categories",
                    e
            );
        }

        return categories;
    }
}