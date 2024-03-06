package model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ModelLogin implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id;
	private String name;
	private String email;
	private String login;
	private String password;
	private boolean userAdmin;
	private String perfil;
	private String gender;
	private String userPhoto;
	private String extentionUserPhoto;

	private String cep;
	private String street;
	private String number;
	private String city;
	private String neighborhood; // = Bairro
	private String state;

	private BigDecimal monthlyIncome;

	private Date userBirthday;
	
	private List<ModelPhone> userPhones;

	public String getUserBirthday() {
		return new SimpleDateFormat("yyyy-MM-dd").format(userBirthday);
	}

	public void setUserBirthday(Date userBirthday) {
		this.userBirthday = userBirthday;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getNeighborhood() {
		return neighborhood;
	}

	public void setNeighborhood(String neighborhood) {
		this.neighborhood = neighborhood;
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public String getExtentionUserPhoto() {
		return extentionUserPhoto;
	}

	public void setExtentionUserPhoto(String extentionUserPhoto) {
		this.extentionUserPhoto = extentionUserPhoto;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPerfil() {
		return perfil;
	}

	public void setPerfil(String perfil) {
		this.perfil = perfil;
	}

	public boolean getUserAdmin() {
		return userAdmin;
	}

	public void setUserAdmin(boolean userAdmin) {
		this.userAdmin = userAdmin;
	}

	public boolean isNew() {
		return id == null;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public BigDecimal getMonthlyIncome() {
		return monthlyIncome;
	}

	public void setMonthlyIncome(BigDecimal monthlyIncome) {
		this.monthlyIncome = monthlyIncome;
	}
	
	public void setUserPhones(List<ModelPhone> listOfPhones) {
		this.userPhones = listOfPhones;
	}
	
	public String getUserPhones(){
		String listOfUserPhones = "";
		
		for(ModelPhone currentUserPhone : userPhones) {
			listOfUserPhones += " ---> " + currentUserPhone.getNumberPhone();
		}
		
		return listOfUserPhones;
	}

	@Override
	public String toString() {
		return "\nUser_Infos -> [Id - " + getId() + ", Name - " + getName() + ", Email - " + getEmail() + ", Login - "
				+ getLogin() + ", Password - " + getPassword() + ", IsUserAdmin - " + getUserAdmin()
				+ ", What is the user profile - " + getPerfil() + "]\n\n";
	}

}
