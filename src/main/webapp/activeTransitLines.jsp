<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>5 Trains with the Most Reservations</title>
</head>
<body>
    <div class="container">
        <h1>Active trains: 5 Trains with the Most Reservations a Month</h1>
        <%
            // Connect to database
            String url = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC"; 
            String username = "jasminejustin7"; // replace with your username
            String password = "BlackLagoon2006!"; // replace with your password

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            // Create query to find 5 most active lines based on reservations
            String query = "SELECT ts.tl_name, COUNT(r.r_id) AS num_reservations "
                         + "FROM train_schedule ts "
                         + "JOIN train_station tst ON ts.tl_name = tst.tl_name "  // Corrected join condition
                         + "JOIN stations os ON tst.s_id = os.s_id "
                         + "JOIN stations ds ON tst.s_id = ds.s_id "
                         + "JOIN reservations r ON (os.s_id = r.os_id OR ds.s_id = r.ds_id) "
                         + "GROUP BY ts.tl_name "
                         + "ORDER BY num_reservations DESC "
                         + "LIMIT 5";

            try {
                // Load MySQL JDBC driver, instantiate conn and stmt
                Class.forName("com.mysql.jdbc.Driver");  // Updated driver class
                conn = DriverManager.getConnection(url, username, password);
                stmt = conn.createStatement();

                rs = stmt.executeQuery(query);
        %>         
                    <table border="1">
                        <tr>
                            <th>Transit Line Name</th>
                            <th>Number of Reservations</th>
                        </tr>
                    <% 
                    while (rs.next()) {
                        String trainLine = rs.getString("tl_name");
                        int numRes = rs.getInt("num_reservations");
                    %>
                        <tr>
                            <td><%= trainLine %></td>
                            <td><%= numRes %></td>
                        </tr>
                    <% 
                    } 
                    %>
                    </table>
        <% 
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
