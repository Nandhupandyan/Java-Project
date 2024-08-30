<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String username = (String) session.getAttribute("username");
    Double balance = (Double) session.getAttribute("balance");

    if (username == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
    body
    {
background-image: url('bb.jfif');
background-repeat:no-repeat;
background-attachment:fixed;
background-size:cover;
}
</style>
    <link rel="stylesheet" href="dashboard.css">
</head>
<body>
    <div class="dashboard-container">
        <h1>Welcome, <%= username %>!</h1>
        <p>Your current balance is: ₹<%= balance %></p>

        <form action="transaction.jsp" method="post">
            <input type="number" name="amount" step="0.01" placeholder="Enter Amount" required>
            <button type="submit" name="action" value="Deposit">Deposit</button>
            <button type="submit" name="action" value="Withdraw">Withdraw</button>
        </form>
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </div>
</body>
</html>
