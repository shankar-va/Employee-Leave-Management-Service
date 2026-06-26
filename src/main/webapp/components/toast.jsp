<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String toastSuccess = (String) session.getAttribute("success");
  String toastFailure = (String) session.getAttribute("failure");
  String toastMessage = (String) session.getAttribute("message");
  if (toastSuccess != null) session.removeAttribute("success");
  if (toastFailure != null) session.removeAttribute("failure");
  if (toastMessage != null) session.removeAttribute("message");
%>
<div id="toastContainer" class="toast-container-custom"></div>
<input type="hidden" id="toastSuccess" value="<%= toastSuccess != null ? toastSuccess : "" %>" />
<input type="hidden" id="toastFailure" value="<%= toastFailure != null ? toastFailure : "" %>" />
<input type="hidden" id="toastMessage" value="<%= toastMessage != null ? toastMessage : "" %>" />
