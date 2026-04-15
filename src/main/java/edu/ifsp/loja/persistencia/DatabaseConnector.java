package edu.ifsp.loja.persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
	private static final String URL = envOrDefault("DB_URL", "jdbc:mysql://localhost:3306/loja");
	private static final String USER = envOrDefault("DB_USER", "root");
	private static final String PASSWORD = envOrDefault("DB_PASSWORD", "root");

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}

	private static String envOrDefault(String name, String fallback) {
		String value = System.getenv(name);
		if (value == null) {
			value = System.getProperty(name);
		}
		return value == null ? fallback : value;
	}

}
