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
													<h3>Customer Base</h3>
													<h4 class="${status}">${msg}</h4>
												</div>

												<br /> <br />

												<div class="card-block">

													<form id="my-form" enctype="multipart/form-data"
														action="<%=request.getContextPath()%>/ServletUserController"
														method="post" class="form-material" autocomplete="off">

														<!-- HERE MUST BE USED ONLY TO USE THE DEFAULT SUBMIT -> WHEN USE THE AJAX SUBMIT, HERE IS NOT NECESSARY
														BECAUSE, YOU CAN PASS THE PARAMS DIRECTLY BY URL, AND DON'T NEED A HIDDEN INPUT
														<input type="hidden" name="action" id="action">
														-->

														<!-- ID -->
														<div class="form-group form-default form-static-label">
															<input type="text" name="id" readonly="readonly"
																class="form-control text-secondary" id="id" value="${modelLogin.id}">
															<span class="form-bar"></span> <label class="float-label">ID
																(ONLY TO READ)</label>
														</div>

														<br />

														<!-- User Photo Field -->
														<div class="mb-5">
															<div class="input-group-prepend">
																<c:if test="${modelLogin.userPhoto != '' && modelLogin.userPhoto != null }">
																	<a href="<%= request.getContextPath() %>/ServletUserController?action=photographyDownload&id=${modelLogin.id}">
																		<img alt="User Image" src="${ modelLogin.userPhoto }" id="userPhoto" width="70px">
																	</a>
																</c:if>
																<c:if test="${modelLogin.userPhoto == '' || modelLogin.userPhoto == null}">
																	<img alt="User Image" src="<%= request.getContextPath() %>/assets/images/userImage.png" id="userPhoto" width="70px">
																</c:if>
															</div>

															<label for="formFileMultiple" class="form-label"><span
																class="form-bar"></span>Profile Image Upload</label> 
															<input
																class="form-control" name="filePhoto" type="file" accept="image/*" onchange="changeImage('userPhoto', 'formFileMultiple')" id="formFileMultiple"
																multiple autocomplete="off">
														</div>

														<br />

														<!-- Name -->
														<div class="form-group form-info form-static-label">
															<input type="text" name="name" class="form-control"
																required="required" id="name" value="${modelLogin.name}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">NAME</label>
														</div>
														
														<br />
														
														<!-- User BirthDay -->
														<div class="form-group form-info form-static-label">
															<input type="text" name="userBirthday" class="form-control text-primary"
																required id="userBirthday" value="${modelLogin.userBirthday}" autocomplete="off"
																placeholder="yyyy-mm-dd">
															<span class="form-bar"></span>
															<span class=" ${statusUserAge}">${msgAboutUserAge}</span>
															<label class="float-label">User Birthday</label>
														</div>
														
														<br />

														<!-- CEP -->
														<div class="form-group form-primary form-static-label">
															<input type="text" name="cep" class="form-control"
																required="required" id="cep" onblur="searchCep()" value="${modelLogin.cep}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">CEP</label>
														</div>
														
														<br />

														<!-- Street -->
														<div class="form-group form-primary form-static-label">
															<input type="text" name="street" class="form-control"
																required="required" id="street" value="${modelLogin.street}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">STREET</label>
														</div>
														
														<br />

														<!-- Number -->
														<div class="form-group form-primary form-static-label">
															<input type="text" name="number" class="form-control"
																required="required" id="number" value="${modelLogin.number}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">NUMBER</label>
														</div>
														
														<br />

														<!-- City -->
														<div class="form-group form-primary form-static-label">
															<input type="text" name="city" class="form-control"
																required="required" id="city" value="${modelLogin.city}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">CITY</label>
														</div>
														
														<br />

														<!-- Neighborhood -->
														<div class="form-group form-primary form-static-label">
															<input type="text" name="neighborhood" class="form-control"
																required="required" id="neighborhood" value="${modelLogin.neighborhood}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">NEIGHBORHOOD</label>
														</div>
														
																												<br />

														<!-- State -->
														<div class="form-group form-primary form-static-label">
															<input type="text" name="state" class="form-control"
																required="required" id="state" value="${modelLogin.state}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">STATE</label>
														</div>

														<br />

														<!-- e-Mail -->
														<div class="form-group form-info form-static-label">
															<input type="email" name="email" class="form-control"
																required="required" id="email"
																value="${modelLogin.email}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">e-MAIL</label>
														</div>
														
														<br />

														<!-- Wage with Mask Money -->
														<div class="form-group form-info form-static-label">
															<input type="text" name="wage" class="form-control"
																required="required" id="wage"
																value="${modelLogin.monthlyIncome}">
															<span class="form-bar"></span> <label class="float-label">WAGE R$</label>
														</div>

														<br />

														<!-- e-Mail -->
														<div class="form-group form-info form-static-label">
															<input type="text" name="login" class="form-control"
																required="required" id="login"
																value="${modelLogin.login}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">LOGIN</label>
														</div>

														<br />

														<!-- Password -->
														<div class="form-group form-info form-static-label">
															<input type="password" name="password"
																class="form-control" required="required" id="password"
																value="${modelLogin.password}" autocomplete="off">
															<span class="form-bar"></span> <label class="float-label">PASSWORD</label>
														</div>

														<div class="m-4">
															<input type="radio" value="MASCULINE" name="genderRadio"
																id="flexRadioMasculine" required
																<%ModelLogin userSelected = (ModelLogin) request.getAttribute("modelLogin");
																	if (userSelected != null && userSelected.getGender() != null && userSelected.getGender().equals("MASCULINE")) {
																		out.print(" ");
																		out.print("checked=\"checked\"");
																		out.print(" ");
																	}%>>
															<label for="flexRadioMasculine">Masculine </label> <input
																type="radio" value="FEMININE" name="genderRadio"
																id="flexRadioFeminine" required
																<%if (userSelected != null && userSelected.getGender() != null && userSelected.getGender().equals("FEMININE")) {
																	out.print(" ");
																	out.print("checked=\"checked\"");
																	out.print(" ");
																}%>>
															<label for="flexRadioFeminine">Feminine </label>
														</div>

														<br />

														<div class="form-group form-info form-static-label">
															<select class="form-control"
																aria-label=".form-select-lg example" name="perfil"
																id="perfil">

																<!-- DEFAULT OPTION -> Select the perfil -->
																<option disabled value="SelectPerfil"
																	<%if (userSelected == null) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>Select
																	the perfil</option>
																<!-- ADMIN OPTION -->
																<option value="ADMIN"
																	<%if (userSelected != null && userSelected.getPerfil() != null && userSelected.getPerfil().equals("ADMIN")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>Admin</option>
																<!-- SECRETARY OPTION -->
																<option value="SECRETARY"
																	<%if (userSelected != null && userSelected.getPerfil() != null && userSelected.getPerfil().equals("SECRETARY")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>Secretary</option>
																<!-- ASSISTANT OPTION -->
																<option value="ASSISTANT"
																	<%if (userSelected != null && userSelected.getPerfil() != null && userSelected.getPerfil().equals("ASSISTANT")) {
																		out.print(" ");
																		out.print("selected=\"selected\"");
																		out.print(" ");
																	}%>>Assistant</option>

															</select> <span class="form-bar"></span> <label
																class="float-label">PERFIL</label>
														</div>

														<input class="btn hor-grd btn-grd-info btn-skew"
															name="button" id="new-button" type="button" value="New"
															onclick="clearFields()">
														
														<input
															class="btn hor-grd btn-grd-disabled btn-disabled btn-skew"
															name="button" id="save-button" type="submit" value="Save"
															onmouseover="fieldsValidator()" disabled>
														
														<input
															class="btn hor-grd btn-grd-disabled btn-disabled btn-skew"
															name="button" id="exclude-button" type="button"
															value="Exclude" onmouseover="fieldsValidator()"
															onclick="sendExcludeRequestWithAjax()" disabled>

														<input
															class="btn hor-grd btn-grd-disabled btn-disabled btn-skew"
															name="button" id="update-button" type="submit"
															value="Update" onmouseover="fieldsValidator()" disabled>
															
														<c:if test="${ modelLogin.id > 0 }">
															<a href="<%= request.getContextPath() %>/ServletUserPhones?idUser=${modelLogin.id}" class="btn btn-light hor-grd btn-skew">Phone Number</a>
														</c:if>
														
														<button type="button"
															class="mt-4 btn btn-outline-dark btn-skew float-md-right"
															data-toggle="modal" data-target="#searchModal">
															<i class="fa fa-search"></i> Search for users
														</button>

													</form>

												</div>
											</div>

											<!-- START OF USER LIST -->
											<div class="card-block"
												style="height: 312px; overflow: scroll;">
												<table class="table" id="list-users">
													<thead>
														<tr>
															<th scope="col">ID</th>
															<th scope="col">Name</th>
															<th scope="col">e-Mail</th>
															<th scope="col">See More</th>
														</tr>
													</thead>

													<tbody>
														<c:forEach items="${modelLogins}" var="currentModel">
															<tr>
																<td><c:out value="${currentModel.id}"></c:out></td>
																<td><c:out value="${currentModel.name}"></c:out></td>
																<td><c:out value="${currentModel.email}"></c:out></td>
																<td><a class="btn btn-success"
																	href="<%= request.getContextPath() %>/ServletUserController?action=search-id-by-ajax&id=${currentModel.id}">See</a>
																</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<!-- END OF USER LIST -->
											
											<!-- PAGINATION OF USER LIST -->
											<nav aria-label="Page navigation example">
											  <ul class="pagination">
											  	<%
											  		int totalPages = (int) request.getAttribute("totalPages");
											  	
											  		for(int currentPage = 0; currentPage < totalPages; currentPage++){
											  			String urlToDefinePagesQuantity = request.getContextPath() + "/ServletUserController?action=pagination&dataFrequency=" + ( currentPage * 5 );
											  			
											  			out.println("<li class=\"page-item\"><a class=\"page-link\" href=\""+ urlToDefinePagesQuantity +"\">" + (currentPage + 1) + "</a></li>");
											  		}
											  	%>
											  	
											  </ul>
											</nav>
											<!-- END PAGINATION OF USER LIST -->

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

	<!-- MODAL -->
	<div class="modal fade" id="searchModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<i class="fa fa-search"></i> Users Search
					</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="search-form"
						action="<%=request.getContextPath()%>/ServletUserController">

						<div class="form-group">

							<label for="recipient-name" class="col-form-label">Name:</label>
							<input type="text" class="form-control" id="recipient-name"
								required> <br />

							<button type="button" class="btn btn-outline-dark"
								data-toggle="modal" onclick="searchUser()">
								<i class="fa fa-search"></i> Search
							</button>
						</div>

					</form>

					<div style="height: 312px; overflow: scroll;">
						<table class="table" id="search-results-table">
							<thead>
								<tr>
									<th scope="col">ID</th>
									<th scope="col">Name</th>
									<th scope="col">See More</th>
								</tr>
							</thead>

							<tbody>

							</tbody>
						</table>
											
					</div>
					
					<br />
					
					<nav aria-label="Page navigation example">
						  <ul class="pagination" id="ulModalPagination">
						  	
						  	<!-- HERE WILL BE THE <li></li> CONTENT MADED WITH JAVASCRIPT -->
						  	
						  </ul>
						</nav>

					<br /> <span id="number-of-results"></span>

				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-outline-danger"
						data-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>

</body>

</html>