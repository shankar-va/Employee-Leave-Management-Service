package com.project.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
		private static final String url = DB_INFO.getUrl();
								        
		
		private static final String username =
								
								        DB_INFO.getUsername();
								        
		
		private static final String pswd =
								
								        DB_INFO.getPswd();
								       
	private  Connection connection=null;
	public DBConnection() {
		try {
			Class.forName("org.postgresql.Driver");
			connection=DriverManager.getConnection(url,username,pswd);
			System.out.println(connection);
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
