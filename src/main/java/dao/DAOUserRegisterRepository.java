package dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import connection.SingleConnectionDb;
import model.ModelLogin;

public class DAOUserRegisterRepository {

	private Connection connection;

	public DAOUserRegisterRepository() {
		connection = SingleConnectionDb.getConnection();
	}

	public String[] saveNewUserOnDB(ModelLogin modelLogin, Long currentAdminId) {
		String sqlQuery = "INSERT INTO model_login (login, password, name, email, user_id_definition, perfil, gender, cep, street, number, city, neighborhood, state, userbirthday, monthlyincome) "
				+ "values (lower(?), ?, lower(?), lower(?), ?, upper(?), upper(?), ?, lower(?), ?, lower(?), lower(?), lower(?), ?, trunc(CAST(? AS numeric), 2) )";
		String[] messageOfConnection = new String[2];
		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, modelLogin.getLogin());
			statementQuery.setString(2, modelLogin.getPassword());
			statementQuery.setString(3, modelLogin.getName());
			statementQuery.setString(4, modelLogin.getEmail());
			statementQuery.setLong(5, currentAdminId);
			statementQuery.setString(6, modelLogin.getPerfil());
			statementQuery.setString(7, modelLogin.getGender());
			statementQuery.setString(8, modelLogin.getCep());
			statementQuery.setString(9, modelLogin.getStreet());
			statementQuery.setString(10, modelLogin.getNumber());
			statementQuery.setString(11, modelLogin.getCity());
			statementQuery.setString(12, modelLogin.getNeighborhood());
			statementQuery.setString(13, modelLogin.getState());
			statementQuery.setString(14, modelLogin.getUserBirthday());
			statementQuery.setBigDecimal(15, modelLogin.getMonthlyIncome());

			if (loginExists(modelLogin.getLogin()) || emailExists(modelLogin.getEmail())) {
				messageOfConnection[0] = "User already exists!";
				messageOfConnection[1] = "text-danger";

			} else {
				statementQuery.execute();
				connection.commit();

				messageOfConnection[0] = "User saved successfully!!";
				messageOfConnection[1] = "text-success";
			}

