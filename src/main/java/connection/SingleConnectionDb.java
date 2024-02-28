package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionDb {

	private static final String FOREGROUND_COLOR_GREEN = "\u001B[32m";
	private static final String FOREGROUND_COLOR_YELLOW = "\u001B[33m";
	private static final String FOREGROUND_COLOR_RESET = "\u001B[0m";

	private static final String DATABASEURL = "jdbc:postgresql://localhost:5432/first_jsp_db?" + "autoReconnect=true";
	private static final String USER = "postgres";
	private static final String PASSWORD = "psql2024!c";

	private static Connection connection = null;

	public static Connection getConnection() {
		return connection;
	}

	static {
		connect();
	}

	public SingleConnectionDb() {
		connect();
	}

	private static void connect() {
		try {

			if (connection == null) {
				Class.forName("org.postgresql.Driver");
				connection = DriverManager.getConnection(DATABASEURL, USER, PASSWORD);
				connection.setAutoCommit(false);
				
				System.out.println("\n\t" + FOREGROUND_COLOR_GREEN + "Connected to first_jsp_db successfully!!!"
			+ FOREGROUND_COLOR_RESET + "\n\n");
			}

		} catch (Exception e) {
			System.out.println(
					"\n\t" + FOREGROUND_COLOR_YELLOW + "We had a problem to connect in first_jsp_db!!!"
			+ FOREGROUND_COLOR_RESET + "\n\n");
			e.printStackTrace();

			try {
				connection.rollback();
			} catch (Exception ex) {
				System.out.println("\n\tPROBLEM WHILE TRY TO ROLLBACK DB!!\n\n");
				ex.printStackTrace();
			}
		}
	}

}
