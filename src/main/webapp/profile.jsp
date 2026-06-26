<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%
  String ctx = request.getContextPath();
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect(ctx + "/login");
    return;
  }

  String initials = user.getName() != null && !user.getName().isEmpty()
      ? user.getName().substring(0, 1).toUpperCase() : "U";
  String phone = user.getPhone() != null ? user.getPhone() : "";

  request.setAttribute("activePage", "profile");
  request.setAttribute("pageTitle", "My Profile");
  request.setAttribute("pageSubtitle", "View and update your account information");
  request.setAttribute("shimmerType", "form");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile | ELMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/dashboard.css" rel="stylesheet">
  <link href="<%= ctx %>/css/forms.css" rel="stylesheet">
  <link href="<%= ctx %>/css/profile.css" rel="stylesheet">
  <link href="<%= ctx %>/css/shimmer.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="components/shimmer.jsp" />

  <div id="pageContent" class="page-content-wrapper">
    <div class="bg-orbs"></div>
    <div class="app-wrapper">
      <jsp:include page="components/sidebar.jsp" />
      <div class="main-content">
        <jsp:include page="components/navbar.jsp" />
        <div class="page-content">
          <div class="page-header fade-in">
            <h2>My Profile</h2>
            <p>View your details — you can update your phone number only</p>
          </div>

          <div class="row justify-content-center">
            <div class="col-lg-8">
              <div class="glass-card profile-card slide-in-up">
                <div class="profile-header">
                  <div class="profile-avatar-lg"><%= initials %></div>
                  <div class="profile-header-info">
                    <h3><%= user.getName() %></h3>
                    <p><i class="fa-regular fa-envelope me-1"></i><%= user.getEmail() %></p>
                    <span class="profile-role-badge"><%= user.getRole() %></span>
                  </div>
                </div>

                <div class="profile-section-label">
                  <i class="fa-solid fa-lock me-1"></i> Read-only information
                </div>

                <div class="profile-details-grid mb-4">
                  <div class="profile-detail-item profile-readonly">
                    <label><i class="fa-solid fa-id-badge me-1"></i> Employee ID</label>
                    <span>#<%= user.getId() %></span>
                  </div>
                  <div class="profile-detail-item profile-readonly">
                    <label><i class="fa-solid fa-user me-1"></i> Full Name</label>
                    <span><%= user.getName() %></span>
                  </div>
                  <div class="profile-detail-item profile-readonly">
                    <label><i class="fa-solid fa-envelope me-1"></i> Email</label>
                    <span><%= user.getEmail() %></span>
                  </div>
                  <div class="profile-detail-item profile-readonly">
                    <label><i class="fa-solid fa-building me-1"></i> Department</label>
                    <span><%= user.getDepartment() != null ? user.getDepartment() : "—" %></span>
                  </div>
                  <div class="profile-detail-item profile-readonly">
                    <label><i class="fa-solid fa-user-shield me-1"></i> Role</label>
                    <span><%= user.getRole() %></span>
                  </div>
                </div>

                <div class="profile-section-label">
                  <i class="fa-solid fa-pen me-1"></i> Editable information
                </div>

                <form action="<%= ctx %>/updateProfile" method="post" class="profile-phone-form" data-shimmer-submit novalidate>
                  <div class="form-group-custom">
                    <label for="phone"><i class="fa-solid fa-phone me-1"></i> Phone Number</label>
                    <input type="tel" class="form-control glass-input" id="phone" name="phone"
                           value="<%= phone %>" placeholder="Enter your phone number" required>
                    <small class="profile-field-hint">Only your phone number can be updated from this page.</small>
                  </div>

                  <div class="profile-actions">
                    <button type="submit" class="btn btn-glass ripple">
                      <i class="fa-solid fa-floppy-disk me-2"></i>Save Phone
                    </button>
                    <a href="<%= ctx %>/changePassword.jsp" class="btn btn-glass-outline ripple">
                      <i class="fa-solid fa-key me-2"></i>Change Password
                    </a>
                    <% if ("admin".equalsIgnoreCase(user.getRole())) { %>
                      <a href="<%= ctx %>/admin" class="btn btn-glass-outline ripple">
                        <i class="fa-solid fa-gauge-high me-2"></i>Dashboard
                      </a>
                    <% } else { %>
                      <a href="<%= ctx %>/user.jsp" class="btn btn-glass-outline ripple">
                        <i class="fa-solid fa-gauge-high me-2"></i>Dashboard
                      </a>
                    <% } %>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <jsp:include page="components/footer.jsp" />
      </div>
    </div>
  </div>

  <jsp:include page="components/toast.jsp" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/shimmer.js"></script>
  <script src="<%= ctx %>/js/toast.js"></script>
  <script src="<%= ctx %>/js/sidebar.js"></script>
</body>
</html>
