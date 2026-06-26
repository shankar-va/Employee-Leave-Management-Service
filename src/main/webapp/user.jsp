<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%@ page import="com.project.model.LeaveRequest" %>
<%@ page import="com.project.service.LeaveService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%
  String ctx = request.getContextPath();
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect(ctx + "/login");
    return;
  }

  List<LeaveRequest> leaves = LeaveService.viewLeaves(user.getId());
  if (leaves == null) leaves = Collections.emptyList();

  int pendingCount = 0, approvedCount = 0, rejectedCount = 0, cancelledCount = 0;
  for (LeaveRequest lr : leaves) {
    String st = lr.getStatus() != null ? lr.getStatus().toUpperCase() : "";
    switch (st) {
      case "PENDING":   pendingCount++; break;
      case "APPROVED":  approvedCount++; break;
      case "REJECTED":  rejectedCount++; break;
      case "CANCELLED": cancelledCount++; break;
    }
  }

  int recentLimit = Math.min(leaves.size(), 5);
  request.setAttribute("activePage", "dashboard");
  request.setAttribute("pageTitle", "Dashboard");
  request.setAttribute("pageSubtitle", "Overview of your leave requests");
  request.setAttribute("shimmerType", "dashboard");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard | ELMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/glass.css" rel="stylesheet">
  <link href="<%= ctx %>/css/dashboard.css" rel="stylesheet">
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
          <h2>Hello, <%= user.getName() %>!</h2>
          <p>Here's a summary of your leave activity</p>
        </div>

        <div class="stat-cards">
          <div class="glass-card glass-card-hover stat-card stat-pending slide-in-up delay-1">
            <div class="stat-card-icon"><i class="bi bi-hourglass-split"></i></div>
            <div class="stat-card-value"><%= pendingCount %></div>
            <div class="stat-card-label">Pending Leaves</div>
          </div>
          <div class="glass-card glass-card-hover stat-card stat-approved slide-in-up delay-2">
            <div class="stat-card-icon"><i class="bi bi-check-circle"></i></div>
            <div class="stat-card-value"><%= approvedCount %></div>
            <div class="stat-card-label">Approved Leaves</div>
          </div>
          <div class="glass-card glass-card-hover stat-card stat-rejected slide-in-up delay-3">
            <div class="stat-card-icon"><i class="bi bi-x-circle"></i></div>
            <div class="stat-card-value"><%= rejectedCount %></div>
            <div class="stat-card-label">Rejected Leaves</div>
          </div>
          <div class="glass-card glass-card-hover stat-card stat-cancelled slide-in-up delay-4">
            <div class="stat-card-icon"><i class="bi bi-slash-circle"></i></div>
            <div class="stat-card-value"><%= cancelledCount %></div>
            <div class="stat-card-label">Cancelled Leaves</div>
          </div>
        </div>

        <div class="action-row slide-in-up delay-5">
          <a href="<%= ctx %>/applyLeave" class="btn btn-glass ripple">
            <i class="bi bi-plus-circle me-2"></i>Apply Leave
          </a>
          <a href="<%= ctx %>/myLeaves" class="btn btn-glass-outline ripple">
            <i class="bi bi-list-check me-2"></i>View My Leaves
          </a>
        </div>

        <div class="glass-card p-4 slide-in-up delay-5">
          <div class="table-section-header">
            <h4><i class="bi bi-clock-history me-2 text-sky"></i>Recent Leave Requests</h4>
          </div>

          <% if (leaves.isEmpty()) { %>
            <div class="empty-state">
              <i class="bi bi-inbox"></i>
              <p>No leave requests yet. Apply for your first leave!</p>
            </div>
          <% } else { %>
            <div class="table-wrapper">
              <table class="glass-table">
                <thead>
                  <tr>
                    <th>Leave ID</th>
                    <th>Type</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Applied Date</th>
                  </tr>
                </thead>
                <tbody>
                  <% for (int i = 0; i < recentLimit; i++) {
                       LeaveRequest lr = leaves.get(i);
                       String status = lr.getStatus() != null ? lr.getStatus().toUpperCase() : "PENDING";
                       String badgeClass = "badge-pending";
                       if ("APPROVED".equals(status)) badgeClass = "badge-approved";
                       else if ("REJECTED".equals(status)) badgeClass = "badge-rejected";
                       else if ("CANCELLED".equals(status)) badgeClass = "badge-cancelled";
                  %>
                  <tr>
                    <td>#<%= lr.getLeaveId() %></td>
                    <td><%= lr.getLeaveType() %></td>
                    <td><%= lr.getStartDate() %></td>
                    <td><%= lr.getEndDate() %></td>
                    <td><span class="badge-status <%= badgeClass %>"><%= status %></span></td>
                    <td><%= lr.getAppliedDate() != null ? lr.getAppliedDate() : "-" %></td>
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

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/shimmer.js"></script>
  <script src="<%= ctx %>/js/toast.js"></script>
  <script src="<%= ctx %>/js/sidebar.js"></script>
  <script src="<%= ctx %>/js/dashboard.js"></script>
</body>
</html>
