package com.thouhamart.dao;

import com.thouhamart.model.User;

public interface UserDAO {

    User findByEmail(String email);

    boolean emailExists(String email);

    boolean save(User user);
}