<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%@ page import="com.project.model.LeaveRequest" %>
<%@ page import="com.project.service.LeaveService" %>
<%@ page import="com.project.service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Collections" %>
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

  Integer employeeCount = (Integer) request.getAttribute("employeeCount");
  Integer pendingCount = (Integer) request.getAttribute("pendingCount");
  Integer approvedCount = (Integer) request.getAttribute("approvedCount");
  Integer rejectedCount = (Integer) request.getAttribute("rejectedCount");
  Integer cancelledCount = (Integer) request.getAttribute("cancelledCount");
  List<LeaveRequest> allRequests = null;

  if (employeeCount == null) {
    employeeCount = UserService.count();
    Map<String, List<LeaveRequest>> map = LeaveService.dashboard();
    if (map == null) map = Collections.emptyMap();
    List<LeaveRequest> pending = map.get("PENDING");
    List<LeaveRequest> approved = map.get("APPROVED");
    List<LeaveRequest> rejected = map.get("REJECTED");
    List<LeaveRequest> cancelled = map.get("CANCELLED");
    pendingCount = pending != null ? pending.size() : 0;
    approvedCount = approved != null ? approved.size() : 0;
    rejectedCount = rejected != null ? rejected.size() : 0;
    cancelledCount = cancelled != null ? cancelled.size() : 0;
    allRequests = LeaveService.viewAllRequests();
    if (allRequests == null) allRequests = Collections.emptyList();
  } else {
    @SuppressWarnings("unchecked")
    List<LeaveRequest> reqList = (List<LeaveRequest>) request.getAttribute("allRequests");
    allRequests = reqList;
  }

  if (pendingCount == null) pendingCount = 0;
  if (approvedCount == null) approvedCount = 0;
  if (rejectedCount == null) rejectedCount = 0;
  if (cancelledCount == null) cancelledCount = 0;
  if (allRequests == null) allRequests = Collections.emptyList();

  int totalLeaves = pendingCount + approvedCount + rejectedCount + cancelledCount;

  int pendingPct = totalLeaves > 0 ? (pendingCount * 100 / totalLeaves) : 0;
  int approvedPct = totalLeaves > 0 ? (approvedCount * 100 / totalLeaves) : 0;
  int rejectedPct = totalLeaves > 0 ? (rejectedCount * 100 / totalLeaves) : 0;
  int cancelledPct = totalLeaves > 0 ? (cancelledCount * 100 / totalLeaves) : 0;

  request.setAttribute("activePage", "admin");
  request.setAttribute("pageTitle", "Admin Dashboard");
  request.setAttribute("pageSubtitle", "Manage all employee leave requests");
  request.setAttribute("shimmerType", "dashboard");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard | ELMS</title>
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
          <h2>Admin Dashboard</h2>
          <p>Monitor and manage all employee leave requests</p>
        </div>

        <div class="stat-cards">
          <div class="glass-card glass-card-hover stat-card stat-employees slide-in-up delay-1">
            <div class="stat-card-icon"><i class="bi bi-people"></i></div>
            <div class="stat-card-value"><%= employeeCount %></div>
            <div class="stat-card-label">Employee Count</div>
          </div>
          <div class="glass-card glass-card-hover stat-card stat-pending slide-in-up delay-2">
            <div class="stat-card-icon"><i class="bi bi-hourglass-split"></i></div>
            <div class="stat-card-value"><%= pendingCount %></div>
            <div class="stat-card-label">Pending</div>
          </div>
          <div class="glass-card glass-card-hover stat-card stat-approved slide-in-up delay-3">
            <div class="stat-card-icon"><i class="bi bi-check-circle"></i></div>
            <div class="stat-card-value"><%= approvedCount %></div>
            <div class="stat-card-label">Approved</div>
          </div>
          <div class="glass-card glass-card-hover stat-card stat-rejected slide-in-up delay-4">
            <div class="stat-card-icon"><i class="bi bi-x-circle"></i></div>
            <div class="stat-card-value"><%= rejectedCount %></div>
            <div class="stat-card-label">Rejected</div>
          </div>
          <div class="glass-card glass-card-hover stat-card stat-cancelled slide-in-up delay-5">
            <div class="stat-card-icon"><i class="bi bi-slash-circle"></i></div>
            <div class="stat-card-value"><%= cancelledCount %></div>
            <div class="stat-card-label">Cancelled</div>
          </div>
        </div>

        <div class="glass-card p-4 slide-in-up mb-4">
          <div class="table-section-header">
            <h4><i class="bi bi-table me-2 text-sky"></i>All Leave Requests</h4>
          </div>

          <div class="filter-bar">
            <div class="search-box">
              <i class="bi bi-search"></i>
              <input type="text" class="form-control glass-input" id="tableSearch"
                     placeholder="Search by ID, type, user, or status...">
            </div>
            <select class="filter-select" id="statusFilter">
              <option value="all">All Status</option>
              <option value="PENDING">Pending</option>
              <option value="APPROVED">Approved</option>
              <option value="REJECTED">Rejected</option>
              <option value="CANCELLED">Cancelled</option>
            </select>
          </div>

          <% if (allRequests == null || allRequests.isEmpty()) { %>
            <div class="empty-state">
              <i class="bi bi-inbox"></i>
              <p>No leave requests found in the system.</p>
            </div>
          <% } else { %>
            <div class="table-wrapper">
              <table class="glass-table">
                <thead>
                  <tr>
                    <th>Leave ID</th>
                    <th>User ID</th>
                    <th>Leave Type</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Reason</th>
                    <th>Status</th>
                    <th>Applied Date</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <% for (LeaveRequest lr : allRequests) {
                       String status = lr.getStatus() != null ? lr.getStatus().toUpperCase() : "PENDING";
                       String badgeClass = "badge-pending";
                       if ("APPROVED".equals(status)) badgeClass = "badge-approved";
                       else if ("REJECTED".equals(status)) badgeClass = "badge-rejected";
                       else if ("CANCELLED".equals(status)) badgeClass = "badge-cancelled";

                       String reason = lr.getReason() != null ? lr.getReason() : "";
                       if (reason.length() > 40) reason = reason.substring(0, 40) + "...";

                       String searchData = lr.getLeaveId() + " " + lr.getUserId() + " "
                           + lr.getLeaveType() + " " + status;
                  %>
                  <tr data-status="<%= status %>"
                      data-searchable="<%= searchData %>">
                    <td><strong class="text-white">#<%= lr.getLeaveId() %></strong></td>
                    <td><%= lr.getUserId() %></td>
                    <td><%= lr.getLeaveType() %></td>
                    <td><%= lr.getStartDate() %></td>
                    <td><%= lr.getEndDate() %></td>
                    <td title="<%= lr.getReason() != null ? lr.getReason() : "" %>"><%= reason %></td>
                    <td><span class="badge-status <%= badgeClass %>"><%= status %></span></td>
                    <td><%= lr.getAppliedDate() != null ? lr.getAppliedDate() : "-" %></td>
                    <td>
                      <% if ("PENDING".equals(status)) { %>
                        <a href="#"
                           onclick="return confirmAction('<%= ctx %>/leaveAction?leaveId=<%= lr.getLeaveId() %>&action=approve', 'Approve this leave request?');"
                           class="btn-action btn-approve me-1">
                          <i class="bi bi-check-lg"></i> Approve
                        </a>
                        <a href="#"
                           onclick="return confirmAction('<%= ctx %>/leaveAction?leaveId=<%= lr.getLeaveId() %>&action=reject', 'Reject this leave request?');"
                           class="btn-action btn-reject">
                          <i class="bi bi-x-lg"></i> Reject
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

        <div class="stats-section slide-in-up">
          <div class="table-section-header mb-3">
            <h4><i class="bi bi-bar-chart me-2 text-sky"></i>Statistics</h4>
          </div>
          <div class="stats-grid">
            <div class="glass-card stat-bar-item progress-pending">
              <div class="stat-bar-header">
                <span>Pending</span>
                <strong><%= pendingCount %> (<%= pendingPct %>%)</strong>
              </div>
              <div class="progress-glass">
                <div class="progress-fill" data-width="<%= pendingPct %>" style="width: 0;"></div>
              </div>
            </div>
            <div class="glass-card stat-bar-item progress-approved">
              <div class="stat-bar-header">
                <span>Approved</span>
                <strong><%= approvedCount %> (<%= approvedPct %>%)</strong>
              </div>
              <div class="progress-glass">
                <div class="progress-fill" data-width="<%= approvedPct %>" style="width: 0;"></div>
              </div>
            </div>
            <div class="glass-card stat-bar-item progress-rejected">
              <div class="stat-bar-header">
                <span>Rejected</span>
                <strong><%= rejectedCount %> (<%= rejectedPct %>%)</strong>
              </div>
              <div class="progress-glass">
                <div class="progress-fill" data-width="<%= rejectedPct %>" style="width: 0;"></div>
              </div>
            </div>
            <div class="glass-card stat-bar-item progress-cancelled">
              <div class="stat-bar-header">
                <span>Cancelled</span>
                <strong><%= cancelledCount %> (<%= cancelledPct %>%)</strong>
              </div>
              <div class="progress-glass">
                <div class="progress-fill" data-width="<%= cancelledPct %>" style="width: 0;"></div>
              </div>
            </div>
          </div>
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
