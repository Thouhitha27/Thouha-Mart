package com.thouhamart.listener;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.SQLException;

@WebListener
public class DatabaseListener implements ServletContextListener {

    private HikariDataSource dataSource;

    @Override
    public void contextInitialized(ServletContextEvent event) {

        ServletContext context = event.getServletContext();

        try {
            HikariConfig config = new HikariConfig();

            String jdbcUrl = System.getenv("DB_URL");
            String dbUsername = System.getenv("DB_USERNAME");
            String dbPassword = System.getenv("DB_PASSWORD");

            /*
             * Local development fallback.
             * Railway deployment-la DB_URL, DB_USERNAME,
             * DB_PASSWORD environment variables set pannavum.
             */
            if (jdbcUrl == null || jdbcUrl.isBlank()) {
                jdbcUrl = "jdbc:mysql://localhost:3306/thouha_mart"
                        + "?sslMode=DISABLED"
                        + "&serverTimezone=Asia/Kolkata";
            }

            if (dbUsername == null || dbUsername.isBlank()) {
                dbUsername = "root";
            }

            if (dbPassword == null || dbPassword.isBlank()) {
                dbPassword = "password";
            }

            config.setJdbcUrl(jdbcUrl);
            config.setUsername(dbUsername);
            config.setPassword(dbPassword);

            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

            // HikariCP connection pool
            config.setPoolName("ThouhaMartPool");
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setConnectionTimeout(30000);
            config.setIdleTimeout(600000);
            config.setMaxLifetime(1800000);

            // Validate connections before using them
            config.setConnectionTestQuery("SELECT 1");

            // Initialize connection pool
            dataSource = new HikariDataSource(config);

            // Verify that a database connection works
            try (Connection connection = dataSource.getConnection()) {

                if (!connection.isValid(5)) {
                    throw new SQLException(
                            "Database connection validation failed."
                    );
                }

                System.out.println(
                        "THOUHA MART DATABASE CONNECTED SUCCESSFULLY"
                );

                System.out.println(
                        "Database connection pool: "
                                + dataSource.getPoolName()
                );
            }

            // Share the datasource with application components
            context.setAttribute("dataSource", dataSource);

        } catch (Exception e) {

            System.err.println(
                    "THOUHA MART DATABASE CONNECTION FAILED"
            );

            e.printStackTrace();

            // Stop application startup if database initialization fails
            if (dataSource != null && !dataSource.isClosed()) {
                dataSource.close();
                dataSource = null;
            }

            throw new IllegalStateException(
                    "Unable to initialize THOUHA MART database connection.",
                    e
            );
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {

        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();

            System.out.println(
                    "THOUHA MART DATABASE CONNECTION POOL CLOSED"
            );
        }
    }
}

