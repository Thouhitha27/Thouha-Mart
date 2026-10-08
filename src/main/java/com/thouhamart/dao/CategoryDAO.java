package com.thouhamart.dao;

import com.thouhamart.model.Category;

import java.util.List;

public interface CategoryDAO {

    List<Category> findAll();

}