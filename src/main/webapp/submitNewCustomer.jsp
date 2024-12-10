<%@ page import ="java.sql.*" %>
<%

// Get user input from the form
	String first_name = request.getParameter("f_name");
	String last_name = request.getParameter("l_name");
	String email = request.getParameter("email");
	String userid = request.getParameter("username");
	String pwd = request.getParameter("p_word");
	
    // Validate the input fields
    if (first_name == null || first_name.trim().isEmpty() ||
        last_name == null || last_name.trim().isEmpty() ||
        email == null || email.trim().isEmpty() ||
        userid == null || userid.trim().isEmpty() ||
        pwd == null || pwd.trim().isEmpty()) {
        response.getWriter().println("All fields are required.");
        out.println("Invalid password <a href='registerNewCustomer.jsp'>try again</a>");
        return;
    }
	
	Class.forName("com.mysql.jdbc.Driver");
	String myUsername = "jasminejustin7";
	String myPassword = "BlackLagoon2006!";
	
	String jdbcURL = "jdbc:mysql://localhost:3306/railway_booking";
	
	
    // SQL query to insert data
    String sql = "INSERT INTO customers (f_name, l_name, username, p_word, email) VALUES (?, ?, ?, ?, ?)";
    
    
    // Establish database connection and insert data
    try (	
    		
    	Connection con = DriverManager.getConnection(jdbcURL, myUsername, myPassword);
		PreparedStatement statement = con.prepareStatement(sql)) {
   
        
        // Set the parameters for the SQL query
        statement.setString(1, first_name);
        statement.setString(2, last_name);
        statement.setString(3, userid);
        statement.setString(4, pwd);
        statement.setString(5, email);
        
        // Execute the query
        int rowsInserted = statement.executeUpdate();
        if (rowsInserted > 0) {
            response.getWriter().println("User added successfully! Welcome!");
            out.println("Go back to main page to login <a href='generalLoginPage.jsp'>Return to Main page</a>");
            
        } else {
            response.getWriter().println("Error occurred while adding user.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().println("Database connection error: " + e.getMessage());
    }
	

%>