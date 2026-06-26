<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%
  String ctx = request.getContextPath();
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect(ctx + "/login");
    return;
  }

  request.setAttribute("activePage", "password");
  request.setAttribute("pageTitle", "Change Password");
  request.setAttribute("pageSubtitle", "Update your account password");
  request.setAttribute("shimmerType", "form");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Change Password | ELMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/dashboard.css" rel="stylesheet">
  <link href="<%= ctx %>/css/forms.css" rel="stylesheet">
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
            <h2>Change Password</h2>
            <p>Keep your account secure with a strong password</p>
          </div>

          <div class="row justify-content-center">
            <div class="col-lg-6">
              <div class="glass-card form-card slide-in-up">
                <form action="<%= ctx %>/changePassword" method="post" data-shimmer-submit novalidate>
                  <div class="form-group-custom">
                    <label for="oldPassword"><i class="fa-solid fa-lock me-1"></i> Current Password</label>
                    <div class="password-wrapper">
                      <input type="password" class="form-control glass-input" id="oldPassword"
                             name="oldPassword" placeholder="Enter current password" required>
                      <button type="button" class="password-toggle" aria-label="Toggle password">
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </div>

                  <div class="form-group-custom">
                    <label for="newPassword"><i class="fa-solid fa-key me-1"></i> New Password</label>
                    <div class="password-wrapper">
                      <input type="password" class="form-control glass-input" id="newPassword"
                             name="newPassword" placeholder="Enter new password" required minlength="6">
                      <button type="button" class="password-toggle" aria-label="Toggle password">
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                  </div>

                  <div class="form-group-custom">
                    <label for="confirmPassword"><i class="fa-solid fa-check-double me-1"></i> Confirm New Password</label>
                    <div class="password-wrapper">
                      <input type="password" class="form-control glass-input" id="confirmPassword"
                             name="confirmPassword" placeholder="Confirm new password" required minlength="6">
                      <button type="button" class="password-toggle" aria-label="Toggle password">
                        <i class="bi bi-eye"></i>
                      </button>
                    </div>
                    <div class="field-error" id="confirmError"></div>
                  </div>

                  <div class="form-actions d-flex gap-2 flex-wrap">
                    <button type="submit" class="btn btn-glass ripple flex-grow-1">
                      <i class="fa-solid fa-floppy-disk me-2"></i>Update Password
                    </button>
                    <a href="<%= ctx %>/profile.jsp" class="btn btn-glass-outline ripple">
                      <i class="fa-solid fa-arrow-left me-1"></i>Back
                    </a>
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
  <script src="<%= ctx %>/js/dashboard.js"></script>
  <script>
    (function () {
      var form = document.querySelector('form[action$="/changePassword"]');
      if (!form) return;
      form.addEventListener('submit', function (e) {
        var np = document.getElementById('newPassword').value;
        var cp = document.getElementById('confirmPassword').value;
        var err = document.getElementById('confirmError');
        if (np !== cp) {
          e.preventDefault();
          if (err) {
            err.textContent = 'New passwords do not match.';
            err.classList.add('visible');
          }
          document.getElementById('confirmPassword').classList.add('is-invalid');
        }
      });
    })();
  </script>
</body>
</html>
