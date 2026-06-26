<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%
  String ctx = request.getContextPath();
  User user = (User) (session != null ? session.getAttribute("user") : null);
  if (user != null) {
    if ("admin".equalsIgnoreCase(user.getRole())) {
      response.sendRedirect(ctx + "/admin");
    } else {
      response.sendRedirect(ctx + "/user.jsp");
    }
    return;
  }
  request.setAttribute("shimmerType", "auth");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ELMS | Employee Leave Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/login.css" rel="stylesheet">
  <link href="<%= ctx %>/css/shimmer.css" rel="stylesheet">
  <link href="<%= ctx %>/css/home.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="components/shimmer.jsp" />

  <div id="pageContent" class="page-content-wrapper">
    <div class="bg-orbs"></div>

    <div class="home-hero">
      <div class="home-hero-content glass-card fade-in">
        <div class="home-logo">
          <i class="fa-solid fa-calendar-check"></i>
        </div>
        <h1>Employee Leave Management System</h1>
        <p class="home-tagline">Premium SaaS-grade leave tracking for modern teams. Manage requests, approvals, and employee records in one place.</p>

        <div class="home-features">
          <div class="home-feature"><i class="fa-solid fa-shield-halved"></i> Secure</div>
          <div class="home-feature"><i class="fa-solid fa-bolt"></i> Fast</div>
          <div class="home-feature"><i class="fa-solid fa-chart-line"></i> Insightful</div>
        </div>

        <div class="home-actions">
          <a href="<%= ctx %>/login" class="btn btn-glass ripple">
            <i class="fa-solid fa-right-to-bracket me-2"></i>Sign In
          </a>
          <a href="<%= ctx %>/register" class="btn btn-glass-outline ripple">
            <i class="fa-solid fa-user-plus me-2"></i>Create Account
          </a>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/shimmer.js"></script>
</body>
</html>
