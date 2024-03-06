package servlets;

import java.io.IOException;
import java.util.List;

import dao.DAOPhoneRepository;
import dao.DAOUserRegisterRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;
import model.ModelPhone;

@WebServlet(urlPatterns = { "/ServletUserPhones" })
public class ServletUserPhones extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOUserRegisterRepository daoUser = new DAOUserRegisterRepository();
	DAOPhoneRepository daoPhone = new DAOPhoneRepository();

	public ServletUserPhones() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			Long userIdInSession = Long.parseLong(request.getSession().getAttribute("id").toString());
			String idUser = request.getParameter("idUser");
			String action = request.getParameter("action");

			if (action != null && !action.isEmpty() && action.equalsIgnoreCase("exclude")) {
				String idPhone = request.getParameter("id");
				String[] answerOfQuery = daoPhone.deletePhone(Long.parseLong(idPhone));

				ModelLogin modelLogin = daoUser.consultUserById(Long.parseLong(idUser));
				List<ModelPhone> listOfPhones = daoPhone.phoneList(Long.parseLong(idUser));

				request.setAttribute("listOfPhones", listOfPhones);
				request.setAttribute("modelLogin", modelLogin);
				request.setAttribute("status", answerOfQuery[0]);
				request.setAttribute("msg", answerOfQuery[1]);
				request.getRequestDispatcher("major-screen/phone.jsp").forward(request, response);
			}

			else if (idUser != null && !idUser.isEmpty() && (action == null || action.isEmpty())) {
				ModelLogin modelLogin = daoUser.consultUserById(Long.parseLong(idUser));
				List<ModelPhone> listOfPhones = daoPhone.phoneList(Long.parseLong(idUser));

				request.setAttribute("modelLogin", modelLogin);
				request.setAttribute("listOfPhones", listOfPhones);
				request.setAttribute("status", "text-info");
				request.setAttribute("msg", "Phone Loaded Below!");
				request.getRequestDispatcher("major-screen/phone.jsp").forward(request, response);

			} else {
				int dataFrequency = Integer.parseInt(request.getParameter("dataFrequency"));
				List<ModelLogin> listOfUsers = daoUser.consultAllUsersPaged(userIdInSession, dataFrequency);
				request.setAttribute("listOfUsers", listOfUsers);
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);
			}

		} catch(NullPointerException nullException) {
			
			//Here is to add in url attribute a value to send user again after he do the
			//login.
			RequestDispatcher redirect = request.getRequestDispatcher("/index.jsp");
			request.setAttribute("msg", "Please, login first!");
			redirect.forward(request, response);
			
			return;
			
		} catch (Exception ex) {
			ex.printStackTrace();
			request.setAttribute("msg", "Oh noh! We had a problem to execute your request...\n\n" + ex.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			Long userId = Long.parseLong(request.getParameter("idUser"));
			Long userIdInSession = Long.parseLong(request.getSession().getAttribute("id").toString());
			String numberPhone = request.getParameter("numberPhone");
			String button = request.getParameter("button");
			ModelPhone modelPhone = new ModelPhone();

			if (button.equalsIgnoreCase("save")) {
				if (numberPhone != null && !numberPhone.isEmpty()) {
					modelPhone.setNumberPhone(numberPhone);
					modelPhone.setUserId(daoUser.consultUserById(userId));
					modelPhone.setUserCadId(daoUser.consultUserByIdIncludinAdmin(userIdInSession));

					String[] answerOfQuery = daoPhone.savePhone(modelPhone);

					List<ModelPhone> listOfPhones = daoPhone.phoneList(userId);

					request.setAttribute("listOfPhones", listOfPhones);
					request.setAttribute("modelLogin", daoUser.consultUserById(userId));
					request.setAttribute("phoneNumber", modelPhone.getNumberPhone());
					request.setAttribute("status", answerOfQuery[0]);
					request.setAttribute("msg", answerOfQuery[1]);
					request.getRequestDispatcher("major-screen/phone.jsp").forward(request, response);

				} else {
					request.setAttribute("modelLogin", daoUser.consultUserById(userId));
					request.setAttribute("status", "text-danger");
					request.setAttribute("msg", "Please, enter a valid value in Phone Number Field!");
					request.getRequestDispatcher("major-screen/phone.jsp").forward(request, response);
				}

			}
			
		} catch (Exception ex) {
			ex.printStackTrace();
			request.setAttribute("msg", "Oh noh! We had a problem to execute your request...\n\n" + ex.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
		
	}

}
