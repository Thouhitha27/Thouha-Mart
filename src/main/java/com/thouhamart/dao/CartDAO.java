package com.thouhamart.dao;

import com.thouhamart.model.CartItem;

import java.util.List;

public interface CartDAO {

    int getOrCreateCart(int userId);

    boolean addItem(int cartId, int productId, int quantity);

    List<CartItem> findCartItems(int cartId);

    boolean removeItem(int cartId, int productId);

    boolean updateQuantity(int cartId, int productId, int quantity);

    boolean clearCart(int cartId);
}