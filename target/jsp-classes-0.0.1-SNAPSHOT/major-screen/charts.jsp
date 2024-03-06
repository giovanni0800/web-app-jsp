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
													<h3>Charts Page</h3>
													<h4 class="${status}">${msg}</h4>
												</div>

												<br /> <br />

												<div class="card-block">
													<form id="request-chart-form"
														action="<%=request.getContextPath()%>/ServletChart"
														method="get" class="form-material">

														<div class="form-row align-items-center">

															<div class="col-auto">
																<label class="sr-only" for="startDate">Start
																	Date</label> <input type="text" class="form-control mb-2"
																	value="${ startDate }" id="startDate"
																	name="startDate" placeholder="YYYY-MM-DD">
															</div>

															<div class="input-group-prepend">
																<div class="input-group-text ml-4 mr-4">
																	<b>Until</b>
																</div>
															</div>

															<div class="col-auto">
																<label class="sr-only" for="endDate">End
																	Date</label>
																<div class="input-group mb-2">
																	<input type="text" class="form-control"
																		value="${ endDate }" id="endDate"
																		name="endDate" placeholder="YYYY-MM-DD">
																</div>

															</div>

															<div class="col-auto">
																<input id="generate-chart" type="button"
																	value="Generate-Chart" class="btn mb-2 btn-info"
																	onclick="generateChar()">
															</div>
														</div>

													</form>

												</div>

											</div>

											<!-- MY CHART WILL START HERE -->
											<div>
												<canvas id="myChart"></canvas>
											</div>
											<!-- MY CHART WILL FINISH HERE -->

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
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

	<script>
	
		// START THE START DATE SEARCH----------------------------------------
		$( function() { $("#startDate").datepicker({ 
				dateFormat: 'yy-mm-dd',
				dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
				dayNamesMin: ['S','M','T','W','T','F','S'],
				dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
				monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
				monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
				maxDate: "1d",
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
		$( function() { $("#endDate").datepicker({ 
			dateFormat: 'yy-mm-dd',
			dayNames: ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'],
			dayNamesMin: ['S','M','T','W','T','F','S'],
			dayNamesShort: ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'],
			monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
			monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
			maxDate: "1d",
			nextText: 'Next',
			prevText: 'Preview',
			showButtonPanel: true }); 
		
			// START OF CALENDAR SETTINGS
			var today = new Date().toISOString().split('T')[0];
			document.getElementById("userBirthday").setAttribute("max", today); 
			// END OF CALENDAR SETTINGS
		
		} ); 
		// END THE END DATE SEARCH-----------------------------------------
	
		var ctx = new Chart(document.getElementById('myChart'));
		
		function generateChar() {
			
			var urlAction = document.getElementById("request-chart-form").action;
			var startDate = document.getElementById("startDate").value;
			var endDate = document.getElementById("endDate").value;
			
			$.ajax({
				method: 'get',
				url: urlAction,
				data: 'startDate=' + startDate + '&endDate=' + endDate + '&action=chart-request',
				success: function(response){
					
					try{
						var newJson = JSON.parse(response);
						
						ctx.destroy();
						
						ctx = new Chart(document.getElementById('myChart'), {
							type : 'bar',
							data : {
								labels : newJson.perfilList,
								datasets : [ {
									label : 'Average salary chart',
									data : newJson.averageSalaryClients,
									borderWidth : 1
								} ]
							},
							options : {
								scales : {
									y : {
										beginAtZero : true
									}
								}
							}
						});
					
					} catch(error){
						
						//If all fields have been filled in or If no fields have been filled in, this alert will appear
						//Because it means that back end should return a value, and if it doesn't happened, there is no data
						if( ( ( startDate == null || startDate == "" ) && ( endDate == null || endDate == "" ) ) 
								|| ( ( startDate != null && startDate != "" ) && ( endDate != null && endDate != "" ) ) ){
							alert("There is no data to show.");
						
						} else {
							alert("Please, enter a value on both fields or no one to search");
						}
					}
					
				}
			
			}).fail(function(xhr, status, errorThrown){
				alert("We had an error while tried to get chart datas...\n\n" + xhr.responseText);
			});
			
		}
	</script>

</body>

</html>
