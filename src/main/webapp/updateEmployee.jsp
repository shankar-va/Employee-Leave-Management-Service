<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%
  String ctx = request.getContextPath();
  User sessionUser = (User) session.getAttribute("user");
  if (sessionUser == null) {
    response.sendRedirect(ctx + "/login");
    return;
  }
  if (!"admin".equalsIgnoreCase(sessionUser.getRole())) {
    response.sendRedirect(ctx + "/user.jsp");
    return;
  }

  User employee = (User) request.getAttribute("employee");
  if (employee == null) {
    response.sendRedirect(ctx + "/employees");
    return;
  }

  if ("admin".equalsIgnoreCase(employee.getRole())) {
    session.setAttribute("failure", "Admin accounts cannot be edited from employee management.");
    response.sendRedirect(ctx + "/employees");
    return;
  }

  request.setAttribute("activePage", "employees");
  request.setAttribute("pageTitle", "Update Employee");
  request.setAttribute("pageSubtitle", "Edit employee #" + employee.getId());
  request.setAttribute("shimmerType", "form");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Employee | ELMS Admin</title>
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
            <h2>Update Employee</h2>
            <p>Edit details for <%= employee.getName() %></p>
          </div>

          <div class="row justify-content-center">
            <div class="col-lg-8">
              <div class="glass-card form-card slide-in-up">
                <form action="<%= ctx %>/updateEmployee" method="post" data-shimmer-submit data-shimmer-type="form" novalidate>
                  <input type="hidden" name="id" value="<%= employee.getId() %>">

                  <div class="form-grid-2">
                    <div class="form-group-custom">
                      <label for="name"><i class="fa-solid fa-user me-1"></i> Full Name</label>
                      <input type="text" class="form-control glass-input" id="name" name="name"
                             value="<%= employee.getName() %>" required>
                    </div>
                    <div class="form-group-custom">
                      <label for="email"><i class="fa-solid fa-envelope me-1"></i> Email</label>
                      <input type="email" class="form-control glass-input" id="email" name="email"
                             value="<%= employee.getEmail() %>" required>
                    </div>
                  </div>

                  <div class="form-grid-2">
                    <div class="form-group-custom">
                      <label for="phone"><i class="fa-solid fa-phone me-1"></i> Phone</label>
                      <input type="tel" class="form-control glass-input" id="phone" name="phone"
                             value="<%= employee.getPhone() %>" required>
                    </div>
                    <div class="form-group-custom">
                      <label for="department"><i class="fa-solid fa-building me-1"></i> Department</label>
                      <select class="form-select glass-input" id="department" name="department" required>
                        <%
                          String dept = employee.getDepartment() != null ? employee.getDepartment() : "";
                          String[] depts = {"Engineering","Human Resources","Finance","Marketing","Operations","Sales","IT Support"};
                          for (String d : depts) {
                        %>
                        <option value="<%= d %>" <%= d.equals(dept) ? "selected" : "" %>><%= d %></option>
                        <% } %>
                      </select>
                    </div>
                  </div>

                  <div class="form-group-custom">
                    <label for="role"><i class="fa-solid fa-user-shield me-1"></i> Role</label>
                    <input type="hidden" name="role" value="user">
                    <input type="text" class="form-control glass-input" value="Employee" readonly disabled>
                  </div>

                  <div class="form-actions d-flex gap-2 flex-wrap">
                    <button type="submit" class="btn btn-glass ripple flex-grow-1">
                      <i class="fa-solid fa-floppy-disk me-2"></i>Save Changes
                    </button>
                    <a href="<%= ctx %>/employees" class="btn btn-glass-outline ripple">
                      <i class="fa-solid fa-arrow-left me-1"></i>Cancel
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
</body>
</html>
