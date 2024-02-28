package servlets;

import java.io.Serializable;

import dao.DAOUserRegisterRepository;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class ServletGenericUtil extends HttpServlet implements Serializable {

	private static final long serialVersionUID = 1L;
	private DAOUserRegisterRepository daoUser = new DAOUserRegisterRepository();
	
	public Long getIdUserLoged(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String currentLogedUser = (String) session.getAttribute("user");
		Long currentUserId = (Long) session.getAttribute("id");
		
		return daoUser.consultUserByLogin(currentLogedUser, currentUserId).getId();
	}

}
