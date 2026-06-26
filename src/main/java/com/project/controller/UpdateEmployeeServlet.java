package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.project.model.User;
import com.project.service.UserService;

@WebServlet("/updateEmployee")
public class UpdateEmployeeServlet
        extends HttpServlet {

    public void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Integer id =
                Integer.parseInt(
                        request.getParameter("id"));

        User user =
                UserService.getById(id);

        if (user == null || "admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("employees");
            return;
        }

        request.setAttribute(
                "employee",
                user);

        request.getRequestDispatcher(
                "updateEmployee.jsp")
                .forward(request, response);
    }

    public void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String context =
                request.getContextPath();

        Integer id =
                Integer.parseInt(
                        request.getParameter("id"));

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String role =
                request.getParameter("role");

        String department =
                request.getParameter("department");

        String phone =
                request.getParameter("phone");

        boolean result =
                UserService.update(
                        id,
                        name,
                        email,
                        role,
                        department,
                        phone);

        HttpSession session =
                request.getSession();

        if (result) {
            session.setAttribute(
                    "success",
                    "Employee updated successfully.");
        }
        else {
            session.setAttribute(
                    "failure",
                    "Unable to update employee.");
        }

        response.sendRedirect(
                context + "/employees");
    }
}


