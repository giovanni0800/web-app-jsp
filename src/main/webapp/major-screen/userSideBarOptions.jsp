<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="main-menu-content">
    <ul>
        <li class="more-details">
            <a href="<%= request.getContextPath() %>/major-screen/profile.jsp"><i class="ti-user"></i>View Profile</a>
            <!-- <a href="#!"><i class="ti-settings"></i>Settings</a> -->
            <a href="<%= request.getContextPath() %>/ServletLogin?action=Logout"><i class="ti-layout-sidebar-left"></i>Logout</a>
        </li>
    </ul>
</div>