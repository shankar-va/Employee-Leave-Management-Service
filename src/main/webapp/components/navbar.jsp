<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%
  User navUser = (User) session.getAttribute("user");
  String pageTitle = request.getAttribute("pageTitle") != null
      ? (String) request.getAttribute("pageTitle") : "Dashboard";
  String pageSubtitle = request.getAttribute("pageSubtitle") != null
      ? (String) request.getAttribute("pageSubtitle") : "";
  String initials = "";
  if (navUser != null && navUser.getName() != null && !navUser.getName().isEmpty()) {
    initials = navUser.getName().substring(0, 1).toUpperCase();
  }
%>
<header class="top-navbar">
  <div class="navbar-left">
    <button class="sidebar-toggle" id="sidebarToggle" aria-label="Toggle sidebar">
      <i class="bi bi-list"></i>
    </button>
    <div>
      <h1 class="page-title"><%= pageTitle %></h1>
      <% if (!pageSubtitle.isEmpty()) { %>
        <p class="page-breadcrumb"><%= pageSubtitle %></p>
      <% } %>
    </div>
  </div>
  <div class="navbar-right">
    <div class="user-profile">
      <div class="user-avatar"><%= initials %></div>
      <div class="user-info">
        <div class="user-name"><%= navUser != null ? navUser.getName() : "User" %></div>
        <div class="user-role"><%= navUser != null ? navUser.getRole() : "" %></div>
      </div>
    </div>
  </div>
</header>
