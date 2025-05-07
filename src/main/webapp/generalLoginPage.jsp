<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Railway Booking System</title>
    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        h2 {
            color: #2c3e50;
            margin-top: 50px;
        }

        /* Container for the page content */
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        /* Styling for the buttons */
        form button {
            background-color: #3498db;
            color: white;
            font-size: 16px;
            padding: 15px 30px;
            margin: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        form button:hover {
            background-color: #2980b9;
        }

        form button:focus {
            outline: none;
        }

        /* Styling for the heading */
        h1 {
            font-size: 36px;
            color: #2c3e50;
        }

        /* Spacing between elements */
        .buttons-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to 336 Railway</h1>
        <h2>Select a page to go to:</h2>

        <div class="buttons-container">
            <!-- Button 1: Redirects to Admin Login -->
            <form action="adminLogin.jsp" method="get">
                <button type="submit">Go to Admin Login</button>
            </form>

            <!-- Button 2: Redirects to Employee Login -->
            <form action="employeeLogin.jsp" method="get">
                <button type="submit">Go to Employee Login</button>
            </form>

            <!-- Button 3: Redirects to Customer Login -->
            <form action="customerLogin.jsp" method="get">
                <button type="submit">Go to Customer Login</button>
            </form>
        </div>
    </div>
</body>
</html>
