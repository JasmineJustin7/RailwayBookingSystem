<%@ page import="java.sql.*, javax.sql.*, java.util.*" %>
<%
    // Database connection variables
    String url = "jdbc:mysql://localhost:3306/railway_booking";
    String user = "jasminejustin7";  // Replace with your MySQL username
    String password = "BlackLagoon2006!";  // Replace with your MySQL password

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    // Station name to search for
    String stationName = request.getParameter("stationName"); // Get the station name from the request

    // Code to handle form submission and display train schedules
    if (stationName != null && !stationName.isEmpty()) {
        try {
            // Establish connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // Prepare the SQL query to fetch train schedule for the selected station
            String query = "SELECT ts.tl_name, ts.dept_time, ts.arr_time, ts.s_id, s.s_name "
                         + "FROM train_station ts "
                         + "JOIN stations s ON ts.s_id = s.s_id "
                         + "WHERE s.s_name = ?";
            
            // Create a prepared statement
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, stationName);  // Set station name in the query
            
            // Execute the query
            rs = ps.executeQuery();

            // Check if any records are found
            if (rs.next()) {
%>
        <h2>Train Schedule for <%= stationName %> Station</h2>
        
        <table border="1">
            <tr>
                <th>Train Name</th>
                <th>Departure Time</th>
                <th>Arrival Time</th>
            </tr>
<%
            // Display the results in the table
            do {
%>
            <tr>
                <td><%= rs.getString("tl_name") %></td>
                <td><%= rs.getTime("dept_time") %></td>
                <td><%= rs.getTime("arr_time") %></td>
            </tr>
<%
            } while (rs.next()); // Loop through all the records
%>
        </table>
<%
        } else {
            out.println("<h3>No trains found for the selected station.</h3>");
            out.println("<a href='employeeAuthentication.jsp'>Go back to employee home page</a>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error occurred: " + e.getMessage() + "</h3>");
    } finally {
        try {
            // Close the connections
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
} else {
%>
    <!-- Form to select the station -->
    <h2>Select a Station to View Train Schedules</h2>
    <form action="viewTrainSchedule.jsp" method="get">
        <label for="stationName">Choose a station:</label>
        <select name="stationName" id="stationName">
            <option value="">--Select Station--</option>
<%
    try {
        // Query to get all stations from the database
        conn = DriverManager.getConnection(url, user, password);
        String stationQuery = "SELECT s_name FROM stations";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(stationQuery);

        // Loop through and display stations in the dropdown
        while (rs.next()) {
            String station = rs.getString("s_name");
%>
            <option value="<%= station %>"><%= station %></option>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h3>Error occurred: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
        </select>
        <input type="submit" value="View Schedule">
        
    </form>
<%
}
%>
