<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Revenue Info</title>
</head>
<body>
<h1>Revenue Information</h1>

<h2>Revenue Per Transit Line</h2>
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

        // Query for revenue per transit line
        String lineRevenueQuery = "SELECT ts.tl_name, SUM(r.total_fare) AS revenue " +
                "FROM train_schedule ts " +
                "JOIN train_station t_st ON ts.tl_name = t_st.tl_name " +
                "JOIN reservations r ON r.os_id = t_st.s_id OR r.ds_id = t_st.s_id " +
                "GROUP BY ts.tl_name " +
                "ORDER BY revenue DESC";

        PreparedStatement lineRevenueStmt = con.prepareStatement(lineRevenueQuery);
        ResultSet lineRevenueRs = lineRevenueStmt.executeQuery();

        // Display revenue per transit line
        if (!lineRevenueRs.isBeforeFirst()) {
            out.println("<p>No revenue data available for transit lines.</p>");
        } else {
            out.println("<table border='1'>");
            out.println("<tr><th>Transit Line</th><th>Revenue</th></tr>");
            while (lineRevenueRs.next()) {
                String transitLine = lineRevenueRs.getString("tl_name");
                double revenue = lineRevenueRs.getDouble("revenue");

                out.println("<tr>");
                out.println("<td>" + transitLine + "</td>");
                out.println("<td>$" + revenue + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        lineRevenueRs.close();
        lineRevenueStmt.close();

        // Query for revenue per customer
        out.println("<h2>Revenue Per Customer</h2>");
        String customerRevenueQuery = "SELECT c.f_name, c.l_name, SUM(r.total_fare) AS revenue " +
                "FROM customers c " +
                "JOIN reservations r ON c.c_id = r.c_id " +
                "GROUP BY c.c_id " +
                "ORDER BY revenue DESC";

        PreparedStatement customerRevenueStmt = con.prepareStatement(customerRevenueQuery);
        ResultSet customerRevenueRs = customerRevenueStmt.executeQuery();

        // Display revenue per customer
        if (!customerRevenueRs.isBeforeFirst()) {
            out.println("<p>No revenue data available for customers.</p>");
        } else {
            out.println("<table border='1'>");
            out.println("<tr><th>Customer Name</th><th>Revenue</th></tr>");
            while (customerRevenueRs.next()) {
                String firstName = customerRevenueRs.getString("f_name");
                String lastName = customerRevenueRs.getString("l_name");
                double revenue = customerRevenueRs.getDouble("revenue");

                out.println("<tr>");
                out.println("<td>" + firstName + " " + lastName + "</td>");
                out.println("<td>$" + revenue + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        customerRevenueRs.close();
        customerRevenueStmt.close();

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
