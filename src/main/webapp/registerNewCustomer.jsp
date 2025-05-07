<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
</head>
<body>
    <h2>Welcome Customer!</h2>
    	<form action="submitNewCustomer.jsp" method="POST">
    		First Name: <input type="text" name="f_name"/> <br/>
			Last Name:<input type="text" name="l_name"/> <br/>
			Username: <input type="text" name="username"/> <br/>
			Password:<input type="password" name="p_word"/> <br/>
			Email: <input type="text" name="email"/> <br/>
			<input type="submit"value="Sign Up!"/>
		</form>
    <a href="generalLoginPage.jsp">Go back to the main page</a>
</body>
</html>