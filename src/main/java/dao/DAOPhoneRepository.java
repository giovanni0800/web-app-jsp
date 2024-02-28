package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionDb;
import model.ModelPhone;

public class DAOPhoneRepository {

	private Connection connection;
	DAOUserRegisterRepository daoUser;

	public DAOPhoneRepository() {
		connection = SingleConnectionDb.getConnection();
		daoUser = new DAOUserRegisterRepository();
	}

	public List<ModelPhone> phoneList(Long id) {

		List<ModelPhone> listModelPhone = new ArrayList<ModelPhone>();

		String sqlQuery = "SELECT * FROM phone WHERE user_id = ?";
		try {
			PreparedStatement statement = connection.prepareStatement(sqlQuery);
			statement.setLong(1, id);

			ResultSet result = statement.executeQuery();

			while (result.next()) {

				ModelPhone modelPhone = new ModelPhone();
				modelPhone.setPhoneId(result.getLong("id"));
				modelPhone.setNumberPhone(result.getString("numberphone"));
				modelPhone.setUserId(daoUser.consultUserById(result.getLong("user_id")));
				modelPhone.setUserCadId(daoUser.consultUserById(result.getLong("user_cad_id")));

				listModelPhone.add(modelPhone);

			}

		} catch (Exception ex) {

			try {
				connection.rollback();
			} catch (Exception e) {
				System.out.println("Problem with rollback in DAOPhoneRepository!");
				e.printStackTrace();
			}

			ex.printStackTrace();
		}

		return listModelPhone;
	}

	public boolean phoneExists(String userPhone) {
		String sql = "SELECT count(1) > 0 as exist FROM phone WHERE numberphone = ?";

		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setString(1, userPhone);
			ResultSet resultQuery = statement.executeQuery();

			resultQuery.next();
			return resultQuery.getBoolean("exist");

		} catch (Exception e) {
			System.out.println("Hey! We hada a problem here, budy! We couldn't validate the phone number");
			e.printStackTrace();
			return false;
		}
	}

	public boolean idExists(Long id) {
		String sql = "SELECT count(1) > 0 as exist FROM phone WHERE id = ?";

		try {
			PreparedStatement statement = connection.prepareStatement(sql);
			statement.setLong(1, id);
			ResultSet resultQuery = statement.executeQuery();

			resultQuery.next();
			return resultQuery.getBoolean("exist");

		} catch (Exception e) {
			System.out.println("Hey! We hada a problem here, budy! We couldn't validate the phone number");
			e.printStackTrace();
			return false;
		}
	}

	public String[] savePhone(ModelPhone modelPhone) {

		String sqlQuery = "INSERT INTO phone (numberphone, user_id, user_cad_id) VALUES (?, ?, ?)";
		String[] answerOfQuery = new String[2];

		try {

			if (!phoneExists( modelPhone.getNumberPhone() ) ) {
				PreparedStatement statement = connection.prepareStatement(sqlQuery);
				statement.setString(1, modelPhone.getNumberPhone());
				statement.setLong(2, modelPhone.getUserId().getId());
				statement.setLong(3, modelPhone.getUserCadId().getId());

				statement.execute();
				connection.commit();

				answerOfQuery[0] = "text-success";
				answerOfQuery[1] = "Phone Number Saved successfully!";

			} else {
				answerOfQuery[0] = "text-danger";
				answerOfQuery[1] = "Phone Number Already Exists in User List!";
			}

		} catch (Exception ex) {

			try {
				connection.rollback();
			} catch (Exception e) {
				System.out.println("Problem with rollback in DAOPhoneRepository!");
				e.printStackTrace();
			}

			System.out.println(
					"\nWe had a proble while tried to save user phone in savePhone method -> DAOPhoneRepository\n\n");
			ex.getMessage();
			ex.printStackTrace();
		}

		return answerOfQuery;

	}

	public String[] deletePhone(Long id) {
		String sqlQuery = "DELETE FROM phone WHERE id = ?";
		String[] answerOfQuery = new String[2];

		try {
			if (idExists(id)) {
				PreparedStatement statement = connection.prepareStatement(sqlQuery);
				statement.setLong(1, id);

				statement.executeUpdate();
				connection.commit();
				
				answerOfQuery[0] = "text-warning";
				answerOfQuery[1] = "Phone Number Excluded successfully!";
			
			} else {
				answerOfQuery[0] = "text-danger";
				answerOfQuery[1] = "Phone Number Doesn't exists!";
			}

		} catch (Exception ex) {

			try {
				connection.rollback();
			} catch (Exception e) {
				System.out.println("Problem with rollback in DAOPhoneRepository!");
				e.printStackTrace();
			}

			ex.printStackTrace();
		}

		return answerOfQuery;
	}

}
