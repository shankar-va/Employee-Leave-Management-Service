package com.project.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static String url=DB_INFO.getUrl();
	private static String username=DB_INFO.getUsername();
	private static String pswd=DB_INFO.getPswd();
	private  Connection connection=null;
	public DBConnection() {
		try {
			Class.forName("org.postgresql.Driver");
			connection=DriverManager.getConnection(url,username,pswd);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	public static Connection connect() {
		return new DBConnection().connection;
	}
}
