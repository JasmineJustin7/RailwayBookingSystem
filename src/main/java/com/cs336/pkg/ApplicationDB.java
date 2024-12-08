package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

public class ApplicationDB {
	
	public ApplicationDB(){
		
	}

	public Connection getConnection(){
		
		
		//Create a connection string
		//String connectionURL = "jdbc:mysql://jasminejustin7:BlackLagoon2006!@localhost:3306/logininfo";
		String connectionURL = "jdbc:mysql://localhost:3306/logininfo?useSSL=false&allowPublicKeyRetrieval=true";
		String myUsername = "jasminejustin7";
		String myPassword = "BlackLagoon2006!";
		//String connectionUrl = "jdbc:mysql://localhost:3306/logininfoproject2";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionURL, myUsername, myPassword);
			//connection = DriverManager.getConnection(connectionUrl,"root", "root");
			Statement stmt = (Statement) connection.createStatement();
			String sql = "SELECT * FROM users";
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String username = rs.getString("username");
				String password = rs.getString("password");
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		ApplicationDB dao = new ApplicationDB();
		Connection connection = dao.getConnection();
		
		System.out.println(connection);		
		dao.closeConnection(connection);
	}
	
	

}
