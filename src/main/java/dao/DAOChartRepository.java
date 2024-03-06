package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionDb;
import dto.DTOPerfilSalary;

public class DAOChartRepository {
	
	Connection connection;
	
	public DAOChartRepository() {
		connection = SingleConnectionDb.getConnection();
	}
	
	public DTOPerfilSalary showTheAverageSalaryGraph(Long userInSystem, String startDate, String endDate) {
		List<Double> averageSalaryList = new ArrayList<Double>();
		List<String> perfilList = new ArrayList<String>();
		DTOPerfilSalary dtoPerfilSalary = new DTOPerfilSalary();
		
		String sqlQuery = "SELECT avg(monthlyincome) as average_salary, perfil from model_login where user_id_definition = ? "
				+ "AND userbirthday >= ? AND userbirthday <= ? group by perfil";
		
		try {
			PreparedStatement statement = connection.prepareStatement(sqlQuery);
			statement.setDouble(1, userInSystem);
			statement.setString(2, startDate);
			statement.setString(3, endDate);
			
			ResultSet result = statement.executeQuery();
			
			while( result.next() ) {
				Double averageSalary = result.getDouble("average_salary");
				String perfil = result.getString("perfil");
				
				averageSalaryList.add(averageSalary);
				perfilList.add(perfil);
			}
			
			dtoPerfilSalary.setAverageSalaryClients(averageSalaryList);
			dtoPerfilSalary.setPerfilList(perfilList);
		
		}catch (Exception ex) {
			try {
				connection.rollback();
			
			}catch (Exception e) {
				System.out.println("We couldn't made rollback in PostgreSQL...");
			}
			
			System.out.println("We had a problem trying to execute the showTheAverageSalaryGraph method in DAOChartRepository...");
			ex.printStackTrace();

		}
		
		return dtoPerfilSalary;
	}

}