			if ((modelLogin.getUserPhoto() != null && !modelLogin.getUserPhoto().isEmpty())
					&& (modelLogin.getExtentionUserPhoto() != null && !modelLogin.getExtentionUserPhoto().isEmpty())) {
				sqlQuery = "update model_login set userphoto = ?, extentionuserphoto = ? WHERE login = ?";
				statementQuery = connection.prepareStatement(sqlQuery);
				statementQuery.setString(1, modelLogin.getUserPhoto());
				statementQuery.setString(2, modelLogin.getExtentionUserPhoto());
				statementQuery.setString(3, modelLogin.getLogin());

				statementQuery.execute();
				connection.commit();
			}

		} catch (Exception ex) {

			try {
				connection.rollback();
			} catch (Exception e) {
				System.out.println("\nWe had an error on DAOUserRegisterRepository class\n"
						+ "Error while tried to make a rollback in save new user method!!\n\n");
				ex.printStackTrace();
			}

			messageOfConnection[0] = ex.getMessage();
			messageOfConnection[1] = "text-danger";
			System.out.println("\nWe had an error on DAOUserRegisterRepository class\n"
					+ "Error while tried to make a query to save datas\n\n");
			ex.printStackTrace();
		}

		return messageOfConnection;
	}

	public ModelLogin consultUserByIdIncludinAdmin(Long id) {
		String sqlQuery = "SELECT * FROM model_login WHERE id = ?";
		ModelLogin modelLogin;

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setLong(1, id);
			ResultSet resultQuery = statementQuery.executeQuery();

			modelLogin = new ModelLogin();

			while (resultQuery.next()) {
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setUserPhoto(resultQuery.getString("userphoto"));
				modelLogin.setExtentionUserPhoto(resultQuery.getString("extentionuserphoto"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's login!\n\n");
			modelLogin = null;
		}

		return modelLogin;
	}

	public ModelLogin consultUserById(Long id) {
		String sqlQuery = "SELECT * FROM model_login WHERE id = ? AND useradmin is false";
		ModelLogin modelLogin;

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setLong(1, id);
			ResultSet resultQuery = statementQuery.executeQuery();

			modelLogin = new ModelLogin();

			while (resultQuery.next()) {
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setUserPhoto(resultQuery.getString("userphoto"));
				modelLogin.setExtentionUserPhoto(resultQuery.getString("extentionuserphoto"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's login!\n\n");
			modelLogin = null;
		}

		return modelLogin;
	}

	public ModelLogin consultUserById(Long id, Long currentAdminId) {
		String sqlQuery = "SELECT * FROM model_login WHERE id = ? AND useradmin is false AND user_id_definition = ?";
		ModelLogin modelLogin;

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setLong(1, id);
			statementQuery.setLong(2, currentAdminId);
			ResultSet resultQuery = statementQuery.executeQuery();

			modelLogin = new ModelLogin();

			while (resultQuery.next()) {
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setUserPhoto(resultQuery.getString("userphoto"));
				modelLogin.setExtentionUserPhoto(resultQuery.getString("extentionuserphoto"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's login!\n\n");
			modelLogin = null;
		}

		return modelLogin;
	}

	public ModelLogin consultUserByLogin(String login) {
		String sqlQuery = "SELECT * FROM model_login WHERE upper(login) = upper(?)";
		ModelLogin modelLogin;

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, login);
			ResultSet resultQuery = statementQuery.executeQuery();

			modelLogin = new ModelLogin();

			while (resultQuery.next()) {
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setUserPhoto(resultQuery.getString("userphoto"));
				modelLogin.setExtentionUserPhoto(resultQuery.getString("extentionuserphoto"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's login!\n\n");
			modelLogin = null;
		}

		return modelLogin;
	}

	public ModelLogin consultUserByLogin(String login, Long currentAdminId) {
		String sqlQuery = "SELECT * FROM model_login WHERE upper(login) = upper(?) AND useradmin is false"
				+ " AND user_id_definition = ?";
		ModelLogin modelLogin;

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, login);
			statementQuery.setLong(2, currentAdminId);
			ResultSet resultQuery = statementQuery.executeQuery();

			modelLogin = new ModelLogin();

			while (resultQuery.next()) {
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setUserPhoto(resultQuery.getString("userphoto"));
				modelLogin.setExtentionUserPhoto(resultQuery.getString("extentionuserphoto"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's login!\n\n");
			modelLogin = null;
		}

		return modelLogin;
	}

	public int totalToShowInPaginationModal(String name, Long currentAdminId) {
		Double howManyPages = 0.0;
		String sqlQuery = "SELECT count(1) as totalpages FROM model_login WHERE upper(name) like upper(?) AND useradmin is false"
				+ " AND user_id_definition = ?";

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, "%" + name + "%");
			statementQuery.setLong(2, currentAdminId);

			ResultSet resultQuery = statementQuery.executeQuery();
			resultQuery.next();

			Double totalRegistrations = resultQuery.getDouble("totalpages");
			howManyPages = totalRegistrations / 5.0;

			if (howManyPages % 2 >= 1) {
				howManyPages++;
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's name!\n\n");
			howManyPages = null;
		}

		return howManyPages.intValue();
	}

	public List<ModelLogin> consultUserByName(String name, Long currentAdminId) {
		List<ModelLogin> modelsOfLogin = new ArrayList<ModelLogin>();
		String sqlQuery = "SELECT * FROM model_login WHERE upper(name) like upper(?) AND useradmin is false"
				+ " AND user_id_definition = ? order by id limit 5";

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, "%" + name + "%");
			statementQuery.setLong(2, currentAdminId);
			ResultSet resultQuery = statementQuery.executeQuery();

			while (resultQuery.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}

				modelsOfLogin.add(modelLogin);
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's name!\n\n");
			modelsOfLogin = null;
		}

		return modelsOfLogin;
	}

	public List<ModelLogin> consultUserByNamePaginated(String name, Long currentAdminId, String offset) {
		List<ModelLogin> modelsOfLogin = new ArrayList<ModelLogin>();
		String sqlQuery = "SELECT * FROM model_login WHERE upper(name) like upper(?) AND useradmin is false"
				+ " AND user_id_definition = ? order by id offset ? limit 5";

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, "%" + name + "%");
			statementQuery.setLong(2, currentAdminId);
			statementQuery.setLong(3, Integer.parseInt(offset));
			ResultSet resultQuery = statementQuery.executeQuery();

			while (resultQuery.next()) {
				ModelLogin modelLogin = new ModelLogin();

				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}

				modelsOfLogin.add(modelLogin);
			}

		} catch (Exception e) {
			System.out.println("\nWe had a problem to search a user's name!\n\n");
			modelsOfLogin = null;
		}

		return modelsOfLogin;
	}

	public int totalPages(Long currentAdminId) {
		Double howManyPages = 0.0;
		String sqlQuery = "select count(1) as totalpages from model_login where user_id_definition = ?";

		try {

			PreparedStatement statement = connection.prepareStatement(sqlQuery);
			statement.setLong(1, currentAdminId);

			ResultSet result = statement.executeQuery();
			result.next();

			Double totalRegistrations = result.getDouble("totalpages");
			howManyPages = totalRegistrations / 5.0;

			if (howManyPages % 2 > 0) {
				howManyPages+=1;
			}

		} catch (Exception ex) {

			try {
				connection.rollback();
			} catch (Exception e) {
				System.out.println("It was not possible realize the DB rollBack in totalPages Method...");
				e.printStackTrace();
			}

			howManyPages = 0.0;
			System.out.println("We had a problem while tried to execute totalPages Method...");
			ex.printStackTrace();
		}

		return howManyPages.intValue();
	}

	public List<ModelLogin> consultAllUsersPaged(Long currentAdminId, Integer offset) {
		List<ModelLogin> allUsersInfos = new ArrayList<ModelLogin>();

		String sqlQuery = "SELECT * FROM model_login WHERE useradmin is false AND user_id_definition = ? order by id offset ? limit 5";

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setLong(1, currentAdminId);
			statementQuery.setInt(2, offset);
			ResultSet resultQuery = statementQuery.executeQuery();

			while (resultQuery.next()) {
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}

				allUsersInfos.add(modelLogin);
			}

		} catch (Exception e) {
			allUsersInfos = null;
			System.out.println("\nWe had a problem with the query of all users in DB!\n\n");
			e.printStackTrace();
		}

		return allUsersInfos;
	}
	
	public List<ModelLogin> consultAllUsersToReport(Long currentAdminId, String startDate, String endDate, DAOPhoneRepository daoPhones) {
		List<ModelLogin> allUsersInfos = new ArrayList<ModelLogin>();

		String sqlQuery = "SELECT * FROM model_login WHERE useradmin is false AND user_id_definition = ? AND userbirthday >= ?"
				+ " AND userbirthday <= ? order by userbirthday;";

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setLong(1, currentAdminId);
			statementQuery.setString(2, startDate);
			statementQuery.setString(3, endDate);
			ResultSet resultQuery = statementQuery.executeQuery();

			while (resultQuery.next()) {
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				modelLogin.setUserPhones( daoPhones.phoneList( modelLogin.getId() ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}

				allUsersInfos.add(modelLogin);
			}

		} catch (Exception e) {
			allUsersInfos = null;
			System.out.println("\nWe had a problem with the query of all users to Report in DB!\n\n");
			e.printStackTrace();
			System.out.println( e.getMessage() );
		}

		return allUsersInfos;
	}

	public List<ModelLogin> consultAllUsers(Long currentAdminId) {
		List<ModelLogin> allUsersInfos = new ArrayList<ModelLogin>();

		String sqlQuery = "SELECT * FROM model_login WHERE useradmin is false AND user_id_definition = ? order by id limit 5";

		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setLong(1, currentAdminId);
			ResultSet resultQuery = statementQuery.executeQuery();

			while (resultQuery.next()) {
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setId(resultQuery.getLong("id"));
				modelLogin.setName(resultQuery.getString("name"));
				modelLogin.setEmail(resultQuery.getString("email"));
				modelLogin.setLogin(resultQuery.getString("login"));
				modelLogin.setPassword(resultQuery.getString("password"));
				modelLogin.setUserAdmin(resultQuery.getBoolean("useradmin"));
				modelLogin.setPerfil(resultQuery.getString("perfil"));
				modelLogin.setGender(resultQuery.getString("gender"));
				modelLogin.setCep(resultQuery.getString("cep"));
				modelLogin.setStreet(resultQuery.getString("street"));
				modelLogin.setNumber(resultQuery.getString("number"));
				modelLogin.setCity(resultQuery.getString("city"));
				modelLogin.setNeighborhood(resultQuery.getString("neighborhood"));
				modelLogin.setState(resultQuery.getString("state"));
				modelLogin.setMonthlyIncome( BigDecimal.valueOf( resultQuery.getDouble("monthlyincome") ) );
				
				if( resultQuery.getString("userbirthday") != null ){
					modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(resultQuery.getString("userbirthday")));
				} else {
					modelLogin.setUserBirthday( new Date() );
				}

				allUsersInfos.add(modelLogin);
			}

		} catch (Exception e) {
			allUsersInfos = null;
			System.out.println("\nWe had a problem with the query of all users in DB!\n\n");
			e.printStackTrace();
		}

		return allUsersInfos;
	}

	public boolean loginExists(String userInformation) {
		String sql = "SELECT count(1) > 0 as exist FROM model_login WHERE upper(login) = upper(?)";

		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, userInformation);
			ResultSet resultQuery = statement.executeQuery();

			resultQuery.next();
			return resultQuery.getBoolean("exist");

		} catch (Exception e) {
			System.out.println("Hey! We hada a problem here, budy! We couldn't validate the login");
			e.printStackTrace();
			return false;
		}
	}

	public boolean emailExists(String userInformation) {
		String sql = "SELECT count(1) > 0 as exist FROM model_login WHERE upper(email) = upper(?)";

		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, userInformation);
			ResultSet resultQuery = statement.executeQuery();

			resultQuery.next();
			return resultQuery.getBoolean("exist");

		} catch (Exception e) {
			System.out.println("Hey! We hada a problem here, budy! We couldn't validate the login");
			e.printStackTrace();
			return false;
		}
	}

	public String[] deleteUser(String login) {
		String sqlQuery = "DELETE from model_login WHERE upper(login) = upper(?) AND useradmin is false";
		String[] messageOfConnection = new String[2];

		try {

			if (loginExists(login)) {
				PreparedStatement statement = connection.prepareStatement(sqlQuery);
				statement.setString(1, login);

				statement.executeUpdate();
				connection.commit();

				messageOfConnection[0] = "User " + login + " was excluded successfully!!";
				messageOfConnection[1] = "text-warning";

			} else {
				messageOfConnection[0] = "User doesn't exist!!";
				messageOfConnection[1] = "text-danger";
			}

		} catch (Exception ex) {

			try {
				connection.rollback();
			} catch (Exception e) {
				System.out.println("\nWe had an error on DAOUserRegisterRepository class\n"
						+ "Error while tried to make a rollback in delete method!!\n\n");
				e.printStackTrace();
			}

			messageOfConnection[0] = ex.getMessage();
			messageOfConnection[1] = "text-danger";
			System.out.println("\nWe had an error on DAOUserRegisterRepository class\n"
					+ "Error while tried to make a query to delete datas\n\n");
			ex.printStackTrace();
		}

		return messageOfConnection;
	}

	public String[] updateUser(ModelLogin modelLogin, Long currentUserId) {
		String sqlQuery = "UPDATE model_login SET login = lower(?), password = ?, name = lower(?),"
				+ " email = lower(?), user_id_definition = ?, perfil = upper(?), gender = upper(?), cep = ?,"
				+ " street = lower(?), number = ?, city = lower(?), neighborhood = lower(?), state = lower(?), userbirthday = ?,"
				+ " monthlyincome = trunc(CAST(? AS numeric), 2)"
				+ " WHERE upper(email) = upper(?) OR upper(login) = upper(?)";
		String[] messageOfConnection = new String[2];
		
		try {
			PreparedStatement statementQuery = connection.prepareStatement(sqlQuery);
			statementQuery.setString(1, modelLogin.getLogin());
			statementQuery.setString(2, modelLogin.getPassword());
			statementQuery.setString(3, modelLogin.getName());
			statementQuery.setString(4, modelLogin.getEmail());
			statementQuery.setLong(5, currentUserId);
			statementQuery.setString(6, modelLogin.getPerfil());
			statementQuery.setString(7, modelLogin.getGender());
			statementQuery.setString(8, modelLogin.getCep());
			statementQuery.setString(9, modelLogin.getStreet());
			statementQuery.setString(10, modelLogin.getNumber());
			statementQuery.setString(11, modelLogin.getCity());
			statementQuery.setString(12, modelLogin.getNeighborhood());
			statementQuery.setString(13, modelLogin.getState());
			statementQuery.setString(14, modelLogin.getUserBirthday() );
			statementQuery.setBigDecimal(15, modelLogin.getMonthlyIncome());

			// HERE IS THE VALIDATION PART - THE DB WILL SEARCH FOR THE E-MAIL AND LOGIN
			// PASSED FOR USER
			statementQuery.setString(16, modelLogin.getEmail());
			statementQuery.setString(17, modelLogin.getLogin());

			if (loginExists(modelLogin.getLogin()) || emailExists(modelLogin.getEmail())) {
				statementQuery.execute();
				connection.commit();

				messageOfConnection[0] = "User updated successfully!!";
				messageOfConnection[1] = "text-success";

			} else {
				messageOfConnection[0] = "User doesn't exists!";
				messageOfConnection[1] = "text-danger";
			}

			if ((modelLogin.getUserPhoto() != null && !modelLogin.getUserPhoto().isEmpty())
					&& (modelLogin.getExtentionUserPhoto() != null && !modelLogin.getExtentionUserPhoto().isEmpty())) {
				sqlQuery = "update model_login set userphoto = ?, extentionuserphoto = ? WHERE login = ?";
				statementQuery = connection.prepareStatement(sqlQuery);
				statementQuery.setString(1, modelLogin.getUserPhoto());
				statementQuery.setString(2, modelLogin.getExtentionUserPhoto());
				statementQuery.setString(3, modelLogin.getLogin());

				statementQuery.execute();
				connection.commit();
			}

		} catch (Exception ex) {

			try {
				connection.rollback();
			} catch (Exception e) {
				System.out.println("\nWe had an error on DAOUserRegisterRepository class\n"
						+ "Error while tried to make a rollback in update method!!\n\n");
				e.printStackTrace();
			}

			messageOfConnection[0] = ex.getMessage();
			messageOfConnection[1] = "text-danger";
			System.out.println("\nWe had an error on DAOUserRegisterRepository class\n"
					+ "Error while tried to make a query to update datas\n\n");
			ex.printStackTrace();
		}

		return messageOfConnection;
	}
	
	//This method was not used yet
	public long calculateUserAge(String userBirthDay) {
		
		String[] userBirthDayFormated = userBirthDay.split("-");
		int[] birthDayIntArray = new int[3];
		long userAge;
		
		for(int position = 0; position < userBirthDayFormated.length; position++) {
			birthDayIntArray[position] = Integer.parseInt( userBirthDayFormated[position] );
		}
		
		// YEAR, MONTH, DAY
		LocalDate informedBirthday = LocalDate.of(birthDayIntArray[0], birthDayIntArray[1], birthDayIntArray[2]);
		LocalDate today = LocalDate.now();
		
		try {
			
			userAge = ChronoUnit.YEARS.between(informedBirthday, today);
		
		} catch (Exception e) {
			userAge = 0;
		}
		
		return userAge;
	}

}
