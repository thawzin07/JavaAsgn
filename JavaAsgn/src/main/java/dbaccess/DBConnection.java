package dbaccess;

import java.sql.*;

public class DBConnection {
	public static Connection getConnection() {
		String dbUrl="jdbc:mysql://localhost/javaassignment";
		String dbUser="root";
		String dbPassword="root1234";
		String dbClass="com.mysql.jdbc.Driver";
		
		Connection connection=null;
		try {
			Class.forName(dbClass);
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			connection= DriverManager.getConnection(dbUrl,dbUser,dbPassword);
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}
}
