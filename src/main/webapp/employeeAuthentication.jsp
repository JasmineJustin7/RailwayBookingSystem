<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Retrieve user input
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");

    // Set the database connection parameters
    String myUsername = "jasminejustin7";
    String myPassword = "BlackLagoon2006!";
    
    // SQL query
    String query = "SELECT * FROM employees WHERE username = ? AND p_word = ?";

    try {
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a connection to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_booking", myUsername, myPassword);

        // Create a PreparedStatement to prevent SQL injection
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, userid); // Set the username parameter
        ps.setString(2, pwd);    // Set the password parameter

        // Execute the query
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // If a result is found, the login is successful
            session.setAttribute("user", userid); // Store the username in the session
            out.println("Welcome " + userid);
            
            out.println("<br>");
    		out.println("<a href='editTrainSchedule.jsp'>Edit Train Schedules</a>");
            out.println("<br>");
    		out.println("<a href='viewQuestions.jsp'>Answer Questions</a>");
            out.println("<br>");
    		out.println("<a href='viewTrainSchedule.jsp'>View Train Schedules</a>");
            out.println("<br>");
    		out.println("<a href='viewCustomerReservations.jsp'>Customer Info</a>");
            out.println("<br>");
            
            out.println("<a href='logout.jsp'>Log out</a>");
            //response.sendRedirect("success.jsp");  // Redirect to the success page
        } else {
            // If no matching record is found, show error
            out.println("Invalid username or password. <a href='generalLoginPage.jsp'>Try again</a>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();  // Log the exception for debugging
        out.println("An error occurred. Please try again later.");
    }
%>
