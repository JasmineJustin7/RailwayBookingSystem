<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sales Reports</title>
</head>
<body>
<h1>Monthly Sales Report</h1>
<%
    // Database credentials
    String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";
    String myUsername = "jasminejustin7";
    String myPassword = "BlackLagoon2006!";

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish connection
        Connection con = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);

        // Query to calculate sales per month
        String salesQuery = "SELECT DATE_FORMAT(r_date, '%Y-%m') AS month, SUM(total_fare) AS revenue " +
                "FROM reservations " +
                "GROUP BY DATE_FORMAT(r_date, '%Y-%m') " +
                "ORDER BY month ASC";

        PreparedStatement stmt = con.prepareStatement(salesQuery);
        ResultSet rs = stmt.executeQuery();

        // Display sales report
        if (!rs.isBeforeFirst()) {
            out.println("<p>No sales data available.</p>");
        } else {
            out.println("<table border='1'>");
            out.println("<tr><th>Month</th><th>Total Revenue</th></tr>");
            while (rs.next()) {
                String month = rs.getString("month");
                double revenue = rs.getDouble("revenue");

                out.println("<tr>");
                out.println("<td>" + month + "</td>");
                out.println("<td>$" + revenue + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        rs.close();
        stmt.close();
        con.close();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error loading MySQL driver: " + e.getMessage() + "</p>");
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<p>SQL Error: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
