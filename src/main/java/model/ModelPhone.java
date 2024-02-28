package model;

import java.io.Serializable;

public class ModelPhone implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long phoneId;
	private String numberPhone;
	private ModelLogin userId;
	private ModelLogin userCadId;

	public Long getPhoneId() {
		return phoneId;
	}

	public void setPhoneId(Long phoneId) {
		this.phoneId = phoneId;
	}

	public String getNumberPhone() {
		return numberPhone;
	}

	public void setNumberPhone(String numberPhone) {
		this.numberPhone = numberPhone;
	}

	public ModelLogin getUserId() {
		return userId;
	}

	public void setUserId(ModelLogin userId) {
		this.userId = userId;
	}

	public ModelLogin getUserCadId() {
		return userCadId;
	}

	public void setUserCadId(ModelLogin userCadId) {
		this.userCadId = userCadId;
	}

}
