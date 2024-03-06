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
import util.ReportUtil;

@WebServlet(urlPatterns = { "/ServletPrintUserReport" })
public class ServletPrintUserReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
	DAOUserRegisterRepository daoUser;
	DAOPhoneRepository daoPhone;

	public ServletPrintUserReport() {
		daoUser = new DAOUserRegisterRepository();
		daoPhone = new DAOPhoneRepository();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		try {

			String action = request.getParameter("action");
			Long currentUserInSystem = (Long) request.getSession().getAttribute("id");

			if ( action != null && !action.isEmpty() && action.equalsIgnoreCase("printUserReport") ) {
				String startDate = request.getParameter("start-date-searcher");
				String endDate = request.getParameter("end-date-searcher");
				
				List<ModelLogin> listOfUsers = null;

				if ( ( startDate == null || startDate.isEmpty() ) && ( endDate == null || endDate.isEmpty() ) ) {

					listOfUsers = daoUser.consultAllUsersToReport(currentUserInSystem, daoPhone);
					
					request.setAttribute("listOfUsers", listOfUsers);
					request.setAttribute("howManyUsers", listOfUsers.size());
					request.setAttribute("status", "text-success");
					request.setAttribute("msg", "Research done!");

				} else if( ( startDate != null && !startDate.isEmpty() ) && ( endDate != null && !endDate.isEmpty() ) ) {
					
					listOfUsers = daoUser.consultAllUsersToReport(currentUserInSystem, startDate,
							endDate, daoPhone);

					request.setAttribute("startDate", startDate);
					request.setAttribute("endDate", endDate);
					request.setAttribute("listOfUsers", listOfUsers);
					request.setAttribute("howManyUsers", listOfUsers.size());
					request.setAttribute("status", "text-success");
					request.setAttribute("msg", "Research done!");
					
				} else {
					request.setAttribute("status", "text-danger");
					request.setAttribute("msg", "Please, enter a value on both fields or no one to search!");
				}

				request.getRequestDispatcher("major-screen/users.jsp").forward(request, response);

			} else if ( action != null && !action.isEmpty() && action.equalsIgnoreCase("printReportPDF") ) {
				String startDate = request.getParameter("start-date-searcher");
				String endDate = request.getParameter("end-date-searcher");
				
				List<ModelLogin> allUsersInformations = null;
				
				if( ( startDate == null || startDate.isEmpty() ) && ( endDate == null || endDate.isEmpty() ) ) {
					
					allUsersInformations = daoUser.consultAllUsersToReport(currentUserInSystem, daoPhone);
					
				} else if( ( startDate != null && !startDate.isEmpty() ) && ( endDate != null && !endDate.isEmpty() ) ) {
					
					allUsersInformations = daoUser.consultAllUsersToReport(currentUserInSystem, startDate, endDate, daoPhone);
					
				} else {
					request.setAttribute("status", "text-danger");
					request.setAttribute("msg", "Please, enter a value on both fields or no one to search!");
					request.getRequestDispatcher("major-screen/users.jsp").forward(request, response);
					return;
				}
				
				byte[] report  = new ReportUtil().generateReportPDF(allUsersInformations, "report-user-jsp", request.getServletContext() );
				
				response.setHeader("Content-Disposition", "attachment;filename=usersInformationsPDF");
				response.getOutputStream().write(report);
				
			} else {
				request.setAttribute("status", "text-danger");
				request.setAttribute("msg",
						"Unable to perform desired request... The action parameter was not defined...");
				request.getRequestDispatcher("major-screen/users.jsp").forward(request, response);
			}

		} catch(NullPointerException nullException) {
			
			//Here is to add in url attribute a value to send user again after he do the
			//login.
			RequestDispatcher redirect = request.getRequestDispatcher("/index.jsp?url=/major-screen/users.jsp");
			request.setAttribute("status", "text-danger");
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
	}

}
