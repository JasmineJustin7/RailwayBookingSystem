<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
</head>
<body>
    <h2>Welcome to Admin Login</h2>
    	<form action="adminAuthentication.jsp" method="POST">
	Username: <input type="text" name="username"/> <br/>
	Password:<input type="password" name="password"/> <br/>
	<input type="submit" value="Submit"/>
	</form>
    <a href="generalLoginPage.jsp">Go back to the main page</a>
</body>
</html>