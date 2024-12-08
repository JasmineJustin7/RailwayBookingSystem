<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Railway Booking System</title>
</head>
<body>
    <h2>Select a page to go to:</h2>
    
    <!-- Button 1: Redirects to Page 1 -->
    <form action="adminLogin.jsp" method="get">
        <button type="submit">Go to Admin Login</button>
    </form>
    
    <!-- Button 2: Redirects to Page 2 -->
    <form action="employeeLogin.jsp" method="get">
        <button type="submit">Go to Employee Login</button>
    </form>
    
    <!-- Button 3: Redirects to Page 3 -->
    <form action="customerLogin.jsp" method="get">
        <button type="submit">Go to Customer Login</button>
    </form>
</body>
</html>