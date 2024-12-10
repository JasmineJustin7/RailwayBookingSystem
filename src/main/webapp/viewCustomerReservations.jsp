<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Customer Reservations</title>
</head>
<body>
    <h2>Customers with Reservations</h2>

    <!-- Form for input -->
    <form action="viewCustomerReservations.jsp" method="get">
        <label for="station">Select Station:</label>
        <select id="station" name="station" required>
            <option value="origin">Origin Station</option>
            <option value="destination">Destination Station</option>
        </select>
        <br>

        <a href="employeeAuthentication.jsp">Go back to the Employee home page</a>
        <br>

        <label for="station_name">Station Name:</label>
        <select id="station_name" name="station_name" required>
            <% 
                // Database connection for fetching stations
                String dbUrl = "jdbc:mysql://localhost:3306/railway_booking";
                String dbUser = "jasminejustin7";
                String dbPassword = "BlackLagoon2006!";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                    stmt = conn.createStatement();
                    String sql = "SELECT s_id, s_name FROM stations";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int s_id = rs.getInt("s_id");
                        String s_name = rs.getString("s_name");
                        out.println("<option value=\"" + s_id + "\">" + s_name + "</option>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error fetching stations: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </select>

        <label for="tl_name">Transit Line:</label>
        <input type="text" id="tl_name" name="tl_name" required />

        <label for="r_date">Date</label>
        <input type="date" id="r_date" name="r_date" required />

        <input type="submit" value="Search" />
    </form>

    <!-- Table to display results -->
    <table border="1">
        <thead>
            <tr>
                <th>Customer ID</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Reservation ID</th>
                <th>Reservation Date</th>
                <th>Station Name</th>
                <th>Transit Line</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Retrieving form data
                String stationType = request.getParameter("station");
                String stationId = request.getParameter("station_name");
                String transitLine = request.getParameter("tl_name");
                String reservationDate = request.getParameter("r_date");

                // Database connection for fetching reservation data
                String myUrl = "jdbc:mysql://localhost:3306/railway_booking";
                String myUser = "jasminejustin7";
                String myPassword = "BlackLagoon2006!";
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs2 = null;

                String sql = "";
                if ("origin".equals(stationType)) {
                    // Query for reservations at origin station
                    sql = "SELECT c.c_id, c.f_name, c.l_name, r.r_id, r.r_date, " +
                          "os.s_name AS station_name, ts.tl_name " +
                          "FROM customers c " +
                          "JOIN reservations r ON c.c_id = r.c_id " +
                          "JOIN stations os ON r.os_id = os.s_id " +
                          "JOIN train_station ts ON ts.s_id = os.s_id " +
                          "WHERE ts.tl_name = ? AND r.r_date = ? AND os.s_id = ?";
                } else if ("destination".equals(stationType)) {
                    // Query for reservations at destination station
                    sql = "SELECT c.c_id, c.f_name, c.l_name, r.r_id, r.r_date, " +
                          "ds.s_name AS station_name, ts.tl_name " +
                          "FROM customers c " +
                          "JOIN reservations r ON c.c_id = r.c_id " +
                          "JOIN stations ds ON r.ds_id = ds.s_id " +
                          "JOIN train_station ts ON ts.s_id = ds.s_id " +
                          "WHERE ts.tl_name = ? AND r.r_date = ? AND ds.s_id = ?";
                }

                if (!sql.isEmpty()) {
                    try {
                        con = DriverManager.getConnection(myUrl, myUser, myPassword);

                        ps = con.prepareStatement(sql);
                        ps.setString(1, transitLine);  // Set the transit line parameter
                        ps.setString(2, reservationDate);  // Set the reservation date parameter
                        ps.setString(3, stationId);  // Set the selected station ID

                        rs2 = ps.executeQuery();

                        // Loop through the result set and display in table
                        while (rs2.next()) {
                            int c_id = rs2.getInt("c_id");
                            String f_name = rs2.getString("f_name");
                            String l_name = rs2.getString("l_name");
                            int r_id = rs2.getInt("r_id");
                            java.sql.Date r_date = rs2.getDate("r_date");
                            String stationName = rs2.getString("station_name");
                            String tl_name = rs2.getString("tl_name");

                            out.println("<tr>");
                            out.println("<td>" + c_id + "</td>");
                            out.println("<td>" + f_name + "</td>");
                            out.println("<td>" + l_name + "</td>");
                            out.println("<td>" + r_id + "</td>");
                            out.println("<td>" + r_date + "</td>");
                            out.println("<td>" + stationName + "</td>");
                            out.println("<td>" + tl_name + "</td>");
                            out.println("</tr>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error fetching data: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (rs2 != null) rs2.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>
