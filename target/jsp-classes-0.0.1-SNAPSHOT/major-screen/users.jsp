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
													<h3>Report Page</h3>
													<h4 class="${status}">${msg}</h4>
												</div>

												<br /> <br />

												<div class="card-block">
													<form id="report-form"
														action="<%=request.getContextPath()%>/ServletPrintUserReport"
														method="get" class="form-material">
														
														<input type="hidden" name="action" value="printUserReport">

														<div class="form-row align-items-center">

															<div class="col-auto">
																<label class="sr-only" for="start-date-searcher">Start
																	Date</label> <input type="text" class="form-control mb-2" value="${ startDate }"
																	id="start-date-searcher" name="start-date-searcher" placeholder="YYYY-MM-DD">
															</div>

															<div class="input-group-prepend">
																<div class="input-group-text ml-4 mr-4"><b>Until</b></div>
															</div>

															<div class="col-auto">
																<label class="sr-only" for="end-date-searcher">End
																	Date</label>
																<div class="input-group mb-2">
																	<input type="text" class="form-control" value="${ endDate }"
																		id="end-date-searcher" name="end-date-searcher" placeholder="YYYY-MM-DD">
																</div>
																
															</div>

															<div class="col-auto">
																<input id="print-report" type="submit" value="Print-Report" class="btn mb-2 btn-disabled" onmouseover="reportFieldsValidator()" disabled>
															</div>
														</div>

													</form>
													
												</div>

											</div>
											
											<!-- START -> SHOW HOW MANY USERS WERE FOUNDED -->
											<span class="text-dark list-group-item"><b>Users Found: ${ howManyUsers }</b></span>
											<!-- END -> SHOW HOW MANY USERS WERE FOUNDED -->

											<!-- START OF USERS LIST -->
											<div class="card-block"
												style="height: 312px; overflow: scroll;">
												
												<table class="table" id="list-users">
													<thead>
														<tr>
															<th scope="col">Name</th>
															<th scope="col">e-Mail</th>
															<th scope="col">Birth Day</th>
															<th scope="col">Phones</th>
														</tr>
													</thead>

													<tbody>
														<c:forEach items="${listOfUsers}" var="currentUser">
															<tr>
																<td><c:out value="${currentUser.name}"></c:out></td>
																<td><c:out value="${currentUser.email}"></c:out></td>
																<td><c:out value="${currentUser.userBirthday}"></c:out></td>
																<td>
																	<div class="card-block border border-secondary rounded"
																		style="width: 40rem; height: 3rem; overflow: scroll;">
																		<c:out value="${currentUser.userPhones}"></c:out>
																	</div>
																</td>
															</tr>
														</c:forEach>
													</tbody>
													
												</table>
												
											</div>
											<!-- END OF USERS LIST -->
											
											<hr />
											<br />

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

	<script type="text/javascript">
	
	// START THE START DATE SEARCH----------------------------------------
	$( function() { $("#start-date-searcher").datepicker({ 
			dateFormat: 'yy-mm-dd',
			dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
			dayNamesMin: ['S','M','T','W','T','F','S'],
			dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
			monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
			monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
			maxDate: "-18y",
			nextText: 'Next',
			prevText: 'Preview',
			showButtonPanel: true 
		});
	
		// START OF CALENDAR SETTINGS 
		var today = new Date().toISOString().split('T')[0];
		document.getElementById("userBirthday").setAttribute("max", today); 
		//END OF CALENDAR SETTINGS
		
	} );
	// END THE START DATE SEARCH---------------------------------------- 
	
	
	// START THE END DATE SEARCH----------------------------------------
	$( function() { $("#end-date-searcher").datepicker({ 
		dateFormat: 'yy-mm-dd',
		dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
		dayNamesMin: ['S','M','T','W','T','F','S'],
		dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
		monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
		monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
		maxDate: "-18y",
		nextText: 'Next',
		prevText: 'Preview',
		showButtonPanel: true }); 
	
		// START OF CALENDAR SETTINGS
		var today = new Date().toISOString().split('T')[0];
		document.getElementById("userBirthday").setAttribute("max", today); 
		// END OF CALENDAR SETTINGS
	
	} ); 
	// END THE END DATE SEARCH-----------------------------------------

		async function reportFieldsValidator() {
			var startDateSearcher = document.getElementById("start-date-searcher").value;
			var endDateSearcher = document.getElementById("end-date-searcher").value;
			var printButton = document.getElementById("print-report");
			
			if ( startDateSearcher.length == 10 && endDateSearcher.length == 10
					&& startDateSearcher.includes('-') && endDateSearcher.includes('-') ) {
				printButton.classList.remove("btn-grd-disabled");
				printButton.classList.remove("btn-disabled");
				printButton.classList.add("btn-dark");
				printButton.disabled = false;

			} else {
				printButton.classList.add("btn-grd-disabled");
				printButton.classList.add("btn-disabled");
				printButton.classList.remove("btn-dark");
				printButton.disabled = true;
			}

		}
	</script>

</body>

</html>
