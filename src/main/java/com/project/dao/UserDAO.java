package com.project.dao;

import java.util.List;

import com.project.model.User;


public interface UserDAO {
	//Authentication
	 boolean register(User user);
	 User login(String username,String password);
	 boolean emailExists(String email);
	 
	 //User Management
	 List<User> getAll();
	 User getUserById(Integer id);
	 User findByEmail(String email);
	 boolean updateEmployee(User user);
	 boolean deleteEmployeeById(Integer id);
	 boolean changePassword(String email,String oldPswd,String newPswd);
	 
	 //Dashboard Utilities
	 Integer countEmployees();
	 List<User> searchByName(String name);
	 List<User> searchByDept(String dept);
	 
}
