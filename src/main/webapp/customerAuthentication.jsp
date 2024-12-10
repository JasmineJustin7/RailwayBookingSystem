<%@ page import="java.sql.*" %>
<%
    String userid = request.getParameter("username");
    String pwd = request.getParameter("password");
    Connection con = null;
    Statement st1 = null;
    Statement st2 = null;
    Statement st3 = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    
    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        String myUsername = "jasminejustin7";
        String myPassword = "BlackLagoon2006!";
        String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";
        
        // Establish Connection
        con = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);

        // Create two separate Statements
        st1 = con.createStatement();  // For counting customers
        st2 = con.createStatement();  // For checking the username and password
        st3 = con.createStatement();  // For viewing customer's reservation in system
        
        // Execute the first query to count customers
        rs1 = st1.executeQuery("select count(*) from customers");
        
        // Execute the second query to check the user credentials
        rs2 = st2.executeQuery("select * from customers where username='" + userid + "' and p_word='" + pwd + "'");

        // Query for current reservations (r_date >= CURDATE())
        String currentReservationsQuery = "SELECT * FROM reservations WHERE c_id = (SELECT c_id FROM customers WHERE username='" + userid + "' AND p_word='" + pwd + "') AND r_date >= CURDATE()";
        rs3 = st3.executeQuery(currentReservationsQuery);

        // Process the count of customers
        if (rs1.next()) {
            int customerCount = rs1.getInt(1);  // Get the count of customers from the result set
            if (customerCount == 0) {
                out.println("There are no customers in the system.");
                out.println("<a href='generalLoginPage.jsp'>Return to main page</a>");
                return;
            }
        }

        // Process the second result set for username and password
        if (rs2.next()) {
            session.setAttribute("user", userid); // the username will be stored in the session
            out.println("Welcome " + userid);
            out.println("<br>");
            
            // Add buttons that appear like links
            out.println("<a href='trainSearch.jsp'><button>Browse train schedules</button></a>");
            out.println("<br>");
            out.println("<a href='customerReservations.jsp'>Make Reservation</a>");
            out.println("<br>");
            out.println("<br>");
            out.println("View Current Reservations:");
            

            // Display current reservations
            if (rs3.next()) {
                out.println("<table border='1'>");
                out.println("<tr><th>Reservation ID</th><th>Train ID</th><th>Date</th><th>Fare</th><th>Type</th></tr>");
                do {
                    out.println("<tr>");
                    out.println("<td>" + rs3.getInt("r_id") + "</td>");
                    out.println("<td>" + rs3.getInt("os_id") + "</td>");
                    out.println("<td>" + rs3.getDate("r_date") + "</td>");
                    out.println("<td>" + String.format("%.2f", rs3.getDouble("total_fare")) + "</td>");
                    out.println("<td>" + rs3.getString("r_type") + "</td>");
                    
                    // Add a button to remove the reservation
                    out.println("<td><a href='removeReservation.jsp?r_id=" + rs3.getInt("r_id") + "'><button>Remove Reservation</button></a></td>");
                    
                    out.println("</tr>");
                } while (rs3.next());
                out.println("</table>");
            } else {
                // No current reservations found
                out.println("You have no current reservations.");
            }

            // Query for past reservations (r_date < CURDATE())
            String pastReservationsQuery = "SELECT * FROM reservations WHERE c_id = (SELECT c_id FROM customers WHERE username='" + userid + "' AND p_word='" + pwd + "') AND r_date < CURDATE()";
            ResultSet rsPast = st3.executeQuery(pastReservationsQuery);

            out.println("<br><br>");
            out.println("View Past Reservations:");

            // Display past reservations
            if (rsPast.next()) {
                out.println("<table border='1'>");
                out.println("<tr><th>Reservation ID</th><th>Train ID</th><th>Date</th><th>Fare</th><th>Type</th></tr>");
                do {
                    out.println("<tr>");
                    out.println("<td>" + rsPast.getInt("r_id") + "</td>");
                    out.println("<td>" + rsPast.getInt("os_id") + "</td>");
                    out.println("<td>" + rsPast.getDate("r_date") + "</td>");
                    out.println("<td>" + String.format("%.2f", rsPast.getDouble("total_fare")) + "</td>");
                    out.println("<td>" + rsPast.getString("r_type") + "</td>");
                    out.println("</tr>");
                } while (rsPast.next());
                out.println("</table>");
            } else {
                // No past reservations found
                out.println("You have no past reservations.");
            }

            out.println("<br>");
            out.println("<a href='askQuestions.jsp'>Send Questions</a>");
            out.println("<br>");
            out.println("<a href='viewAnswers.jsp'>View Questions and Answers</a>");
            out.println("<br>");
            out.println("<a href='logout.jsp'>Log out</a>");

        } else {
            out.println("Invalid username or password <a href='generalLoginPage.jsp'>try again</a>");
        }

    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Error loading MySQL driver: " + e.getMessage());
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("SQL Error: " + e.getMessage());
    } finally {
        // Close resources
        try {
            if (rs1 != null) rs1.close();
            if (rs2 != null) rs2.close();
            if (rs3 != null) rs3.close();
            if (st1 != null) st1.close();
            if (st2 != null) st2.close();
            if (st3 != null) st3.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
