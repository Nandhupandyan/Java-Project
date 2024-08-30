<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");

            // Create a PreparedStatement to prevent SQL injection
            String query = "SELECT * FROM details WHERE username = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);

            // Execute the query
            ResultSet rs = ps.executeQuery();

            // Check if a matching record was found
            if (rs.next()) {
                // Valid credentials, set session and redirect to the dashboard
                session.setAttribute("username", username);
                response.sendRedirect("dashboard.jsp");
            } else {
                // Invalid credentials
                out.println("<script>alert('Invalid username or password!');</script>");
                out.println("<script>window.location.href='login.html';</script>");
            }

            // Close resources
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred!');</script>");
        }
    } else {
        out.println("<script>alert('Please enter both username and password!');</script>");
        out.println("<script>window.location.href='login.html';</script>");
    }
%>
