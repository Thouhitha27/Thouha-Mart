package com.thouhamart.service;

import com.thouhamart.dao.CartDAO;
import com.thouhamart.model.CartItem;

import java.util.List;

public class CartService {

    private final CartDAO cartDAO;

    public CartService(CartDAO cartDAO) {
        this.cartDAO = cartDAO;
    }

    public boolean addToCart(int userId, int productId, int quantity) {

        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        int cartId = cartDAO.getOrCreateCart(userId);

        if (cartId <= 0) {
            return false;
        }

        return cartDAO.addItem(
                cartId,
                productId,
                quantity
        );
    }

    public List<CartItem> getCartItems(int userId) {

        if (userId <= 0) {
            return List.of();
        }

        int cartId = cartDAO.getOrCreateCart(userId);

        if (cartId <= 0) {
            return List.of();
        }

        return cartDAO.findCartItems(cartId);
    }

    public boolean removeFromCart(
            int userId,
            int productId) {

        if (userId <= 0 || productId <= 0) {
            return false;
        }

        int cartId = cartDAO.getOrCreateCart(userId);

        return cartDAO.removeItem(
                cartId,
                productId
        );
    }

    public boolean updateQuantity(
            int userId,
            int productId,
            int quantity) {

        if (userId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        int cartId = cartDAO.getOrCreateCart(userId);

        return cartDAO.updateQuantity(
                cartId,
                productId,
                quantity
        );
    }

    public boolean clearCart(int userId) {

        if (userId <= 0) {
            return false;
        }

        int cartId = cartDAO.getOrCreateCart(userId);

        return cartDAO.clearCart(cartId);
    }
}