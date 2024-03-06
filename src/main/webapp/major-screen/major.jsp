<%@page import="jakarta.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

<jsp:include page="head.jsp"></jsp:include>

<body>
	<jsp:include page="themeLoader.jsp"></jsp:include>

	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<jsp:include page="navbar.jsp"></jsp:include>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">
					<nav class="pcoded-navbar">
						<div class="sidebar_toggle">
							<a href="#"><i class="icon-close icons"></i></a>
						</div>
						<jsp:include page="sidebarPlataform.jsp"></jsp:include>
					</nav>
					<div class="pcoded-content">

						<jsp:include page="headerWayPage.jsp"></jsp:include>

						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">
										<div class="col-md-12">
											<div class="card-header">
												<h1>About the App</h1>
											</div>

											<br /> <br />

											<div class="card-block">
												<main>
													<h3 class="text-info ml-3 mt-4 mb-5">Layout</h3>
													<h4>About Project (Home Page)</h4>
													<p>The WebWorks Tech - User Administration System
														project aims to carry out CRUD operations for registering,
														updating, searching and deleting information relating to
														employees, such as name, email, login, password, phone
														numbers, among others informations. In addition, it is
														possible to generate reports with stored users and
														graphically monitor employees' salary status. To create
														the App, PostgreSQL tools (database) were used, along with
														JSP technologies along with JSTL (Java 17), Bootstrap 4.1
														and TomCat 10.1.x (Jakarta) libs.</p>
													<br /> <br />

													<h4>Register / Customer Base</h4>
													<p>Accessing the Customer Base, is possible to work
														with employees informations, here you can see all users in
														system, you can search for users, register, update
														informations, delete users and their phone numbers, and
														work in more detail with each user’s information.</p>
													<hr />
													<br />

													<h3 class="text-info ml-3 mt-4 mb-5">Record</h3>
													<h4>Users</h4>
													<p>In the users tab, it is possible to access more
														generic information such as: Name, e-Mail, Birth Day and
														Phones. Here it is possible to generate a PDF report with
														the information of registered users according to the
														searched dates of birth, or leaving the fields empty, a
														general report will be generated with all users stored in
														the database or show them on the screen.</p>
													<hr />
													<br />

													<h3 class="text-info ml-3 mt-4 mb-5">Chart</h3>
													<h4>Charts</h4>
													<p>By accessing the graphs tab, you can search for the
														average salary of employees according to their date of
														birth, or even search for a general average, leaving both
														fields empty</p>
													<hr />
													<br />

													<h3 class="text-info ml-3 mt-4 mb-5">Tips</h3>
													<h4>Tips to login or see your profile here</h4>
													<p>In the top right corner (also left, below the user's
														photo), you can access your user's profile and monitor
														their information or log out of the App.</p>
													<hr />
													<br />

												</main>

											</div>
										</div>
									</div>
									<!-- Page-body end -->
								</div>
								<div id="styleSelector"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="scripts.jsp"></jsp:include>

</body>

</html>