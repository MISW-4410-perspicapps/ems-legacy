package com.EMS.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBAccess {
	
	static Connection con = null;
	// Use environment variables for Docker compatibility, fallback to localhost for development
	static final String DB_HOST = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
	static final String DB_PORT = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
	static final String DB_NAME = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "ems_database";
	static final String URL = "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME;
	static final String USERNAME = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "ems_user";
	static final String PASSWORD = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "ems_password";

	/*public static Connection getConnection(){
        if (con != null) return con;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection(url, uname, pass);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return con;
    }*/
	
	private static void createConnection(){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		}catch (ClassNotFoundException e){
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static Connection getConnection(){
		//System.out.println("connection "+con);
		try {
			if(con == null || con.isClosed()) {
				//System.out.println("Inside IF");			
				createConnection();
				return con;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("Outside IF");
		return con;
	}
}
