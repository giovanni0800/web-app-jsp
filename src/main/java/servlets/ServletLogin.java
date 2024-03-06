package servlets;

import java.io.IOException;

import dao.DAOLoginRepository;
import dao.DAOUserRegisterRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;

/*Servlets or Controllers are same things*/
@WebServlet(urlPatterns = { "/ServletLogin", "/major-screen/ServletLogin" })
public class ServletLogin extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private DAOLoginRepository daoLoginRepository = new DAOLoginRepository();
	private DAOUserRegisterRepository daoUser = new DAOUserRegisterRepository();

	public ServletLogin() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("action");

			if ( action != null && !action.isEmpty()
					&& action.equalsIgnoreCase("Logout") ) {
				request.getSession().invalidate();
				RequestDispatcher redirect = request.getRequestDispatcher("index.jsp");
				redirect.forward(request, response);

			} else {
				doPost(request, response);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			request.setAttribute("msg", "Oh noh! We had a problem to execute your request...\n\n" + ex.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String login = request.getParameter("login");
			String password = request.getParameter("password");
			String url = request.getParameter("url");

			if (login != null && !login.isEmpty() && password != null && !password.isEmpty()) {
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setLogin(login);
				modelLogin.setPassword(password);

				if (daoLoginRepository.userAuthentication(modelLogin)) {
					ModelLogin isUserAdmin = daoUser.consultUserByLogin(modelLogin.getLogin());

					// Login Part
					request.getSession().setAttribute("id", daoLoginRepository.returnUserId(modelLogin.getLogin()));
					request.getSession().setAttribute("user", modelLogin.getLogin().toLowerCase());
					request.getSession().setAttribute("userImage",
							daoUser.consultUserByLogin(modelLogin.getLogin()).getUserPhoto());
					request.getSession().setAttribute("perfil", isUserAdmin.getPerfil());
					/*
					 * HERE IS POSSIBLE MAKE A VALIDATION TO SHOW FIELDS OF CUSTOMER BASE ONLY TO
					 * ADMINS PERFILS TOO request.getSession().setAttribute("isAdmin",
					 * isUserAdmin.getUserAdmin());
					 */

					if (url == null || url.equals("null")) {
						url = "major-screen/major.jsp";
					}

					RequestDispatcher redirect = request.getRequestDispatcher(url);
					redirect.forward(request, response);

				} else {
					RequestDispatcher redirect = request.getRequestDispatcher("/index.jsp");
					request.setAttribute("msg", "Please, enter a valid user and password!");
					redirect.forward(request, response);
				}

			} else {
				RequestDispatcher redirect = request.getRequestDispatcher("/index.jsp");
				request.setAttribute("msg", "Please, all fields must be filled!");
				redirect.forward(request, response);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
			RequestDispatcher redirect = request.getRequestDispatcher("/error.jsp");
			request.setAttribute("msg", "Oh noh! We had a problem to execute your request...\n\n" + ex.getMessage());
			redirect.forward(request, response);
		}

	}

}
