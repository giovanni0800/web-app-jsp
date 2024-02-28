package filter;

import java.io.IOException;
import java.sql.Connection;

import connection.SingleConnectionDb;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

//Intercepts all requests that come from the project or mapping
@WebFilter(urlPatterns = {"/major-screen/*"})
public class FilterAuthentication extends HttpFilter implements Filter {
       
    private static final long serialVersionUID = 1L;
    private static Connection connection;

	public FilterAuthentication() {
    }

	//Encerra determinados processos quando o servidor é parado
	//Exemplo -> Mata uma conexão com o banco de dados.
	public void destroy() {
		try {
			connection.close();
		} catch(Exception ex) {
			System.out.println("\n\tPROBLEM WHILE TRY TO CLOSE CONNECTION WITH DB!!\n\n");
			ex.printStackTrace();
		}
	}

	//É aqui onde tudo acontece (com relação a filtragem dos processos)!!!
	//Intercepta as requisições e as respostas no sistema
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
			HttpServletRequest requestHttp = (HttpServletRequest) request;
			HttpSession session = (HttpSession) requestHttp.getSession();
			
			String userInSession = (String) session.getAttribute("user");
			Long userId = Long.parseLong( session.getAttribute("id").toString() );
			
			String currentUrl = requestHttp.getServletPath();
			
			//Validating the user attributes and login status
			if(( userInSession == null || userId == null || 
					(userInSession != null && userInSession.isEmpty() ) )
					&& !currentUrl.contains("/major-screen/ServletLogin")) {
				
				//Here is to add in url attribute a value to send user again after he do the
				//login.
				RequestDispatcher redirect = request.getRequestDispatcher("/index.jsp?url=" +
					currentUrl);
				request.setAttribute("msg", "Please, login first!");
				redirect.forward(request, response);
				
				return;
			
			} else {
				//Here is to keep doing the system activities during this process
				chain.doFilter(request, response);
			}
			
			connection.commit();
		
		} catch(Exception ex) {
			System.out.println("\n\tPROBLEM IN FILTER AUTHENTICATION FILE!!\n\n");
			ex.printStackTrace();
			
			RequestDispatcher redirect = request.getRequestDispatcher("/error.jsp");
			request.setAttribute("msg", "Oh noh!\n\n" + ex.getMessage());
			redirect.forward(request, response);
			
			try {
				connection.rollback();
			} catch(Exception e) {
				System.out.println("\n\tPROBLEM IN ROLLBACK OF FILTER AUTHENTICATION FILE!!\n\n");
				e.printStackTrace();
				
				RequestDispatcher redirectProblemRollBack = request.getRequestDispatcher("/error.jsp");
				request.setAttribute("msg", "Oh noh!\n\n" + e.getMessage());
				redirectProblemRollBack.forward(request, response);
			}
		}
	}

	//Inicia processos ao iniciar o servidor
	//Exemplo -> Inicia uma conexão com o banco de dados
	public void init(FilterConfig fConfig) throws ServletException {
		connection = SingleConnectionDb.getConnection();
	}

}
