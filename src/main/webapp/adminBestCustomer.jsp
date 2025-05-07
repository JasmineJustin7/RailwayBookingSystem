<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Best Customer</title>
</head>
<body>
    <div class="container">
        <h1>Best Customer: Customer with the Most Revenue</h1>
        <%
            // Connect to database
            String url = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC"; 
            String username = "jasminejustin7"; // replace with your username
            String password = "BlackLagoon2006!"; // replace with your password

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            // SQL Query to find best customer/generated most revenue
            String query = "SELECT c.c_id, c.f_name, c.l_name, SUM(r.total_fare) AS total_revenue "
                         + "FROM reservations r "
                         + "JOIN customers c ON r.c_id = c.c_id "
                         + "GROUP BY r.c_id "
                         + "ORDER BY total_revenue DESC "
                         + "LIMIT 1";

            try {
                // Load MySQL JDBC driver, instantiate conn and stmt
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
                stmt = conn.createStatement();

                rs = stmt.executeQuery(query);

                // first tuple contains best customer
                if (rs.next()) {
                    // retrieve info
                    String cid = rs.getString("c_id");
                    String fname = rs.getString("f_name");
                    String lname = rs.getString("l_name");
                    double totRev = rs.getDouble("total_revenue");
        %>
                    <table border="1">
                        <tr>
                            <th>Customer ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Total Revenue</th>
                        </tr>
                        <tr>
                            <td><%= cid %></td>
                            <td><%= fname %></td>
                            <td><%= lname %></td>
                            <td><%= totRev %></td>
                        </tr>
                    </table>
        <% } else { %>
                    <p>No customers found.</p>
        <% } %>
        
        <%
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("Error: " + e.getMessage());
            } finally {
                // Close the resources
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
