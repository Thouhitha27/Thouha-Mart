package com.thouhamart.dao;

import com.thouhamart.model.Order;

import java.util.List;

public interface OrderDAO {

    // Create a new order during checkout
    int createOrder(Order order, List<Integer> cartItemIds);

    // Retrieve orders belonging to a specific buyer
    List<Order> findOrdersByBuyer(int buyerId);

    // Find one order belonging to a specific buyer
    Order findById(int orderId, int buyerId);

    // Admin: retrieve all customer orders
    List<Order> findAllOrders();
}