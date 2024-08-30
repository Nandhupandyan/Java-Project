<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String username = (String) session.getAttribute("username");
    String action = request.getParameter("action");
    double amount = Double.parseDouble(request.getParameter("amount"));

    if (username == null) {
        response.sendRedirect("login.html");
        return;
    }

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");

        // Retrieve the current balance from the database
        PreparedStatement psSelect = con.prepareStatement("SELECT balance FROM details WHERE username = ?");
        psSelect.setString(1, username);
        ResultSet rs = psSelect.executeQuery();

        double balance = 0;

        if (rs.next()) {
            balance = rs.getDouble("balance");
        }

        // Update the balance based on the action
        if ("Deposit".equals(action)) {
            balance += amount;
        } else if ("Withdraw".equals(action)) {
            if (balance >= amount) {
                balance -= amount;
            } else {
                out.println("<script>alert('Insufficient funds!');</script>");
                response.sendRedirect("dashboard.jsp");
                return;
            }
        }

        // Update the balance in the database
        PreparedStatement psUpdate = con.prepareStatement("UPDATE details SET balance = ? WHERE username = ?");
        psUpdate.setDouble(1, balance);
        psUpdate.setString(2, username);
        psUpdate.executeUpdate();

        // Update the balance in the session
        session.setAttribute("balance", balance);

        // Redirect to the dashboard
        response.sendRedirect("dashboard.jsp");

        // Close resources
        rs.close();
        psSelect.close();
        psUpdate.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('An error occurred!');</script>");
        response.sendRedirect("dashboard.jsp");
    }
%>
