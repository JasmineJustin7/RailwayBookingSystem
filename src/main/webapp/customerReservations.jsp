<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Reservation</title>
</head>
<body>
    <h2>Please enter your Reservation Details!</h2>
    	<form action="submitReservation.jsp" method="POST">
    	Email: <input type="text" name="email"/> <br/>
    		Trip Type: <input type="text" name="trip_type"/> <br/>
    		Age: <input type="text" name="age"/> <br/>
    	<label for="date">Date of Travel:</label>
    <input type="date" id="date" name="date" required><br>
			Train:<input type="text" name="tl_name"/> <br/>
			Disability status:<input type="text" name="status"/><br>
			<input type="submit"value="Make reservation now"/>
		</form>
    <a href="customerAuthentication">Go back to customer home page</a>
</body>
</html>