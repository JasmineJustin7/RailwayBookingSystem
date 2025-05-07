<%@ page import="java.sql.*" %>
<%
    // Retrieve the form data
    String tl_name = request.getParameter("tl_name");
    String travel_time = request.getParameter("travel_time");
    String fareStr = request.getParameter("fare");
    String stopsStr = request.getParameter("stops");

    // Validate the input
    if (tl_name == null || tl_name.trim().isEmpty() || travel_time == null || fareStr == null || stopsStr == null) {
        out.println("<p>Error: All fields are required.</p>");
        return;
    }

    // Convert fare and stops to appropriate data types
    Double fare = Double.parseDouble(fareStr);
    int stops = Integer.parseInt(stopsStr);

    // JDBC connection setup
    String myUsername = "jasminejustin7";
    String myPassword = "BlackLagoon2006!";
    String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);

        // Update the train schedule record in the database
        //String updateSQL = "UPDATE train_schedule SET travel_time = ?, fare = ?, stops = ? WHERE tl_name = ?";
        String updateSQL = "UPDATE train_schedule SET travel_time = ?, fare = ?, stops = ? WHERE tl_name = ?";
        stmt = conn.prepareStatement(updateSQL);
        stmt.setTime(1, Time.valueOf(travel_time)); // Set the travel time
        stmt.setDouble(2, fare); // Set the fare
        stmt.setInt(3, stops); // Set the number of stops
        stmt.setString(4, tl_name); // Set the train line name

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("<p>Train schedule updated successfully!</p>");
            out.println("<br><a href='editTrainSchedule.jsp'>Go back to the schedule page</a>");
        } else {
            out.println("<p>Error: No schedule found with the specified train line name.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
