<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%
  User sidebarUser = (User) session.getAttribute("user");
  String ctx = request.getContextPath();
  String role = sidebarUser != null ? sidebarUser.getRole() : "";
  boolean isAdmin = "admin".equalsIgnoreCase(role);
  String activePage = request.getAttribute("activePage") != null
      ? (String) request.getAttribute("activePage") : "";
%>
<aside class="sidebar" id="sidebar">
  <div class="sidebar-brand">
    <div class="sidebar-brand-icon">
      <i class="bi bi-calendar2-check"></i>
    </div>
    <div class="sidebar-brand-text">
      <h5>ELMS</h5>
      <span>Leave Management</span>
    </div>
  </div>

  <nav class="sidebar-nav">
    <div class="nav-label">Main Menu</div>

    <% if (isAdmin) { %>
      <a href="<%= ctx %>/admin" class="sidebar-link <%= "admin".equals(activePage) ? "active" : "" %>">
        <i class="bi bi-speedometer2"></i>
        <span class="link-text">Dashboard</span>
      </a>
      <a href="<%= ctx %>/employees" class="sidebar-link <%= "employees".equals(activePage) ? "active" : "" %>">
        <i class="bi bi-people"></i>
        <span class="link-text">Employees</span>
      </a>
      <a href="<%= ctx %>/searchEmployee.jsp" class="sidebar-link <%= "search".equals(activePage) ? "active" : "" %>">
        <i class="bi bi-search"></i>
        <span class="link-text">Search Employee</span>
      </a>
    <% } else { %>
      <a href="<%= ctx %>/user.jsp" class="sidebar-link <%= "dashboard".equals(activePage) ? "active" : "" %>">
        <i class="bi bi-speedometer2"></i>
        <span class="link-text">Dashboard</span>
      </a>
      <a href="<%= ctx %>/applyLeave" class="sidebar-link <%= "apply".equals(activePage) ? "active" : "" %>">
        <i class="bi bi-plus-circle"></i>
        <span class="link-text">Apply Leave</span>
      </a>
      <a href="<%= ctx %>/myLeaves" class="sidebar-link <%= "leaves".equals(activePage) ? "active" : "" %>">
        <i class="bi bi-list-check"></i>
        <span class="link-text">My Leaves</span>
      </a>
    <% } %>

    <div class="nav-label">Account</div>
    <a href="<%= ctx %>/profile.jsp" class="sidebar-link <%= "profile".equals(activePage) ? "active" : "" %>">
      <i class="bi bi-person-circle"></i>
      <span class="link-text">Profile</span>
    </a>
    <a href="<%= ctx %>/changePassword.jsp" class="sidebar-link <%= "password".equals(activePage) ? "active" : "" %>">
      <i class="bi bi-key"></i>
      <span class="link-text">Change Password</span>
    </a>
  </nav>

  <div class="sidebar-footer">
    <a href="<%= ctx %>/logout" class="sidebar-link">
      <i class="bi bi-box-arrow-left"></i>
      <span class="link-text">Logout</span>
    </a>
  </div>
</aside>
<div class="sidebar-overlay" id="sidebarOverlay"></div>
