package com.thouhamart.dao;

import com.thouhamart.model.Order;

import java.util.List;

public interface OrderDAO {

    int createOrder(Order order, List<Integer> cartItemIds);

    List<Order> findOrdersByBuyer(int buyerId);

    Order findById(int orderId, int buyerId);
}