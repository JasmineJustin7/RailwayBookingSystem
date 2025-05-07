<%@ page import="java.sql.*, java.util.*" %>
<%
    // JDBC connection setup
    String myUsername = "jasminejustin7";
    String myPassword = "BlackLagoon2006!";
    String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        conn = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);
        stmt = conn.createStatement();

        // Retrieve all the train schedule data
        String sql = "SELECT * FROM train_schedule";
        rs = stmt.executeQuery(sql);

        // Check if there are any records available
        if (rs.next()) {
            // Display the schedule data for editing
%>

<%-- Displaying form with current schedule details --%>
<h2>Edit Train Schedule</h2>
<form action="updateTrainSchedule.jsp" method="post">
    <label for="tl_name">Train Line Name (tl_name):</label>
    <input type="text" name="tl_name" id="tl_name" value="<%= rs.getString("tl_name") %>" required><br><br>

    <label for="travel_time">Travel Time:</label>
    <input type="text" name="travel_time" id="travel_time" value="<%= rs.getTime("travel_time").toString().substring(0, 5) %>" required><br><br>

    <label for="fare">Fare:</label>
    <input type="number" step="0.01" name="fare" id="fare" value="<%= rs.getBigDecimal("fare").toString() %>" required><br><br>

    <label for="stops">Number of Stops:</label>
    <input type="number" name="stops" id="stops" value="<%= rs.getInt("stops") %>" required><br><br>

    <input type="submit" value="Update Train Schedule">
</form>

<%  } else {
            out.println("<p>No train schedule data found.</p>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
