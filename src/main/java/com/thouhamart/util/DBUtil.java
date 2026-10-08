package com.thouhamart.util;

import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {

    private DBUtil() {
        // Utility class
    }

    public static Connection getConnection(HikariDataSource dataSource)
            throws SQLException {

        if (dataSource == null) {
            throw new SQLException("Database connection pool is not initialized.");
        }

        return dataSource.getConnection();
    }
}