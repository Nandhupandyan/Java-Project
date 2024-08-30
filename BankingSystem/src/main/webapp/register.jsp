<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String mobileno = request.getParameter("mobileno");

    if (username != null && password != null && mobileno != null) {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", ""); // Replace with your database credentials

            // Prepare and execute the SQL statement
            PreparedStatement ps = con.prepareStatement("INSERT INTO details (username, password, mobileno, balance) VALUES (?, ?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, mobileno);
            ps.setDouble(4, 0); // Set default balance to 0

            int result = ps.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('Registration successful!');</script>");
                response.sendRedirect("login.html");
            } else {
                out.println("<script>alert('Registration failed! Please try again.');</script>");
            }

            // Close resources
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace(); // Print error details for debugging
            out.println("<script>alert('An error occurred: " + e.getMessage() + "');</script>");
        }
    } else {
        out.println("<script>alert('All fields are required!');</script>");
    }
    

    

%>
