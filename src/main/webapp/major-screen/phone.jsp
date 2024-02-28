<%@ page import="jakarta.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="model.ModelLogin"%>

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
											<div class="card">
												<div class="card-header">
													<h3>Phones User -> ${ modelLogin.name.toUpperCase() }</h3>
													<h4 class="${status}">${msg}</h4>
												</div>

												<br /> <br />

												<div class="card-block">
													<form id="phones-form" action="<%=request.getContextPath()%>/ServletUserPhones"
														method="post" class="form-material">

														<!-- ID -->
														<div class="form-group form-default form-static-label">
															<input type="text" name="idUser" readonly="readonly"
																class="form-control text-secondary" id="idUser" value="${ modelLogin.id }">
															<span class="form-bar"></span> <label class="float-label">USER ID
																(ONLY TO READ)</label>
														</div>

														<br />
														
														<!-- Name -->
														<div class="form-group form-default form-static-label">
															<input type="text" name="name" class="form-control text-secondary"
																required="required" id="name" value="${ modelLogin.name }" readonly="readonly">
															<span class="form-bar"></span> <label class="float-label">NAME (ONLY TO READ)</label>
														</div>
														
														<br />
														
														<!-- Phone Number -->
														<div class="form-group form-info form-static-label">
															<input type="text" name="numberPhone" class="form-control"
																required="required" id="numberPhone" value="${ phoneNumber }">
															<span class="form-bar"></span> <label class="float-label">PHONE NUMBER</label>
														</div>
														
														<input
															class="btn hor-grd btn-grd-disabled btn-disabled btn-skew"
															name="button" id="saveNumber-button" type="submit" value="Save"
															onmouseover="phoneFieldValidator()" disabled>					

													</form>
												</div>
											
											</div>
											
											<!-- START OF PHONE LIST -->
											<div class="card-block"
												style="height: 312px; overflow: scroll;">
												<table class="table" id="list-users">
													<thead>
														<tr>
															<th scope="col">Name</th>
															<th scope="col">e-Mail</th>
															<th scope="col">Phone</th>
															<th scope="col">Exclude</th>
														</tr>
													</thead>

													<tbody>
														<c:forEach items="${listOfPhones}" var="currentPhone">
															<tr>
																<td><c:out value="${currentPhone.userId.name}"></c:out></td>
																<td><c:out value="${currentPhone.userId.email}"></c:out></td>
																<td><c:out value="${currentPhone.numberPhone}"></c:out></td>
																<td><a class="btn btn-danger"
																	href="<%= request.getContextPath() %>/ServletUserPhones?action=exclude&id=${currentPhone.phoneId}&idUser=${modelLogin.id}">Delete</a>
																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<!-- END OF PHONE LIST -->

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
