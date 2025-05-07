<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Schedule Search</title>
</head>
<body>

<h2>Search Train Schedules</h2>
<form action="browseSchedules.jsp" method="post">
    
    <label for="Train">Train:</label>
    <input type="text" id="train_id" name="train_id" required><br><br>
    
    <button type="submit">Search</button>
</form>
	<br>
	<a href="logout.jsp">Logout</a>
</body>
</html>