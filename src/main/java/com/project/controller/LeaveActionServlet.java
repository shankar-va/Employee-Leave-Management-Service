package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.project.model.User;
import com.project.service.LeaveService;

@WebServlet("/leaveAction")
public class LeaveActionServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		String contextPath=request.getContextPath();
		if(session==null ) {
			response.sendRedirect(contextPath+"/login");
			return;
		}
		User user=(User)session.getAttribute("user");
		if(user==null) {
			response.sendRedirect(contextPath+"/login");
			return;
		}

		Integer leaveId=Integer.parseInt(request.getParameter("leaveId"));
		String action=(String) request.getParameter("action");
		if( "admin".equalsIgnoreCase( user.getRole())&& "approve".equalsIgnoreCase(action)) {
		 	if(LeaveService.approveLeave(leaveId)) {
		 		session.setAttribute("success", "Leave"
		 				+ " approved successfully");
		 	}else {
		 		session.setAttribute("failure", "Cannot"
		 				+ " approve leave");
		 	}
		 	response.sendRedirect(contextPath+"/admin");
		}
		else if( "admin".equalsIgnoreCase( user.getRole()) &&"reject".equalsIgnoreCase(action)) {
			if(LeaveService.rejectLeave(leaveId)) {
		 		session.setAttribute("success", "Leave"
		 				+ " rejected successfully");
		 	}else {
		 		session.setAttribute("failure", "Cannot"
		 				+ " reject leave");
		 	}
			response.sendRedirect(contextPath+"/admin");
		}
		else if( "user".equalsIgnoreCase( user.getRole()) &&"cancel".equalsIgnoreCase(action)) {
			if(LeaveService.cancelLeave(leaveId)) {
		 		session.setAttribute("success", "Leave"
		 				+ " cancelled successfully");
		 	}else {
		 		session.setAttribute("failure", "Cannot"
		 				+ " cancel leave");
		 	}
			response.sendRedirect(contextPath+"/myLeaves");
		}
		else {
			session.setAttribute("failure", "Cannot"
	 				+ " Perform action");
			if("admin".equalsIgnoreCase(user.getRole()))response.sendRedirect(contextPath+"/admin");
			else response.sendRedirect(contextPath+"/myLeaves");
		}
	}

}
