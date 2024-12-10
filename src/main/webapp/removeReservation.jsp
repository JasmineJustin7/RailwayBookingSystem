<%@ page import="java.sql.*" %>
<%
    String reservationId = request.getParameter("r_id"); // Get reservation ID from the URL parameter
    Connection con = null;
    Statement st = null;

    if (reservationId != null && !reservationId.isEmpty()) {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            String myUsername = "jasminejustin7";
            String myPassword = "BlackLagoon2006!";
            String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";

            // Establish Connection
            con = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);

            // Create Statement for executing the delete query
            st = con.createStatement();

            // SQL query to delete the reservation based on r_id
            String deleteQuery = "DELETE FROM reservations WHERE r_id = " + reservationId;

            // Execute the delete query
            int rowsAffected = st.executeUpdate(deleteQuery);

            // Check if a reservation was deleted
            if (rowsAffected > 0) {
                out.println("Reservation " + reservationId + " has been removed successfully.");
            } else {
                out.println("No reservation found with ID " + reservationId);
            }

            // Provide a link to return to the reservation page
            out.println("<br><a href='customerReservations.jsp'>Back to Your Reservations</a>");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Error loading MySQL driver: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("SQL Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.println("Invalid reservation ID.");
    }
%>
