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
        String stops = "";

        
        // Establish Connection
        Connection con = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);
        
        
        // Prepare the query to get train schedule
        // Using train ID to fetch the schedule
        String query = "SELECT ts.tl_name, ts.travel_time, ts.fare, ts.stops " +
                       "FROM train_schedule ts " +
                       "WHERE ts.tl_name = ?";  
                       
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1, trainId);

        ResultSet rs = stmt.executeQuery();
        
        // If a matching train schedule is found
        if (rs.next()) {
            trainName = rs.getString("tl_name");
            travelTime = rs.getString("travel_time");
            fare = rs.getString("fare");
            stops = rs.getString("stops");
            
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

            //display all stops depending on train line
            if(trainName.equalsIgnoreCase("L")){
            	out.println("New York Penn");
            	out.println("-->");
            	out.println("Secaucus");
            	out.println("-->");
            	out.println("Newark Penn");
            	out.println("-->");
            	out.println("Elizabeth Station");
            	out.println("-->");
            	out.println("Rahway Station");
            	out.println("-->");
            	out.println("Linden Station");
            	out.println("-->");
            	out.println("Metuchen Station");
            	out.println("-->");
            	out.println("Edison Station");
            	out.println("-->");
            	out.println("New Brunswick Station");
            	out.println("-->");
            	out.println("Trenton Station");
            }else if(trainName.equalsIgnoreCase("B")){
            	out.println("New York Penn");
            	out.println("-->");
            	out.println("Secaucus");
            	out.println("-->");
            	out.println("Newark Penn");
            	out.println("-->");
            	out.println("Metuchen Station");
            	out.println("-->");
            	out.println("Edison Station");
            	out.println("-->");
            	out.println("New Brunswick Station");
            	out.println("-->");
            	out.println("Trenton Station");
            }else if(trainName.equalsIgnoreCase("E")){
            	out.println("Newark Penn");
            	out.println("-->");
            	out.println("Metuchen Station");
            	out.println("-->");
            	out.println("Edison Station");
            	out.println("-->");
            	out.println("New Brunswick Station");
            	out.println("-->");
            	out.println("Trenton Station");
            }else{
            	out.println("Schedule has not been made official.");
            }
            
            out.println("<br>");
            out.println("Search new train schedule <a href='trainSearch.jsp'>Search</a>");
            out.println("<br>");
            out.println("<a href='trainSearch.jsp'>Make reservation</a>");
        }else{
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
