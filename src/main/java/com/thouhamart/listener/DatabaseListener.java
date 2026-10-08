package com.thouhamart.listener;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DatabaseListener implements ServletContextListener {

    private HikariDataSource dataSource;

    @Override
    public void contextInitialized(ServletContextEvent event) {

        HikariConfig config = new HikariConfig();

        config.setJdbcUrl("jdbc:mysql://localhost:3306/thouha_mart");
        config.setUsername("root");
        config.setPassword("thouhitha29@03");

        config.setDriverClassName("com.mysql.cj.jdbc.Driver");

        config.setMaximumPoolSize(10);
        config.setMinimumIdle(2);
        config.setPoolName("ThouhaMartPool");

        dataSource = new HikariDataSource(config);

        ServletContext context = event.getServletContext();
        context.setAttribute("dataSource", dataSource);

        System.out.println("=================================");
        System.out.println("THOUHA MART DATABASE CONNECTED");
        System.out.println("=================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {

        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            System.out.println("THOUHA MART DATABASE CONNECTION CLOSED");
        }
    }
}