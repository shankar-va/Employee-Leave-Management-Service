package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.project.service.UserService;
@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        String context =
                request.getContextPath();

        Integer id =
                Integer.parseInt(
                        request.getParameter("id"));

        if (UserService.delete(id)) {
            session.setAttribute(
                    "success",
                    "Employee deleted successfully.");
        }
        else {
            session.setAttribute(
                    "failure",
                    "Unable to delete employee.");
        }

        response.sendRedirect(
                context + "/employees");
    }
}