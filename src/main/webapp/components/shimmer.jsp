<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String shimmerType = request.getAttribute("shimmerType") != null
      ? (String) request.getAttribute("shimmerType") : "auth";
%>
<div id="shimmerScreen" class="shimmer-screen" data-type="<%= shimmerType %>">
  <% if ("dashboard".equals(shimmerType)) { %>
    <div class="shimmer-dashboard">
      <div class="shimmer-sidebar">
        <div class="shimmer-block shimmer-sidebar-brand"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
      </div>
      <div class="shimmer-main">
        <div class="shimmer-block shimmer-navbar"></div>
        <div class="shimmer-stat-row">
          <div class="shimmer-block shimmer-stat-card"></div>
          <div class="shimmer-block shimmer-stat-card"></div>
          <div class="shimmer-block shimmer-stat-card"></div>
          <div class="shimmer-block shimmer-stat-card"></div>
        </div>
        <div class="shimmer-block shimmer-table-block"></div>
      </div>
    </div>
  <% } else if ("table".equals(shimmerType)) { %>
    <div class="shimmer-table-wrap">
      <div class="shimmer-sidebar">
        <div class="shimmer-block shimmer-sidebar-brand"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
      </div>
      <div class="shimmer-main">
        <div class="shimmer-block shimmer-navbar"></div>
        <div class="shimmer-filter-row">
          <div class="shimmer-block shimmer-filter"></div>
          <div class="shimmer-block shimmer-filter shimmer-filter-sm"></div>
        </div>
        <div class="shimmer-block shimmer-table-block"></div>
      </div>
    </div>
  <% } else if ("form".equals(shimmerType)) { %>
    <div class="shimmer-form-wrap">
      <div class="shimmer-sidebar">
        <div class="shimmer-block shimmer-sidebar-brand"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
        <div class="shimmer-block shimmer-sidebar-link"></div>
      </div>
      <div class="shimmer-form-main">
        <div class="shimmer-block shimmer-navbar"></div>
        <div class="shimmer-form-card">
          <div class="shimmer-block shimmer-auth-title" style="width:50%;margin-bottom:1.5rem;"></div>
          <div class="shimmer-block shimmer-form-field"></div>
          <div class="shimmer-block shimmer-form-field"></div>
          <div class="shimmer-block shimmer-form-textarea"></div>
          <div class="shimmer-block shimmer-auth-btn"></div>
        </div>
      </div>
    </div>
  <% } else { %>
    <div class="shimmer-auth">
      <div class="shimmer-auth-card">
        <div class="shimmer-block shimmer-auth-logo"></div>
        <div class="shimmer-block shimmer-auth-title"></div>
        <div class="shimmer-block shimmer-auth-sub"></div>
        <div class="shimmer-block shimmer-auth-field"></div>
        <div class="shimmer-block shimmer-auth-field"></div>
        <div class="shimmer-block shimmer-auth-btn"></div>
      </div>
    </div>
  <% } %>
</div>
