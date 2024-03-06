package dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class DTOPerfilSalary implements Serializable {

	private static final long serialVersionUID = 1L;

	private List<Double> averageSalaryClients = new ArrayList<Double>();
	private List<String> perfilList = new ArrayList<String>();

	public List<Double> getAverageSalaryClients() {
		return averageSalaryClients;
	}

	public void setAverageSalaryClients(List<Double> averageSalaryClients) {
		this.averageSalaryClients = averageSalaryClients;
	}

	public List<String> getPerfilList() {
		return perfilList;
	}

	public void setPerfilList(List<String> perfilList) {
		this.perfilList = perfilList;
	}

}
