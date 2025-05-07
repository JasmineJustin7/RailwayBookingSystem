<html>
<head>
    <title>Login Details</title>
</head>
<body>
    <h2>Login Details</h2>
    
    <%
        // Get the username and password from the request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // For demonstration purposes, let's display the login details
        // In a real application, do not display the password directly for security reasons!
        
        if (username != null && password != null) {
            out.println("<p>Username: " + username + "</p>");
            out.println("<p>Password: " + password + "</p>");
        } else {
            out.println("<p>Invalid login details.</p>");
        }
    %>
    
</body>
</html>