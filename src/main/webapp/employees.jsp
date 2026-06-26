<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect(ctx + "/login");
    return;
  }
  if (!"admin".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect(ctx + "/user.jsp");
    return;
  }

  @SuppressWarnings("unchecked")
  List<User> employees = (List<User>) request.getAttribute("employees");
  if (employees == null) employees = java.util.Collections.emptyList();

  request.setAttribute("activePage", "employees");
  request.setAttribute("pageTitle", "Employees");
  request.setAttribute("pageSubtitle", "Manage all registered employees");
  request.setAttribute("shimmerType", "table");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employees | ELMS Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/dashboard.css" rel="stylesheet">
  <link href="<%= ctx %>/css/employees.css" rel="stylesheet">
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
            <h2>Employee Management</h2>
            <p>View, search, edit and manage employees</p>
          </div>

          <div class="glass-card employee-search-card slide-in-up">
            <form class="employee-search-form" action="<%= ctx %>/searchEmployee" method="get">
              <div class="form-group-custom">
                <label for="keyword"><i class="fa-solid fa-magnifying-glass me-1"></i> Search Keyword</label>
                <input type="text" class="form-control glass-input" id="keyword" name="keyword"
                       placeholder="Enter name or department..." required>
              </div>
              <div class="form-group-custom" style="max-width:180px;">
                <label for="type">Search By</label>
                <select class="form-select glass-input" id="type" name="type">
                  <option value="name">Name</option>
                  <option value="dept">Department</option>
                </select>
              </div>
              <button type="submit" class="btn btn-glass ripple">
                <i class="fa-solid fa-search me-1"></i>Search
              </button>
              <a href="<%= ctx %>/employees" class="btn btn-glass-outline ripple">
                <i class="fa-solid fa-rotate-right me-1"></i>Reset
              </a>
              <a href="<%= ctx %>/searchEmployee.jsp" class="btn btn-glass-outline ripple">
                <i class="fa-solid fa-filter me-1"></i>Advanced
              </a>
            </form>
          </div>

          <div class="glass-card p-4 slide-in-up">
            <div class="table-section-header">
              <h4><i class="fa-solid fa-users me-2 text-sky"></i>All Employees (<%= employees.size() %>)</h4>
            </div>

            <% if (employees.isEmpty()) { %>
              <div class="empty-state">
                <i class="fa-solid fa-users-slash"></i>
                <p>No employees found.</p>
              </div>
            <% } else { %>
              <div class="table-wrapper">
                <table class="glass-table" id="employeesTable">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Name</th>
                      <th>Email</th>
                      <th>Role</th>
                      <th>Department</th>
                      <th>Phone</th>
                      <th>Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% for (User emp : employees) {
                         String roleClass = "admin".equalsIgnoreCase(emp.getRole())
                             ? "role-badge-admin" : "role-badge-user";
                         String roleLabel = emp.getRole() != null ? emp.getRole().toUpperCase() : "USER";
                    %>
                    <tr data-searchable="<%= emp.getId() %> <%= emp.getName() %> <%= emp.getEmail() %> <%= emp.getDepartment() %>">
                      <td><strong class="text-white">#<%= emp.getId() %></strong></td>
                      <td><%= emp.getName() %></td>
                      <td><%= emp.getEmail() %></td>
                      <td><span class="badge-status <%= roleClass %>"><%= roleLabel %></span></td>
                      <td><%= emp.getDepartment() %></td>
                      <td><%= emp.getPhone() %></td>
                      <td>
                        <% if ("admin".equalsIgnoreCase(emp.getRole())) { %>
                          <span class="text-muted-custom" title="Admin accounts are protected">
                            <i class="fa-solid fa-shield-halved me-1"></i>Protected
                          </span>
                        <% } else { %>
                          <a href="<%= ctx %>/updateEmployee?id=<%= emp.getId() %>"
                             class="btn-action btn-action-edit me-1">
                            <i class="fa-solid fa-pen"></i> Edit
                          </a>
                          <a href="#"
                             onclick="return confirmDelete('<%= ctx %>/deleteEmployee?id=<%= emp.getId() %>', '<%= emp.getName() %>');"
                             class="btn-action btn-action-delete">
                            <i class="fa-solid fa-trash"></i> Delete
                          </a>
                        <% } %>
                      </td>
                    </tr>
                    <% } %>
                  </tbody>
                </table>
              </div>
            <% } %>
          </div>
        </div>
        <jsp:include page="components/footer.jsp" />
      </div>
    </div>
  </div>

  <jsp:include page="components/toast.jsp" />
  <jsp:include page="components/model.jsp" />

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/shimmer.js"></script>
  <script src="<%= ctx %>/js/toast.js"></script>
  <script src="<%= ctx %>/js/sidebar.js"></script>
  <script src="<%= ctx %>/js/employees.js"></script>
</body>
</html>
