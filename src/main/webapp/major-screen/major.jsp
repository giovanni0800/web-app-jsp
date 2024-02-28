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
	                      <div class="sidebar_toggle"><a href="#"><i class="icon-close icons"></i></a></div>
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
	                                        <div class="row">
	                                       		<h1>Main Content</h1>
	                                        </div>
	                                    </div>
	                                    <!-- Page-body end -->
	                                </div>
	                                <div id="styleSelector"> </div>
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