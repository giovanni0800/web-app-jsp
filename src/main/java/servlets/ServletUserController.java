package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.compress.utils.IOUtils;
import org.apache.tomcat.util.codec.binary.Base64;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.DAOUserRegisterRepository;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.ModelLogin;

//Will prepare the servlet to Upload
@MultipartConfig
@WebServlet(urlPatterns = { "/ServletUserController" })
public class ServletUserController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private DAOUserRegisterRepository daoUser = new DAOUserRegisterRepository();

	public ServletUserController() {
	}

	@SuppressWarnings("static-access")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		try {
			String[] messageOfConnection = new String[2];
			Long userIdInSession = Long.parseLong( request.getSession().getAttribute("id").toString() );

			if (action != null && !action.isEmpty() && action.equalsIgnoreCase("exclude")) {
				String loginUser = request.getParameter("login");
				List<ModelLogin> listOfUsers = daoUser.consultAllUsers(userIdInSession);

				// SELECT on DB and Delete are used on GET method
				messageOfConnection = daoUser.deleteUser(loginUser);

				request.setAttribute("modelLogins", listOfUsers);
				request.setAttribute("msg", messageOfConnection[0]);
				request.setAttribute("status", messageOfConnection[1]);
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);

			} else if (action != null && !action.isEmpty() && action.equalsIgnoreCase("exclude-ajax")) {
				String loginUser = request.getParameter("login");
				messageOfConnection = daoUser.deleteUser(loginUser);
				response.getWriter().write(messageOfConnection[0]);

			} else if (action != null && !action.isEmpty() && action.equalsIgnoreCase("search-user-by-ajax")) {
				String userName = request.getParameter("user-name");

				List<ModelLogin> userSearched = daoUser.consultUserByName(userName, userIdInSession);

				ObjectMapper javaToJsonAsString = new ObjectMapper();
				String json = javaToJsonAsString.writeValueAsString(userSearched);

				response.addHeader("totalPages", "" + daoUser.totalToShowInPaginationModal(userName, userIdInSession));
				response.getWriter().write(json);

			} else if (action != null && !action.isEmpty()
					&& action.equalsIgnoreCase("search-user-by-ajax-modal-pagination")) {
				String userName = request.getParameter("user-name");
				String page = request.getParameter("page");

				List<ModelLogin> userSearched = daoUser.consultUserByNamePaginated(userName, userIdInSession, page);

				ObjectMapper javaToJsonAsString = new ObjectMapper();
				String json = javaToJsonAsString.writeValueAsString(userSearched);

				response.addHeader("totalPages", "" + daoUser.totalToShowInPaginationModal(userName, userIdInSession));
				response.getWriter().write(json);

			} else if (action != null && !action.isEmpty() && action.equalsIgnoreCase("search-id-by-ajax")) {
				Long userId = Long.parseLong(request.getParameter("id"));
				List<ModelLogin> listOfUsers = daoUser.consultAllUsers(userIdInSession);

				request.setAttribute("modelLogins", listOfUsers);
				request.setAttribute("modelLogin", daoUser.consultUserById(userId, userIdInSession));
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);

			} else if (action != null && !action.isEmpty() && action.equalsIgnoreCase("listUsers")) {
				List<ModelLogin> listOfUsers = daoUser.consultAllUsers(userIdInSession);

				request.setAttribute("msg", "User list loaded below!");
				request.setAttribute("status", "text-info");
				request.setAttribute("modelLogins", listOfUsers);
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);

			} else if (action != null && !action.isEmpty() && action.equalsIgnoreCase("pagination")) {
				int dataFrequency = Integer.parseInt(request.getParameter("dataFrequency"));
				List<ModelLogin> listOfUsers = daoUser.consultAllUsersPaged(userIdInSession, dataFrequency);

				request.setAttribute("modelLogins", listOfUsers);
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);

			} else if (action != null && !action.isEmpty() && action.equalsIgnoreCase("photographyDownload")) {
				Long userIdToDownload = Long.parseLong(request.getParameter("id"));

				ModelLogin userPhotographyToDownload = daoUser.consultUserById(userIdToDownload, userIdInSession);

				if ((userPhotographyToDownload != null && userPhotographyToDownload.getUserPhoto() != null)
						&& !userPhotographyToDownload.getUserPhoto().isEmpty()) {

					response.setHeader("Content-Disposition",
							"attachment;filename=userPhotograpy." + userPhotographyToDownload.getExtentionUserPhoto());
					request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
					response.getOutputStream()
							.write(new Base64().decodeBase64(userPhotographyToDownload.getUserPhoto().split("\\,")[1]));
				}

			} else {
				int dataFrequency = Integer.parseInt(request.getParameter("dataFrequency"));
				List<ModelLogin> listOfUsers = daoUser.consultAllUsersPaged(userIdInSession, dataFrequency);
				request.setAttribute("modelLogins", listOfUsers);
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);
			}

		} catch(NullPointerException nullException) {
			HttpServletRequest requestHttp = (HttpServletRequest) request;
			String currentUrl = requestHttp.getServletPath();
			
			int dataFrequency;
			if( request.getParameter("dataFrequency") != null && !request.getParameter("dataFrequency").isEmpty() ) {
				dataFrequency = Integer.parseInt(request.getParameter("dataFrequency"));
			}else {
				dataFrequency = 0;
			}
			
			//Here is to add in url attribute a value to send user again after he do the
			//login.
			RequestDispatcher redirect = request.getRequestDispatcher("/index.jsp?url="
					+ currentUrl + "?action=" + action + "&dataFrequency=" + dataFrequency);
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

		String action = request.getParameter("action");
		
		try {
			
			Long userIdInSession = Long.parseLong( request.getSession().getAttribute("id").toString() );
			
			if (action != null && !action.isEmpty() && action.equalsIgnoreCase("listUsers")) {
				List<ModelLogin> listOfUsers = daoUser.consultAllUsers(userIdInSession);

				request.setAttribute("msg", "User list loaded below!");
				request.setAttribute("status", "text-info");
				request.setAttribute("modelLogins", listOfUsers);
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);

			} else if ( action != null && !action.isEmpty() && action.equalsIgnoreCase("pagination") ) {
				
				int dataFrequency;
				if( request.getParameter("dataFrequency") != null && !request.getParameter("dataFrequency").isEmpty() ) {
					dataFrequency = Integer.parseInt(request.getParameter("dataFrequency"));
				}else {
					dataFrequency = 0;
				}
				
				List<ModelLogin> listOfUsers = daoUser.consultAllUsersPaged(userIdInSession, dataFrequency);

				request.setAttribute("modelLogins", listOfUsers);
				request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				request.getRequestDispatcher("major-screen/customerBase.jsp").forward(request, response);

			} else {
				String id = request.getParameter("id");
				String name = request.getParameter("name");
				String cep = request.getParameter("cep");
				String street = request.getParameter("street");
				String number = request.getParameter("number");
				String city = request.getParameter("city");
				String neighborhood = request.getParameter("neighborhood");
				String state = request.getParameter("state");
				String email = request.getParameter("email");
				String login = request.getParameter("login");
				String password = request.getParameter("password");
				String perfil = request.getParameter("perfil");
				String gender = request.getParameter("genderRadio");
				String userBirthDay = request.getParameter("userBirthday");
				String wage = request.getParameter("wage");
				
				if( wage != null && !wage.isEmpty() ) {
					wage = wage.split("\\ ")[1].replaceAll("\\.", "").replaceAll("\\,", "\\.");
				
				} else {
					wage = "0.00";
				}
			
				String witchButtonClicked = request.getParameter("button");
	
				ModelLogin modelLogin = new ModelLogin();
				modelLogin.setId((id != null && !id.isEmpty()) ? Long.parseLong(id) : null);
				modelLogin.setName(name.toLowerCase());
				modelLogin.setCep(cep);
				modelLogin.setStreet(street);
				modelLogin.setNumber(number);
				modelLogin.setCity(city);
				modelLogin.setNeighborhood(neighborhood);
				modelLogin.setState(state);
				modelLogin.setEmail(email.toLowerCase());
				modelLogin.setMonthlyIncome(new BigDecimal(wage));
				modelLogin.setLogin(login.toLowerCase());
				modelLogin.setPassword(password);
				modelLogin.setPerfil(perfil);
				modelLogin.setGender(gender);
				modelLogin.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(userBirthDay));
	
				List<ModelLogin> listOfUsers = daoUser.consultAllUsers(userIdInSession);
	
				long userAge = daoUser.calculateUserAge(modelLogin.getUserBirthday());
	
				if (userAge >= 18) {
	
					String[] statusOfDataBaseCommand = new String[2];
	
					if (request.getContentType() != null && request.getContentType().startsWith("multipart/")) {
	
						try {
							Part inputPart = request.getPart("filePhoto");
							if (inputPart != null) {
								InputStream inputStream = inputPart.getInputStream();
								if (inputStream.available() > 0) {
									byte[] photo = IOUtils.toByteArray(inputStream);
									String imageBase64 = "data:image/" + inputPart.getContentType().split("\\/")[1]
											+ ";base64," + new Base64().encodeAsString(photo);
									modelLogin.setUserPhoto(imageBase64);
									modelLogin.setExtentionUserPhoto(inputPart.getContentType().split("\\/")[1]);
								}
							}
	
						} catch (Exception ex) {
							ex.printStackTrace();
						}
					}
	
					// Save and Update are send by POST method
					if (witchButtonClicked.equalsIgnoreCase("save")) {
						statusOfDataBaseCommand = daoUser.saveNewUserOnDB(modelLogin, userIdInSession);
	
					} else if (witchButtonClicked.equalsIgnoreCase("update")) {
						statusOfDataBaseCommand = daoUser.updateUser(modelLogin, userIdInSession);
					}
	
					request.setAttribute("msg", statusOfDataBaseCommand[0]);
					request.setAttribute("status", statusOfDataBaseCommand[1]);
					request.setAttribute("msgAboutUserAge", "The user is of legal age");
					request.setAttribute("statusUserAge", "text-success");
					request.setAttribute("modelLogin", daoUser.consultUserByLogin(modelLogin.getLogin(), userIdInSession));
					request.setAttribute("modelLogins", listOfUsers);
					request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
	
				} else {
					request.setAttribute("msg", "The user is underage!");
					request.setAttribute("status", "text-danger");
					request.setAttribute("msgAboutUserAge", "The user is underage!");
					request.setAttribute("statusUserAge", "text-danger");
					request.setAttribute("modelLogin", daoUser.consultUserByLogin(modelLogin.getLogin(), userIdInSession));
					request.setAttribute("modelLogins", listOfUsers);
					request.setAttribute("totalPages", daoUser.totalPages(userIdInSession));
				}
	
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

}
