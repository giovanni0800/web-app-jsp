package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOChartRepository;
import dto.DTOPerfilSalary;

@WebServlet(urlPatterns = { "/ServletChart" })
public class ServletChart extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DAOChartRepository daoChart;
	private DTOPerfilSalary dtoPerfilSalary;

	public ServletChart() {
		daoChart = new DAOChartRepository();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		try {
			Long userInSystem = (Long) request.getSession().getAttribute("id");
			String action = request.getParameter("action");

			if (action != null && !action.isEmpty() && action.equalsIgnoreCase("chart-request")) {
				String startDate = request.getParameter("startDate");
				String endDate = request.getParameter("endDate");

				if ( ( startDate == null || startDate.isEmpty() ) && ( endDate == null || endDate.isEmpty() ) ) {
					dtoPerfilSalary = daoChart.showTheAverageSalaryGraph(userInSystem);
					
					ObjectMapper mapper = new ObjectMapper();
					String jsonDatas = mapper.writeValueAsString( dtoPerfilSalary );
					
					response.getWriter().write( jsonDatas );
				
				} else if ( ( startDate != null && !startDate.isEmpty() ) && ( endDate != null && !endDate.isEmpty() ) ) {
					dtoPerfilSalary = daoChart.showTheAverageSalaryGraph( userInSystem, startDate, endDate );
					
					if( dtoPerfilSalary.getAverageSalaryClients().size() == 0 || dtoPerfilSalary.getPerfilList().size() == 0 ) {
						request.setAttribute("status", "text-danger");
						request.setAttribute("msg", "No data was found with the requested date!");
						request.getRequestDispatcher("major-screen/charts.jsp").forward(request, response);
					
					} else {
						ObjectMapper mapper = new ObjectMapper();
						String jsonDatas = mapper.writeValueAsString( dtoPerfilSalary );
						
						response.getWriter().write( jsonDatas );
					}
					
				} else {
					request.setAttribute("status", "text-danger");
					request.setAttribute("msg", "Please, enter a value on both fields or no one to search!");
					request.getRequestDispatcher("major-screen/charts.jsp").forward(request, response);
				}

			} else {
				request.setAttribute("status", "text-danger");
				request.setAttribute("msg", "Requested action is not available for processing. "
						+ "Please restart the page by pressing Ctrl + Shift + R. "
						+ "If the problem persists, please contact the development team!");
				request.getRequestDispatcher("major-screen/charts.jsp").forward(request, response);
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
	}

}
