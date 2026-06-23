package com.project.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static String url="jdbc:postgresql://localhost:5432/employee_leave_management";
	private static String username="postgres";
	private static String pswd="123";
	public static Connection connect() {
		Connection connection=null;
		try {
			Class.forName("org.postgresql.Driver");
			connection=DriverManager.getConnection(url,username,pswd);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}
}
