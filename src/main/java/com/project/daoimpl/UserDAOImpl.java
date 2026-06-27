package com.project.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.project.util.PasswordUtil;
import com.project.dao.UserDAO;
import com.project.model.User;
import com.project.util.DBConnection;

public class UserDAOImpl implements UserDAO {
	private static Connection connection =DBConnection.connect();

	@Override
	public boolean register(User user) {
		String query = "INSERT INTO users_emp (name,email,password,role,department,phone) values(?,?,?,?,?,?);";
		PreparedStatement pstm;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, user.getName());
			pstm.setString(2, user.getEmail());
			pstm.setString(3, user.getPassword());
			pstm.setString(4, user.getRole());
			pstm.setString(5, user.getDepartment());
			pstm.setString(6, user.getPhone());
			Integer res = pstm.executeUpdate();
			if (res.equals(1))
				return true;
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return false;
	}

	@Override
	public User login(String email, String password) {
		String query = "SELECT * from users_emp WHERE email=?;";
		PreparedStatement pstm;
		ResultSet result;
		boolean verify = false;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, email);
			result = pstm.executeQuery();
			if (!result.next())
				return null;
			verify = PasswordUtil.verifyPassword(password, result.getString("password"));
			if (verify) {
				return getUser(result);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean emailExists(String email) {
		String query = "SELECT * from users_emp WHERE email=?;";
		PreparedStatement pstm;
		ResultSet res = null;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, email);
			res = pstm.executeQuery();
			return res.next() ? true : false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<User> getAll() {
		List<User> list = new ArrayList<User>();
		String query = "SELECT * from users_emp;";
		PreparedStatement pstm;
		ResultSet result;

		try {
			pstm = connection.prepareStatement(query);
			result = pstm.executeQuery();
			while (result.next()) {
				list.add(getUser(result));
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return list;
	}

	@Override
	public User getUserById(Integer id) {
		String query = "SELECT * from users_emp WHERE id=?;";
		PreparedStatement pstm;
		ResultSet result = null;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setInt(1, id);
			result = pstm.executeQuery();
			if (!result.next())
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return getUser(result);
	}

	@Override
	public User findByEmail(String email) {
		String query = "SELECT * from users_emp WHERE email=?;";
		PreparedStatement pstm;
		ResultSet result = null;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, email);
			result = pstm.executeQuery();
			if (!result.next())
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return getUser(result);
	}

	@Override
	public boolean updateEmployee(User user) {
		String query = "UPDATE users_emp SET name=?,email=?,role=?,department=?,phone=? WHERE id=?;";
		PreparedStatement pstm;
		boolean result = false;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, user.getName());
			pstm.setString(2, user.getEmail());
			pstm.setString(3, user.getRole());
			pstm.setString(4, user.getDepartment());
			pstm.setString(5, user.getPhone());
			pstm.setInt(6, user.getId());
			result = pstm.executeUpdate()>0?true:false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean deleteEmployeeById(Integer id) {
		String query = "DELETE FROM users_emp WHERE id=?;";
		PreparedStatement pstm;
		boolean result = false;
		try {
			pstm = connection.prepareStatement(query);
			pstm.setInt(1, id);
			result = pstm.executeUpdate()>0?true:false;;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean changePassword(String email, String oldPswd, String newPswd) {
		String query1="SELECT password from users_emp where email=?;";
		String query2 = "UPDATE users_emp SET password=? WHERE email=?;";
		ResultSet rSet=null;
		PreparedStatement pstm;
		boolean result = false;
		try {
			pstm = connection.prepareStatement(query1);
			pstm.setString(1, email);
			rSet=pstm.executeQuery();
			if(rSet.next()) {
				 if (!PasswordUtil.verifyPassword(oldPswd, rSet.getString(1)))return false;
			}
			pstm = connection.prepareStatement(query2);
			pstm.setString(1,PasswordUtil.hashPassword(newPswd));
			pstm.setString(2, email);
			result = pstm.executeUpdate()>0?true:false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Integer countEmployees() {
		String query = "SELECT count(*) FROM users_emp WHERE role='user';";
		PreparedStatement pstm;
		ResultSet result = null;
		try {
			pstm = connection.prepareStatement(query);
			result = pstm.executeQuery();
			if (!result.next())
				return null;
			return result.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<User> searchByName(String name) {
		List<User> list = new ArrayList<User>();
		String query = "SELECT * from users_emp WHERE name=?;";
		PreparedStatement pstm;
		ResultSet result;

		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, name);
			result = pstm.executeQuery();
			while (result.next()) {
				list.add(getUser(result));
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<User> searchByDept(String dept) {
		List<User> list = new ArrayList<User>();
		String query = "SELECT * from users_emp WHERE department=?;";
		PreparedStatement pstm;
		ResultSet result;

		try {
			pstm = connection.prepareStatement(query);
			pstm.setString(1, dept);
			result = pstm.executeQuery();
			while (result.next()) {
				list.add(getUser(result));
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return list;
	}

	private User getUser(ResultSet result) {
		Integer id = null;
		String uname = null;
		String email = null;
		String role = null;
		String department = null;
		String phone = null;
		try {
			id = result.getInt("id");
			uname = result.getString("name");
			email = result.getString("email");
			role = result.getString("role");
			department = result.getString("department");
			phone = result.getString("phone");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return new User(id, uname, email, null, role, department, phone);
	}
}
