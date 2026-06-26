package com.project.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import com.project.model.LeaveRequest;
import com.project.model.User;
import com.project.service.LeaveService;
import com.project.service.UserService;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		String contextPath=request.getContextPath();
		if(session==null ) {
			response.sendRedirect(contextPath+"/login");
			return;
		}
		User user=(User)session.getAttribute("user");
		if(user==null || !"admin".equalsIgnoreCase(user.getRole())) {
			response.sendRedirect(contextPath+"/login");
			return;
		}
		Integer employeeCount= UserService.count();
		Map<String,List<LeaveRequest>>map= LeaveService.dashboard();
		if(map==null)Collections.emptyMap();
		List<LeaveRequest> pending=map.get("PENDING");
		List<LeaveRequest> approved=map.get("APPROVED");
		List<LeaveRequest> rejected=map.get("REJECTED");
		List<LeaveRequest> cancelled=map.get("CANCELLED");
		Integer pendingCount=pending!=null?pending.size():0;
		Integer approvedCount=approved!=null?approved.size():0;
		Integer rejectedCount=rejected!=null?rejected.size():0;
		Integer cancelledCount=cancelled!=null?cancelled.size():0;
		List<LeaveRequest>list= LeaveService.viewAllRequests();
		if(list==null)list=Collections.emptyList();
		request.setAttribute("employeeCount", employeeCount);
		request.setAttribute("pendingCount", pendingCount);
		request.setAttribute("approvedCount", approvedCount);
		request.setAttribute("rejectedCount", rejectedCount);
		request.setAttribute("cancelledCount", cancelledCount);
		request.setAttribute("allRequests", list);
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("admin.jsp");
		requestDispatcher.forward(request, response);
		
	}
}
