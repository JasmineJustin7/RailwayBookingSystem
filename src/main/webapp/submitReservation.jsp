<%@ page import="java.sql.*" %>
<%
    // Get user input from the form to make reservation
    String email = request.getParameter("email");
    String trip_type = request.getParameter("trip_type");
    String date = request.getParameter("date");
    String train_name = request.getParameter("tl_name");
    String age = request.getParameter("age");
    String status = request.getParameter("status"); //disability status
    Double total_fare;
    String c_id = null;  // Initialize c_id to null
    int origin_station;
    int dest_station;
    
    // Validate the input fields
    if (trip_type == null || trip_type.trim().isEmpty() ||
        date == null || date.trim().isEmpty() ||
        train_name == null || train_name.trim().isEmpty() ||
        email == null || email.trim().isEmpty() || age == null || 
        age.trim().isEmpty() || status == null || status.trim().isEmpty() ) {
        
        response.getWriter().println("All fields are required.");
        out.println("Invalid reservation <a href='customerReservations.jsp'>try again</a>");
        return;
    }
    
    Class.forName("com.mysql.jdbc.Driver");
    String myUsername = "jasminejustin7";
    String myPassword = "BlackLagoon2006!";
    String jdbcURL = "jdbc:mysql://localhost:3306/railway_booking";

    // SQL query to get the c_id using email
    String getCustomerSQL = "SELECT c_id FROM customers WHERE email = ?";

    // SQL query to insert reservation data
    String sql = "INSERT INTO reservations (c_id, os_id, ds_id, total_fare, r_date, r_type) VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection con = DriverManager.getConnection(jdbcURL, myUsername, myPassword);
         PreparedStatement getCustomerStmt = con.prepareStatement(getCustomerSQL)) {

        // Query the database to get c_id based on the email
        getCustomerStmt.setString(1, email);
        ResultSet rs = getCustomerStmt.executeQuery();

        // Check if customer exists and retrieve c_id
        if (rs.next()) {
            c_id = rs.getString("c_id");
        } else {
            response.getWriter().println("No customer found with this email.");
            return;
        }

        // Determine the total fare and stations based on the train name
        if (train_name.equalsIgnoreCase("L")) {
            total_fare = 15.00;
            origin_station = 1;
            dest_station = 10;
        } else if (train_name.equalsIgnoreCase("B")) {
            total_fare = 12.00;
            origin_station = 1;
            dest_station = 10;
        } else if (train_name.equalsIgnoreCase("E")) {
            total_fare = 9.00;
            origin_station = 3;
            dest_station = 10;
        } else {
            out.println("Train Line is not available at this time.");
            return;
        }

        // If the trip type is round_trip, double the fare
        if (trip_type.equalsIgnoreCase("round_trip")) {
            total_fare = 2 * total_fare;
        }
        
        //Discount price for children and the elderly
        
        try {
        Integer number = Integer.valueOf(age); // Convert string to Integer
        } catch (NumberFormatException e) {
        	out.println("Invalid number format");
        	}
        if(Integer.valueOf(age) < 12){
        	total_fare = total_fare - 0.25 * total_fare;
        }else if(Integer.valueOf(age) > 64){
        	total_fare = total_fare - 0.35 * total_fare;
        }
        
        if(status.equalsIgnoreCase("yes")){
        	total_fare = total_fare * 0.5;
        }else if(status.equalsIgnoreCase("no")){
        }else{
        	out.println("Invalid status");
        	return;
        }
        

        // Insert the reservation into the database
        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setString(1, c_id);
            statement.setInt(2, origin_station);
            statement.setInt(3, dest_station);
            statement.setDouble(4, total_fare);
            statement.setString(5, date);
            statement.setString(6, trip_type);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                response.getWriter().println("Reservation successful! Welcome!");
                out.println("Go back to main page to login <a href='generalLoginPage.jsp'>Return to Main page</a>");
            } else {
                response.getWriter().println("Error occurred while adding reservation.");
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
        response.getWriter().println("Database connection error: " + e.getMessage());
    }
%>
