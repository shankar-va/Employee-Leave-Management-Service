<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  /*
   * Register page – served via RegisterServlet GET/POST /register
   * POST params: username, email, pswd, confirmPswd, role, department, phone
   */
  String ctx = request.getContextPath();
  String failure = (String) request.getAttribute("failure");
  String name = request.getAttribute("name") != null ? (String) request.getAttribute("name") : "";
  String email = request.getAttribute("email") != null ? (String) request.getAttribute("email") : "";
  String phone = request.getAttribute("phone") != null ? (String) request.getAttribute("phone") : "";
  String department = request.getAttribute("department") != null ? (String) request.getAttribute("department") : "";
  String role = request.getAttribute("role") != null ? (String) request.getAttribute("role") : "user";
  request.setAttribute("shimmerType", "auth");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register | Employee Leave Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/forms.css" rel="stylesheet">
  <link href="<%= ctx %>/css/shimmer.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="components/shimmer.jsp" />

  <div id="pageContent" class="page-content-wrapper">
    <div class="bg-orbs"></div>

    <div class="form-page">
      <div class="form-container form-container-wide slide-in-up">
        <div class="glass-card form-card">
          <div class="form-card-header">
            <div class="form-icon">
              <i class="bi bi-person-plus"></i>
            </div>
            <h2>Create Account</h2>
            <p>Register to manage your leave requests</p>
          </div>

          <% if (failure != null) { %>
            <div class="alert-glass alert-glass-danger">
              <i class="bi bi-exclamation-circle"></i>
              <span><%= failure %></span>
            </div>
          <% } %>

          <form action="<%= ctx %>/register" method="post" data-shimmer-submit novalidate>
            <div class="form-grid-2">
              <div class="form-floating-custom">
                <input type="text" class="form-control" id="username" name="username"
                       placeholder=" " value="<%= name %>" required>
                <label for="username">Full Name</label>
              </div>

              <div class="form-floating-custom">
                <input type="email" class="form-control" id="email" name="email"
                       placeholder=" " value="<%= email %>" required>
                <label for="email">Email Address</label>
              </div>
            </div>

            <div class="form-grid-2">
              <div class="form-floating-custom">
                <input type="tel" class="form-control" id="phone" name="phone"
                       placeholder=" " value="<%= phone %>" required>
                <label for="phone">Phone Number</label>
              </div>

              <div class="form-floating-custom">
                <select class="form-control" id="department" name="department" required>
                  <option value="" disabled <%= department.isEmpty() ? "selected" : "" %>>Select Department</option>
                  <option value="Engineering" <%= "Engineering".equals(department) ? "selected" : "" %>>Engineering</option>
                  <option value="Human Resources" <%= "Human Resources".equals(department) ? "selected" : "" %>>Human Resources</option>
                  <option value="Finance" <%= "Finance".equals(department) ? "selected" : "" %>>Finance</option>
                  <option value="Marketing" <%= "Marketing".equals(department) ? "selected" : "" %>>Marketing</option>
                  <option value="Operations" <%= "Operations".equals(department) ? "selected" : "" %>>Operations</option>
                  <option value="Sales" <%= "Sales".equals(department) ? "selected" : "" %>>Sales</option>
                  <option value="IT Support" <%= "IT Support".equals(department) ? "selected" : "" %>>IT Support</option>
                </select>
                <label for="department">Department</label>
              </div>
            </div>

            <input type="hidden" name="role" value="user">

            <div class="form-grid-2">
              <div class="form-floating-custom">
                <label for="pswd">Password</label>
                <div class="password-wrapper">
                  <input type="password" class="form-control" id="pswd" name="pswd"
                         placeholder=" " required minlength="6">
                  <button type="button" class="password-toggle" aria-label="Toggle password">
                    <i class="bi bi-eye"></i>
                  </button>
                </div>
                <div class="password-strength">
                  <div class="strength-bar"><div class="strength-fill" id="strengthFill"></div></div>
                  <div class="strength-text" id="strengthText"></div>
                </div>
              </div>

              <div class="form-floating-custom">
                <label for="confirmPswd">Confirm Password</label>
                <div class="password-wrapper">
                  <input type="password" class="form-control" id="confirmPswd" name="confirmPswd"
                         placeholder=" " required minlength="6">
                  <button type="button" class="password-toggle" aria-label="Toggle confirm password">
                    <i class="bi bi-eye"></i>
                  </button>
                </div>
                <div class="field-error" id="confirmError"></div>
              </div>
            </div>

            <div class="form-actions">
              <button type="submit" class="btn btn-glass ripple">
                <i class="bi bi-person-check me-2"></i>Create Account
              </button>
            </div>
          </form>

          <div class="form-footer-link">
            Already have an account? <a href="<%= ctx %>/login">Sign In</a>
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
