<%@ page import="java.sql.*" %>
<%
    // Get form data
    String trainId = request.getParameter("train_id");
    String travelDate = request.getParameter("date");
    
    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        String myUsername = "jasminejustin7";
        String myPassword = "BlackLagoon2006!";
        String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";

        // Variables to store train schedule info
        String trainName = "";
        String travelTime = "";
        String fare = "";
        int stops = 0;

        // Establish Connection
        Connection con = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);

        // Prepare the query to get train schedule
        // Using train ID to fetch the schedule and associated stations
        String query = "SELECT ts.tl_name, ts.travel_time, ts.fare, ts.stops, s.s_name, tsd.dept_time, tsd.arr_time " +
                       "FROM train_schedule ts " +
                       "JOIN train_station tsd ON ts.tl_name = tsd.tl_name " +
                       "JOIN stations s ON tsd.s_id = s.s_id " +
                       "WHERE ts.tl_name = ? " +
                       "ORDER BY tsd.ts_id";  // Ensuring stations are in the correct order

        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1, trainId);

        ResultSet rs = stmt.executeQuery();
        
        // If a matching train schedule is found
        if (rs.next()) {
            trainName = rs.getString("tl_name");
            travelTime = rs.getString("travel_time");
            fare = rs.getString("fare");
            stops = rs.getInt("stops");
            
            out.println("Train Information:");
            out.println("<br>");
            
            out.println("Train: " + trainName);
            out.println("<br>");
            out.println("Duration: " + travelTime);
            out.println("<br>");
            out.println("Fare: $" + fare);
            out.println("<br>");
            out.println("Number of Stops: " + stops);
            out.println("<br>");
            
            // Display station details with arrival/departure times
            out.println("Stops and Timings:");
            out.println("<ul>");
            do {
                String stationName = rs.getString("s_name");
                String deptTime = rs.getString("dept_time");
                String arrTime = rs.getString("arr_time");
                
                out.println("<li>");
                out.println("Station: " + stationName);
                out.println("<br>");
                out.println("Departure Time: " + deptTime);
                out.println("<br>");
                out.println("Arrival Time: " + arrTime);
                out.println("</li>");
            } while (rs.next());
            out.println("</ul>");

            out.println("<br>");
            out.println("Search new train schedule <a href='trainSearch.jsp'>Search</a>");
            out.println("<br>");
            out.println("<a href='customerReservations.jsp'>Make reservation</a>");
        } else {
            out.println("Invalid train id <a href='trainSearch.jsp'>try again</a>");
        }

        // Close the result set and statement
        rs.close();
        stmt.close();
        con.close();

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error loading MySQL driver: " + e.getMessage());
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("SQL Error: " + e.getMessage());
    }
%>
