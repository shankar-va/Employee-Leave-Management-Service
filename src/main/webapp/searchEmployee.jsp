<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
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

  request.setAttribute("activePage", "search");
  request.setAttribute("pageTitle", "Search Employee");
  request.setAttribute("pageSubtitle", "Find employees by name or department");
  request.setAttribute("shimmerType", "form");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Employee | ELMS Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/dashboard.css" rel="stylesheet">
  <link href="<%= ctx %>/css/employees.css" rel="stylesheet">
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
            <h2>Search Employee</h2>
            <p>Search the employee directory by name or department</p>
          </div>

          <div class="row justify-content-center">
            <div class="col-lg-7">
              <div class="glass-card form-card slide-in-up">
                <div class="form-card-header" style="text-align:left;margin-bottom:1.5rem;">
                  <h4 style="color:#fff;margin:0;"><i class="fa-solid fa-magnifying-glass me-2 text-sky"></i>Employee Search</h4>
                </div>

                <form action="<%= ctx %>/searchEmployee" method="get" id="searchForm" novalidate>
                  <div class="search-type-tabs">
                    <button type="button" class="search-type-tab active" data-type="name"
                            onclick="setSearchType('name', this)">
                      <i class="fa-solid fa-user me-1"></i> By Name
                    </button>
                    <button type="button" class="search-type-tab" data-type="dept"
                            onclick="setSearchType('dept', this)">
                      <i class="fa-solid fa-building me-1"></i> By Department
                    </button>
                  </div>

                  <input type="hidden" id="type" name="type" value="name">

                  <div class="form-group-custom">
                    <label for="keyword" id="keywordLabel"><i class="fa-solid fa-user me-1"></i> Employee Name</label>
                    <input type="text" class="form-control glass-input" id="keyword" name="keyword"
                           placeholder="Enter employee name..." required autofocus>
                  </div>

                  <div class="form-actions d-flex gap-2 flex-wrap">
                    <button type="submit" class="btn btn-glass ripple flex-grow-1">
                      <i class="fa-solid fa-search me-2"></i>Search Employees
                    </button>
                    <a href="<%= ctx %>/employees" class="btn btn-glass-outline ripple">
                      <i class="fa-solid fa-list me-1"></i>View All
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
  <script src="<%= ctx %>/js/employees.js"></script>
</body>
</html>
