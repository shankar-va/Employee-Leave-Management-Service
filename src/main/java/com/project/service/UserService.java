package com.project.service;
import java.util.List;

import com.project.daoimpl.UserDAOImpl;
import com.project.model.User;
import com.project.util.PasswordUtil;
import com.project.util.Validator;

public class UserService {
    private static UserDAOImpl userDAO=new UserDAOImpl();
	/* 1) Authentication: */
	public static boolean register(String name,String email,String password,String role,String department,String phone) {
		if(name==null||password==null||role==null||department==null||email==null||phone==null)return false;
		if(name.equals("")||
				!Validator.isValidEmail(email)||
				password.equals("")||
				!Validator.isValidPhone(phone)||
				role.equals("")||
				department.equals(""))return false;
		if(userDAO.emailExists(email))return false;
		String hashPswd=PasswordUtil.hashPassword(password);
		User newUser=new User(name,email,hashPswd,role,department,phone);
		return userDAO.register(newUser);
	}
	public static User login(String email,String password) {
		
		if(!(Validator.isValidEmail(email) && userDAO.emailExists(email)))return null;
		 return userDAO.login(email, password);
	}
	public static boolean changePassword(String email, String oldPswd, String newPswd) {
		if(!(Validator.isValidEmail(email) && userDAO.emailExists(email)))return false;
		return userDAO.changePassword(email,oldPswd,newPswd);
	}
	/* 2) User Management: */
	
	public static List<User> getAll() {
		return userDAO.getAll();
	}
	public static User getById(Integer id) {
		if(id==null)return null;
		return userDAO.getUserById(id);
	}
	public static User getByEmail(String email) {
		if(email==null||email.equals(""))return null;
		if(Validator.isValidEmail(email))
			return userDAO.findByEmail(email);
		return null;
	}
	public static boolean update(Integer id,String name,String email,String role,String department,String phone) {
		if(email==null||phone==null ||department==null||name==null||phone==null)return false;
		if(!(Validator.isValidEmail(email)&&Validator.isValidPhone(phone)&&!(department.equals(""))))return false;
		User newUser=new User(id,name,email,null,role,department,phone);
		return userDAO.updateEmployee(newUser);
	}
	public static boolean delete(Integer id) {
		if(id==null)return false;
		User user=userDAO.getUserById(id);
		if(user==null)return false;
		if(!user.getRole().equals("USER"))return false;
		return userDAO.deleteEmployeeById(id);
	}
	/*3) Dashboard: */
	public static Integer count() {
		Integer count=userDAO.countEmployees();
		return count!=null?count:0;
	}
	public static List<User> searchName(String name){
		if(name==null||name.equals(""))return null;
		return userDAO.searchByName(name);
	}
	public static List<User> searchDept(String dept){
		if(dept==null||dept.equals(""))return null;
		return userDAO.searchByDept(dept);
	}
}
