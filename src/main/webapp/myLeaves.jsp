<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%@ page import="com.project.model.LeaveRequest" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect(ctx + "/login");
    return;
  }

  @SuppressWarnings("unchecked")
  List<LeaveRequest> leaves = (List<LeaveRequest>) request.getAttribute("leaves");

  request.setAttribute("activePage", "leaves");
  request.setAttribute("pageTitle", "My Leaves");
  request.setAttribute("pageSubtitle", "View and manage your leave requests");
  request.setAttribute("shimmerType", "table");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Leaves | ELMS</title>
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
          <h2>My Leave Requests</h2>
          <p>Track the status of all your submitted leave applications</p>
        </div>

        <div class="glass-card p-4 slide-in-up">
          <div class="table-section-header">
            <h4><i class="bi bi-table me-2 text-sky"></i>All Requests</h4>
            <a href="<%= ctx %>/applyLeave" class="btn btn-glass btn-sm ripple">
              <i class="bi bi-plus-circle me-1"></i>New Request
            </a>
          </div>

          <div class="filter-bar">
            <div class="search-box">
              <i class="bi bi-search"></i>
              <input type="text" class="form-control glass-input" id="tableSearch"
                     placeholder="Search by type, status, or ID...">
            </div>
            <select class="filter-select" id="statusFilter">
              <option value="all">All Status</option>
              <option value="PENDING">Pending</option>
              <option value="APPROVED">Approved</option>
              <option value="REJECTED">Rejected</option>
              <option value="CANCELLED">Cancelled</option>
            </select>
          </div>

          <% if (leaves == null || leaves.isEmpty()) { %>
            <div class="empty-state">
              <i class="bi bi-inbox"></i>
              <p>You haven't submitted any leave requests yet.</p>
              <a href="<%= ctx %>/applyLeave" class="btn btn-glass btn-sm mt-3 ripple">
                <i class="bi bi-plus-circle me-1"></i>Apply Now
              </a>
            </div>
          <% } else { %>
            <div class="table-wrapper">
              <table class="glass-table">
                <thead>
                  <tr>
                    <th>Leave ID</th>
                    <th>Leave Type</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Applied Date</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <% for (LeaveRequest lr : leaves) {
                       String status = lr.getStatus() != null ? lr.getStatus().toUpperCase() : "PENDING";
                       String badgeClass = "badge-pending";
                       if ("APPROVED".equals(status)) badgeClass = "badge-approved";
                       else if ("REJECTED".equals(status)) badgeClass = "badge-rejected";
                       else if ("CANCELLED".equals(status)) badgeClass = "badge-cancelled";

                       String searchData = lr.getLeaveId() + " " + lr.getLeaveType() + " " + status;
                  %>
                  <tr data-status="<%= status %>"
                      data-searchable="<%= searchData %>">
                    <td><strong class="text-white">#<%= lr.getLeaveId() %></strong></td>
                    <td><%= lr.getLeaveType() %></td>
                    <td><%= lr.getStartDate() %></td>
                    <td><%= lr.getEndDate() %></td>
                    <td><span class="badge-status <%= badgeClass %>"><%= status %></span></td>
                    <td><%= lr.getAppliedDate() != null ? lr.getAppliedDate() : "-" %></td>
                    <td>
                      <% if ("PENDING".equals(status)) { %>
                        <a href="#"
                           onclick="return confirmAction('<%= ctx %>/leaveAction?leaveId=<%= lr.getLeaveId() %>&action=cancel', 'Are you sure you want to cancel this leave request?');"
                           class="btn-action btn-cancel">
                          <i class="bi bi-x-lg"></i> Cancel
                        </a>
                      <% } else { %>
                        <span class="text-muted-custom">—</span>
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
  <script src="<%= ctx %>/js/dashboard.js"></script>
</body>
</html>
