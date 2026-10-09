package com.thouhamart.dao;

import com.thouhamart.model.User;
import java.util.List;

public interface UserDAO {

    User findByEmail(String email);

    boolean emailExists(String email);

    boolean save(User user);

    // Admin: retrieve all registered users
    List<User> findAllUsers();
}