package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.SingleConnectionDb;
import model.ModelLogin;

public class DAOLoginRepository {

	private String login;
	private String password;
	private Connection connection;

	public DAOLoginRepository() {
		connection = SingleConnectionDb.getConnection();
	}
	
	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public Long returnUserId(String userLogin) {
		String sqlQuery = "SELECT id FROM model_login WHERE upper(login) = upper(?)";
		Long id = 0L;
		
		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, userLogin);
			ResultSet resultQuery = statementQuery.executeQuery();
			
			resultQuery.next();
			id = resultQuery.getLong("id");
			
		}catch(Exception ex) {
			System.out.println("\\nWe had a problem to search a user's id in DAOLoginRepository!\\n\\n");
			id = null;
		}
		
		return id;
	}

	public boolean userAuthentication(ModelLogin modelLogin) throws SQLException {
		String sqlQuery = "select * from model_login where upper(login) = upper(?) and password = ?";

		PreparedStatement validationStatement = connection.prepareStatement(sqlQuery);
		validationStatement.setString( 1, modelLogin.getLogin() );
		validationStatement.setString( 2, modelLogin.getPassword() );

		ResultSet result = validationStatement.executeQuery();

		if (result.next()) {
			return true;
		}

		return false;
	}

}
