<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="pcoded-inner-navbar main-menu">
  <div class="">
      <div class="main-menu-header">
      	  
      	  <c:if test="${ userImage != null && userImage != '' }">
      	  	<img class="img-80 img-radius" src="${ userImage }" alt="User-Profile-Image">
      	  </c:if>
      	  <c:if test="${ userImage == null || userImage == '' }">
      	  	<img class="img-80 img-radius" src="<%= request.getContextPath()%>/assets/images/userImage.png" alt="User-Profile-Image">
      	  </c:if>
      	  
          <div class="user-details">
              <span id="more-details"><%= request.getSession().getAttribute("user") %><i class="fa fa-caret-down"></i></span>
          </div>
      </div>

      <jsp:include page="userSideBarOptions.jsp"></jsp:include>
        
    </div>
    
    <!-- IT'S A SEARCH FRIEND FIELD -->
    <!-- <div class="p-15 p-b-0">
        <form class="form-material">
            <div class="form-group form-primary">
                <input type="text" name="footer-email" class="form-control" required="required">
                <span class="form-bar"></span>
                <label class="float-label"><i class="fa fa-search m-r-10"></i>Search Friend</label>
            </div>
        </form>
    </div> -->
    
    <div class="pcoded-navigation-label" data-i18n="nav.category.navigation">Layout</div>
    <ul class="pcoded-item pcoded-left-item">
        <li class="active">
            <a href="<%= request.getContextPath() %>/major-screen/major.jsp" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-home"></i><b>D</b></span>
                <span class="pcoded-mtext" data-i18n="nav.dash.main">Home</span>
                <span class="pcoded-mcaret"></span>
            </a>
        </li>
        <li class="pcoded-hasmenu">
            <a href="javascript:void(0)" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Register</span>
                <span class="pcoded-mcaret"></span>
            </a>
            <ul class="pcoded-submenu">
            	
            	<c:if test="${perfil == 'ADMIN'}">
	                <li class="">
	                    <a href="<%= request.getContextPath() %>/ServletUserController?action=listUsers" class="waves-effect waves-dark">
	                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
	                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Customer Base</span>
	                        <span class="pcoded-mcaret"></span>
	                    </a>
	                </li>
                </c:if>
                
                <c:if test="${perfil != 'ADMIN'}">
	                <li class="">
	                    <div>
	                        <span class="pcoded-micon"><i class="text-danger fa-solid fa-circle-exclamation fa-fw"></i></span>
	                        <span class="pcoded-mtext text-danger" data-i18n="nav.basic-components.alert">You have no access to Register</span>
	                        <span class="pcoded-mcaret"></span>
	                    </div>
	                </li>
                </c:if>
                
                <!--	IT'S A BREADCRUMPS LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="breadcrumb.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Breadcrumbs</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                 -->
                 
                 <!--	IT'S A BUTTON LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="button.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Button</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                 -->
                 
                 <!--	IT'S A TABS LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="tabs.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Tabs</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                
                		IT'S A COLOR LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="color.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Color</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                
                		IT'S A LABEL BADGE LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="label-badge.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Label Badge</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                
                		IT'S A TOOLTIP LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="tooltip.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Tooltip</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                
                		IT'S A TYPOGRAPHY LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="typography.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Typography</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                
                		IT'S A NOTIFICATION LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="notification.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Notification</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                
                		IT'S A THEMIFY LINK (TO SEE OTHERS STYLES)
                <li class=" ">
                    <a href="icon-themify.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Themify</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                -->

            </ul>
        </li>
    </ul>
    
    <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Record</div>
    <ul class="pcoded-item pcoded-left-item">
        <li>
            <a href="<%= request.getContextPath() %>/major-screen/users.jsp" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                <span class="pcoded-mtext" data-i18n="nav.form-components.main">Users</span>
                <span class="pcoded-mcaret"></span>
            </a>
        </li>
        
        <!--
        <li>
            <a href="bs-basic-table.html" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                <span class="pcoded-mtext" data-i18n="nav.form-components.main">Basic Table</span>
                <span class="pcoded-mcaret"></span>
            </a>
        </li>
        -->

    </ul>

    <div class="pcoded-navigation-label" data-i18n="nav.category.forms">Chart</div>
    <ul class="pcoded-item pcoded-left-item">
        <li>
            <a href="<%= request.getContextPath() %>/major-screen/charts.jsp" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                <span class="pcoded-mtext" data-i18n="nav.form-components.main">Charts</span>
                <span class="pcoded-mcaret"></span>
            </a>
        </li>
        
        <!--
        <li>
            <a href="map-google.html" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-layers"></i><b>FC</b></span>
                <span class="pcoded-mtext" data-i18n="nav.form-components.main">Maps</span>
                <span class="pcoded-mcaret"></span>
            </a>
        </li>
        
        <li class="pcoded-hasmenu">
            <a href="javascript:void(0)" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-layout-grid2-alt"></i></span>
                <span class="pcoded-mtext"  data-i18n="nav.basic-components.main">Pages</span>
                <span class="pcoded-mcaret"></span>
            </a>
            <ul class="pcoded-submenu">
                <li class=" ">
                    <a href="auth-normal-sign-in.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.alert">Login</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                <li class=" ">
                    <a href="auth-sign-up.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Register</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                <li class=" ">
                    <a href="sample-page.html" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.basic-components.breadcrumbs">Sample Page</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
            </ul>
        </li>
        -->

    </ul>

    <!--
    <div class="pcoded-navigation-label" data-i18n="nav.category.other">Other</div>
    <ul class="pcoded-item pcoded-left-item">
        <li class="pcoded-hasmenu ">
            <a href="javascript:void(0)" class="waves-effect waves-dark">
                <span class="pcoded-micon"><i class="ti-direction-alt"></i><b>M</b></span>
                <span class="pcoded-mtext" data-i18n="nav.menu-levels.main">Menu Levels</span>
                <span class="pcoded-mcaret"></span>
            </a>
            <ul class="pcoded-submenu">
                <li class="">
                    <a href="javascript:void(0)" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-21">Menu Level 2.1</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>
                <li class="pcoded-hasmenu ">
                    <a href="javascript:void(0)" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-direction-alt"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-22.main">Menu Level 2.2</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                    <ul class="pcoded-submenu">
                        <li class="">
                            <a href="javascript:void(0)" class="waves-effect waves-dark">
                                <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-22.menu-level-31">Menu Level 3.1</span>
                                <span class="pcoded-mcaret"></span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="">
                    <a href="javascript:void(0)" class="waves-effect waves-dark">
                        <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.menu-levels.menu-level-23">Menu Level 2.3</span>
                        <span class="pcoded-mcaret"></span>
                    </a>
                </li>

            </ul>
        </li>
    </ul>
    -->
</div>
 
 