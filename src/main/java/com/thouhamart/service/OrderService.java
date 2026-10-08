package com.thouhamart.service;

import com.thouhamart.dao.OrderDAO;
import com.thouhamart.model.Order;

import java.math.BigDecimal;
import java.util.List;

public class OrderService {

    private final OrderDAO orderDAO;

    public OrderService(OrderDAO orderDAO) {
        this.orderDAO = orderDAO;
    }

    public int placeOrder(int buyerId,
                          BigDecimal totalAmount,
                          String shippingAddress,
                          String paymentMethod,
                          List<Integer> cartItemIds) {

        if (buyerId <= 0) {
            return -1;
        }

        if (totalAmount == null || totalAmount.compareTo(BigDecimal.ZERO) <= 0) {
            return -1;
        }

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            return -1;
        }

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            return -1;
        }

        if (cartItemIds == null || cartItemIds.isEmpty()) {
            return -1;
        }

        Order order = new Order();

        order.setBuyerId(buyerId);
        order.setTotalAmount(totalAmount);
        order.setStatus("PLACED");
        order.setShippingAddress(shippingAddress.trim());
        order.setPaymentMethod(paymentMethod.trim());

        return orderDAO.createOrder(order, cartItemIds);
    }

    public List<Order> getBuyerOrders(int buyerId) {

        if (buyerId <= 0) {
            return List.of();
        }

        return orderDAO.findOrdersByBuyer(buyerId);
    }

    public Order getOrder(int orderId, int buyerId) {

        if (orderId <= 0 || buyerId <= 0) {
            return null;
        }

        return orderDAO.findById(orderId, buyerId);
    }
}