# Employee Leave Management System

<div align="center">

![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge\&logo=java)
![JSP](https://img.shields.io/badge/JSP-Servlets-blue?style=for-the-badge)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-336791?style=for-the-badge\&logo=postgresql)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5-purple?style=for-the-badge\&logo=bootstrap)
![MVC](https://img.shields.io/badge/Architecture-MVC-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

### A Secure and Modern Employee Leave Management System built using Java EE, JSP, Servlets, JDBC, and PostgreSQL.

Manage employee leave requests efficiently with role-based access control, real-time leave tracking, and an intuitive user experience.

</div>

---

## 📖 Overview

The **Employee Leave Management System (ELMS)** is a full-stack Java EE web application designed to simplify the process of applying, managing, and approving employee leave requests.

The system provides two separate dashboards:

* **Employee Dashboard** – Apply for leave, track requests, and manage leave history.
* **Admin Dashboard** – Manage employees and approve or reject leave requests.

The application follows the **MVC (Model-View-Controller)** design pattern and implements **Session-Based Authentication** and **Role-Based Authorization**.

---

# ✨ Features

## 🔐 Authentication & Security

* User Registration
* Secure Login System
* Password Hashing
* Session-Based Authentication
* Role-Based Authorization
* Logout Functionality
* Route Protection using Filters

---

## 👨‍💼 Employee Features

* Apply for Leave
* View Leave History
* Cancel Pending Leave Requests
* View Dashboard Statistics
* Profile Management
* Change Password

---

## 👨‍💻 Admin Features

* Dashboard Analytics
* View All Leave Requests
* Approve Leave Requests
* Reject Leave Requests
* Employee Management
* Search Employees
* Update Employee Information
* Delete Employees
* View Leave Statistics

---

# 🏗 System Architecture

The project follows the **MVC Architecture**.

```text
Presentation Layer (JSP + Bootstrap)
            ↓
Controller Layer (Servlets)
            ↓
Service Layer
            ↓
DAO Layer (JDBC)
            ↓
PostgreSQL Database
```

---

# 🛠 Tech Stack

## Backend

* Java
* JSP
* Servlets
* JDBC
* Apache Tomcat

## Frontend

* HTML5
* CSS3
* Bootstrap 5
* JavaScript
* JSP

## Database

* PostgreSQL

## Architecture

* MVC Design Pattern
* DAO Pattern
* Layered Architecture

---

# 📂 Project Structure

```text
Employee-Leave-Management-System
│
├── src/main/java
│
├── com.project.model
│   ├── User.java
│   └── LeaveRequest.java
│
├── com.project.dao
│   ├── UserDAO.java
│   └── LeaveDAO.java
│
├── com.project.daoimpl
│   ├── UserDAOImpl.java
│   └── LeaveDAOImpl.java
│
├── com.project.service
│   ├── UserService.java
│   └── LeaveService.java
│
├── com.project.controller
│   ├── RegisterServlet.java
│   ├── LoginServlet.java
│   ├── LogoutServlet.java
│   ├── ApplyLeaveServlet.java
│   ├── ViewLeavesServlet.java
│   ├── LeaveActionServlet.java
│   ├── AdminDashboardServlet.java
│   ├── ViewEmployeesServlet.java
│   ├── UpdateEmployeeServlet.java
│   ├── DeleteEmployeeServlet.java
│   └── ChangePasswordServlet.java
│
├── com.project.filter
│   └── AuthFilter.java
│
├── com.project.util
│   ├── DBConnection.java
│   ├── PasswordUtil.java
│   └── Validator.java
│
├── src/main/webapp
│   ├── jsp files
│   ├── css
│   ├── js
│   └── images
│
└── pom.xml
```

---

# 🗄 Database Schema

## users_emp

| Column     | Type    |
| ---------- | ------- |
| id         | SERIAL  |
| name       | VARCHAR |
| email      | VARCHAR |
| password   | VARCHAR |
| role       | VARCHAR |
| department | VARCHAR |
| phone      | VARCHAR |

---

## leave_requests_emp

| Column       | Type      |
| ------------ | --------- |
| leave_id     | SERIAL    |
| user_id      | INTEGER   |
| leave_type   | VARCHAR   |
| start_date   | DATE      |
| end_date     | DATE      |
| reason       | TEXT      |
| status       | VARCHAR   |
| applied_date | TIMESTAMP |

---

# 🚀 Getting Started

## Prerequisites

* Java 17+
* Eclipse IDE / IntelliJ IDEA
* Apache Tomcat 10+
* PostgreSQL 15+
* Maven

---

# Installation

## Clone Repository

```bash
git clone https://github.com/your-username/employee-leave-management-system.git
```

```bash
cd employee-leave-management-system
```

---

## Create Database

```sql
CREATE DATABASE employee_leave_management;
```

---

## Configure Database

Update your database credentials in:

```java
DBConnection.java
```

```java
private static final String URL =
        "YOUR JDBC URL";

private static final String USERNAME =
        "YOUR DB USERNAME";

private static final String PASSWORD =
        "YOUR DB PASSWORD";
```

---

## Run the Application

1. Import as Maven Project.
2. Configure Apache Tomcat.
3. Build Project.
4. Run on Server.

Application:

```text
http://localhost:8080/EmployeeLeaveManagement/
```

---

# 📸 Screenshots

Add screenshots here:

```text
screenshots/
├── home.png
├── login.png
├── register.png
├── admin-dashboard.png
├── employee-dashboard.png
├── apply-leave.png
├── leave-history.png
```

---

# 🔒 Security Features

* Password Hashing
* Session Management
* Route Protection using Servlet Filters
* Role-Based Access Control
* Form Validation
* SQL Injection Prevention using Prepared Statements

---

# 🧪 Testing Checklist

### Authentication

* [x] Register User
* [x] Login User
* [x] Logout User

### Employee Module

* [x] Apply Leave
* [x] View Leaves
* [x] Cancel Leave

### Admin Module

* [x] Approve Leave
* [x] Reject Leave
* [x] Employee Management

---

# 🎯 Future Enhancements

* Email Notifications
* Leave Balance Management
* Department Wise Reports
* Pagination
* REST APIs
* JWT Authentication
* Docker Deployment
* Cloud Deployment
* PDF Report Generation
* Admin Analytics Dashboard

---

# 👨‍💻 Author

### Shankar V

Aspiring Software Developer | Java | DSA | Full Stack Development

* GitHub: https://github.com/shankar-va
* LinkedIn: https://www.linkedin.com/in/shankar-v-6306a32a0/
* LeetCode: https://leetcode.com/u/D77YQlo87I/e

---

# ⭐ Show Your Support

If you found this project useful, please consider giving it a ⭐ on GitHub.

---

# 📜 License

This project is licensed under the MIT License.

```text
MIT License

Copyright (c) 2026 Shankar V

Permission is hereby granted, free of charge,
to any person obtaining a copy of this software
and associated documentation files.
```

---

<div align="center">

### Built with ❤️ using Java EE and PostgreSQL

</div>
