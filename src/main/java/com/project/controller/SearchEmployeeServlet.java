package com.project.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.project.model.User;
import com.project.service.UserService;

/**
 * Servlet implementation class serafd
 */
@WebServlet("/searchEmployee")
public class SearchEmployeeServlet
        extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        String type =
                request.getParameter("type");

        List<User> users;

        if ("name".equalsIgnoreCase(type)) {
            users =
                    UserService.searchName(
                            keyword);
        }
        else {
            users =
                    UserService.searchDept(
                            keyword);
        }

        request.setAttribute(
                "employees",
                users);

        request.getRequestDispatcher(
                "employees.jsp")
                .forward(request,
                        response);
    }
}
