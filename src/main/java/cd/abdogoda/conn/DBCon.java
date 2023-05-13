package cd.abdogoda.conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBCon {
	private static Connection connection = null;
	public static Connection getConnection() throws SQLException {
		if(connection == null) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3307/nature","root","");
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}System.out.print("Connected");
		}
		return connection;
	}
}
