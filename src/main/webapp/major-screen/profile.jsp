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
													<h3>Profile Page</h3>
												</div>

												<br /> <br />

												<div class="card-block">

													<!-- PROFILE PRESENTATION START'S HERE -->
													<section class="vh-100" style="background-color: #f4f5f7;">
														<div class="container py-5 h-100">
															<div
																class="row d-flex justify-content-center align-items-center h-100">
																<div class="col col-lg-6 mb-4 mb-lg-0">
																	<div class="card mb-3" style="border-radius: .5rem;">
																		<div class="row g-0">
																			<div
																				class="col-md-4 gradient-custom text-center text-white"
																				style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
																				
																				<c:if test="${currentUserInformations.userPhoto != '' && currentUserInformations.userPhoto != null }">
																					<a href="<%= request.getContextPath() %>/ServletUserController?action=photographyDownload&id=${currentUserInformations.id}">
																						<img
																							src="${ currentUserInformations.userPhoto }"
																							alt="User Image" class="img-fluid my-5"
																							id="userPhoto" width="70px"
																							style="width: 80px;" />
																					</a>
																					
																				</c:if>
																				<c:if test="${currentUserInformations.userPhoto == '' || currentUserInformations.userPhoto == null}">
																					<img
																						src="<%= request.getContextPath() %>/assets/images/userImage.png"
																						alt="User Image" class="img-fluid my-5"
																						id="userPhoto" width="70px"
																						style="width: 80px;" />
																				</c:if>
																				
																			</div>
																			<div class="col-md-8">
																				<div class="card-body p-4">
																					<h6>Contacts</h6>
																					<hr class="mt-0 mb-4">
																					<div class="row pt-1">
																						<div class="col-7 mb-2">
																							<h6>Email</h6>
																							<p class="text-muted">${ currentUserInformations.email }</p>
																						</div>
																						<div class="col-7 mb-2">
																							<h6>First Phone</h6>
																							<p class="text-muted">${ currentUserPhone }</p>
																						</div>
																					</div>
																					<h6>Personal Informations</h6>
																					<hr class="mt-0 mb-4">
																					<div class="row pt-1">
																						<div class="col-7 mb-2">
																							<h6>Name</h6>
																							<p class="text-muted">${ currentUserInformations.name.toUpperCase() }</p>
																						</div>
																						<div class="col-7 mb-2">
																							<h6>Date of Birth</h6>
																							<p class="text-muted">${ currentUserInformations.userBirthday }</p>
																						</div>
																					</div>
																					
																				</div>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</section>
													<!-- PROFILE PRESENTATION END'S HERE -->

												</div>

											</div>

											<br /> <br />

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

	<!-- Required Jquery -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/jquery/jquery.min.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/jquery-ui/jquery-ui.min.js "></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/popper.js/popper.min.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/bootstrap/js/bootstrap.min.js "></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/pages/widget/excanvas.js "></script>
	<!-- waves js -->
	<script
		src="<%=request.getContextPath()%>/assets/pages/waves/js/waves.min.js"></script>
	<!-- jquery slimscroll js -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/jquery-slimscroll/jquery.slimscroll.js "></script>
	<!-- modernizr js -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/modernizr/modernizr.js "></script>
	<!-- slimscroll js -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/SmoothScroll.js"></script>
	<script
		src="<%=request.getContextPath()%>/assets/js/jquery.mCustomScrollbar.concat.min.js "></script>
	<!-- Chart js -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/chart.js/Chart.js"></script>
	<!-- amchart js -->
	<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
	<script
		src="<%=request.getContextPath()%>/assets/pages/widget/amchart/gauge.js"></script>
	<script
		src="<%=request.getContextPath()%>/assets/pages/widget/amchart/serial.js"></script>
	<script
		src="<%=request.getContextPath()%>/assets/pages/widget/amchart/light.js"></script>
	<script
		src="<%=request.getContextPath()%>/assets/pages/widget/amchart/pie.min.js"></script>
	<script
		src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
	<!-- menu js -->
	<script src="<%=request.getContextPath()%>/assets/js/pcoded.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/assets/js/vertical-layout.min.js "></script>
	<!-- custom js -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/pages/dashboard/custom-dashboard.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/assets/js/script.js "></script>
	<!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<!-- Path to Mask Money Jquery -->
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-maskmoney@3.0.2/dist/jquery.maskMoney.min.js"></script>

</body>

</html>
