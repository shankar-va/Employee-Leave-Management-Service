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

import com.project.model.LeaveRequest;
import com.project.model.User;
import com.project.service.LeaveService;

@WebServlet("/myLeaves")
public class ViewLeavesServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		String contextPath=request.getContextPath();
		User user=(User)session.getAttribute("user");
		if(session==null) {
			response.sendRedirect(contextPath+"/login");
			return;
		}
		if(user==null) {
				response.sendRedirect(contextPath+"/login");
				return;
			}
		Integer userId=user.getId();
		List<LeaveRequest>list=LeaveService.viewLeaves(userId);
		if(list==null)  {
			request.setAttribute("leaves", Collections.emptyList());
		}else {
			request.setAttribute("leaves", list);
		}
		
		RequestDispatcher requestDispatcher=request.getRequestDispatcher("myLeaves.jsp");
		requestDispatcher.forward(request, response);		
	}
}
