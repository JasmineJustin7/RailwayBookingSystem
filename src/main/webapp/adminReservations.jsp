<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List of Reservations</title>
</head>
<body>
<h1>List of Reservations</h1>

<h2>Reservations by Transit Line</h2>
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

        // Query for reservations by transit line
        String lineReservationsQuery = "SELECT ts.tl_name, COUNT(r.r_id) AS reservation_count " +
                "FROM train_schedule ts " +
                "JOIN train_station t_st ON ts.tl_name = t_st.tl_name " +
                "JOIN reservations r ON r.os_id = t_st.s_id OR r.ds_id = t_st.s_id " +
                "GROUP BY ts.tl_name " +
                "ORDER BY reservation_count DESC";

        PreparedStatement lineReservationsStmt = con.prepareStatement(lineReservationsQuery);
        ResultSet lineReservationsRs = lineReservationsStmt.executeQuery();

        // Display reservations by transit line
        if (!lineReservationsRs.isBeforeFirst()) {
            out.println("<p>No reservations found for transit lines.</p>");
        } else {
            out.println("<table border='1'>");
            out.println("<tr><th>Transit Line</th><th>Number of Reservations</th></tr>");
            while (lineReservationsRs.next()) {
                String transitLine = lineReservationsRs.getString("tl_name");
                int reservationCount = lineReservationsRs.getInt("reservation_count");

                out.println("<tr>");
                out.println("<td>" + transitLine + "</td>");
                out.println("<td>" + reservationCount + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        lineReservationsRs.close();
        lineReservationsStmt.close();

        // Query for reservations by customer name
        out.println("<h2>Reservations by Customer Name</h2>");
        String customerReservationsQuery = "SELECT c.f_name, c.l_name, COUNT(r.r_id) AS reservation_count " +
                "FROM customers c " +
                "JOIN reservations r ON c.c_id = r.c_id " +
                "GROUP BY c.c_id " +
                "ORDER BY reservation_count DESC";

        PreparedStatement customerReservationsStmt = con.prepareStatement(customerReservationsQuery);
        ResultSet customerReservationsRs = customerReservationsStmt.executeQuery();

        // Display reservations by customer name
        if (!customerReservationsRs.isBeforeFirst()) {
            out.println("<p>No reservations found for customers.</p>");
        } else {
            out.println("<table border='1'>");
            out.println("<tr><th>Customer Name</th><th>Number of Reservations</th></tr>");
            while (customerReservationsRs.next()) {
                String firstName = customerReservationsRs.getString("f_name");
                String lastName = customerReservationsRs.getString("l_name");
                int reservationCount = customerReservationsRs.getInt("reservation_count");

                out.println("<tr>");
                out.println("<td>" + firstName + " " + lastName + "</td>");
                out.println("<td>" + reservationCount + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        }

        customerReservationsRs.close();
        customerReservationsStmt.close();

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
