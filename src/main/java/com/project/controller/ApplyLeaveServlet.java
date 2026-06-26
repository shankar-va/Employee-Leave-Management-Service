package com.project.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import com.project.model.LeaveRequest;
import com.project.model.User;
import com.project.service.LeaveService;

@WebServlet("/applyLeave")
public class ApplyLeaveServlet extends HttpServlet {
	

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	RequestDispatcher requestDispatcher=request.getRequestDispatcher("applyLeave.jsp");
		requestDispatcher.forward(request,response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		String contextPath=request.getContextPath();
		User user=(User)session.getAttribute("user");
		if(session==null || user==null) {
			response.sendRedirect(contextPath+"/login");
			return;
		}
	    
	    Integer id=user.getId();
	    String leaveType=request.getParameter("leaveType");
	    Date startDate=java.sql.Date.valueOf(request.getParameter("startDate"));
	    Date endDate=java.sql.Date.valueOf(request.getParameter("endDate"));
	    String reason= request.getParameter("reason");
	    LeaveRequest leave=new LeaveRequest(id,leaveType,startDate,endDate,reason);
	    System.out.println(leave);
	    boolean result = LeaveService.applyLeave(leave);
	    System.out.println("Result = " + result);

	    
	    if(result) {
	    	session.setAttribute("success", "Leave applied successfully.");
	    	response.sendRedirect(contextPath+"/myLeaves");
	    	return;
	    }else {
	    	request.setAttribute("leaveType", leaveType);
		    request.setAttribute("startDate", startDate);
		    request.setAttribute("endDate", endDate);
		    request.setAttribute("reason", reason);
	    	request.setAttribute("failure", "Unable to apply Leave.");
	    	RequestDispatcher requestDispatcher=request.getRequestDispatcher("applyLeave.jsp");
			requestDispatcher.forward(request,response);
	    }
	}

}
