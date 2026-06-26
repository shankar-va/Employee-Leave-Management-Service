<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.project.model.User" %>
<%
  String ctx = request.getContextPath();
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect(ctx + "/login");
    return;
  }

  String failure = (String) request.getAttribute("failure");
  String leaveType = request.getAttribute("leaveType") != null ? (String) request.getAttribute("leaveType") : "";
  String startDate = request.getAttribute("startDate") != null ? request.getAttribute("startDate").toString() : "";
  String endDate = request.getAttribute("endDate") != null ? request.getAttribute("endDate").toString() : "";
  String reason = request.getAttribute("reason") != null ? (String) request.getAttribute("reason") : "";

  request.setAttribute("activePage", "apply");
  request.setAttribute("pageTitle", "Apply Leave");
  request.setAttribute("pageSubtitle", "Submit a new leave request");
  request.setAttribute("shimmerType", "form");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Apply Leave | ELMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
          <h2>Apply for Leave</h2>
          <p>Fill in the details below to submit your leave request</p>
        </div>

        <div class="row justify-content-center">
          <div class="col-lg-8">
            <div class="glass-card form-card slide-in-up">
              <% if (failure != null) { %>
                <div class="alert-glass alert-glass-danger mb-4">
                  <i class="bi bi-exclamation-circle"></i>
                  <span><%= failure %></span>
                </div>
              <% } %>

              <form action="<%= ctx %>/applyLeave" method="post" data-shimmer-submit data-shimmer-type="form" novalidate>
                <div class="form-group-custom">
                  <label for="leaveType"><i class="bi bi-tag me-1"></i> Leave Type</label>
                  <select class="form-select" id="leaveType" name="leaveType" required>
                    <option value="" disabled <%= leaveType.isEmpty() ? "selected" : "" %>>Select leave type</option>
                    <option value="PERSONAL"  <%= "PERSONAL".equals(leaveType) ? "selected" : "" %>>Personal Leave</option>
                    <option value="SICK"      <%= "SICK".equals(leaveType) ? "selected" : "" %>>Sick Leave</option>
                    <option value="CASUAL"    <%= "CASUAL".equals(leaveType) ? "selected" : "" %>>Casual Leave</option>
                    <option value="EMERGENCY" <%= "EMERGENCY".equals(leaveType) ? "selected" : "" %>>Emergency Leave</option>
                    <option value="VACATION"  <%= "VACATION".equals(leaveType) ? "selected" : "" %>>Vacation Leave</option>
                  </select>
                </div>

                <div class="form-grid-2">
                  <div class="form-group-custom">
                    <label for="startDate"><i class="bi bi-calendar-event me-1"></i> Start Date</label>
                    <input type="date" class="form-control" id="startDate" name="startDate"
                           value="<%= startDate %>" required>
                  </div>
                  <div class="form-group-custom">
                    <label for="endDate"><i class="bi bi-calendar-check me-1"></i> End Date</label>
                    <input type="date" class="form-control" id="endDate" name="endDate"
                           value="<%= endDate %>" required>
                  </div>
                </div>
                <div class="field-error" id="dateError"></div>

                <div class="form-group-custom">
                  <label for="reason"><i class="bi bi-chat-left-text me-1"></i> Reason</label>
                  <textarea class="form-control" id="reason" name="reason" rows="4"
                            maxlength="500" placeholder="Describe the reason for your leave..." required><%= reason %></textarea>
                  <div class="char-counter" id="charCounter">0 / 500</div>
                </div>

                <div class="form-actions">
                  <button type="submit" class="btn btn-glass ripple">
                    <i class="bi bi-send me-2"></i>Submit Leave Request
                  </button>
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
</body>
</html>
