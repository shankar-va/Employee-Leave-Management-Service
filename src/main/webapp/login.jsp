<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ctx = request.getContextPath();
  String failure = (String) request.getAttribute("failure");
  String email = request.getAttribute("email") != null ? (String) request.getAttribute("email") : "";
  request.setAttribute("shimmerType", "auth");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | Employee Leave Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/login.css" rel="stylesheet">
  <link href="<%= ctx %>/css/forms.css" rel="stylesheet">
  <link href="<%= ctx %>/css/shimmer.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="components/shimmer.jsp" />

  <div id="pageContent" class="page-content-wrapper">
  <div class="bg-orbs"></div>

  <div class="login-page">
    <div class="login-wrapper fade-in">
      <div class="glass-card login-card">
        <div class="login-header">
          <div class="login-logo">
            <i class="bi bi-calendar2-check"></i>
          </div>
          <h1>Welcome Back</h1>
          <p>Sign in to your Employee Leave Management account</p>
        </div>

        <% if (failure != null) { %>
          <div class="alert-glass alert-glass-danger slide-in-up">
            <i class="bi bi-exclamation-circle"></i>
            <span><%= failure %></span>
          </div>
        <% } %>

        <form class="login-form" action="<%= ctx %>/login" method="post" data-shimmer-submit novalidate>
          <div class="form-group-custom">
            <label for="email"><i class="bi bi-envelope me-1"></i> Email Address</label>
            <input type="email" class="form-control glass-input" id="email" name="email"
                   placeholder="Enter your email" value="<%= email %>" required autofocus>
          </div>

          <div class="form-group-custom">
            <label for="pswd"><i class="bi bi-lock me-1"></i> Password</label>
            <div class="password-wrapper">
              <input type="password" class="form-control glass-input" id="pswd" name="pswd"
                     placeholder="Enter your password" required>
              <button type="button" class="password-toggle" aria-label="Toggle password visibility">
                <i class="bi bi-eye"></i>
              </button>
            </div>
          </div>

          <button type="submit" class="btn btn-glass login-btn ripple">
            <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
          </button>
        </form>

        <div class="login-divider">or</div>

        <div class="login-footer">
          Don't have an account? <a href="<%= ctx %>/register">Create Account</a>
        </div>

        <div class="login-features">
          <div class="login-feature-item">
            <i class="bi bi-shield-check"></i> Secure Login
          </div>
          <div class="login-feature-item">
            <i class="bi bi-lightning"></i> Fast Access
          </div>
          <div class="login-feature-item">
            <i class="bi bi-people"></i> Team Ready
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>

  <jsp:include page="components/toast.jsp" />

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/shimmer.js"></script>
  <script src="<%= ctx %>/js/toast.js"></script>
  <script src="<%= ctx %>/js/dashboard.js"></script>
</body>
</html>
