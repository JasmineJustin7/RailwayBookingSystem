<%@ page import="java.sql.*" %>
<%

    // Retrieve the question_id from the form
    String questionId = request.getParameter("question_id");
    
    // If the question_id is missing, display an error and exit
    if (questionId == null || questionId.trim().isEmpty()) {
        out.println("<p>Error: Question ID is missing.</p>");
        return; // Exit if no question ID is provided
    }

    int questionIdInt = 0;
    try {
        questionIdInt = Integer.parseInt(questionId); // Convert to int
    } catch (NumberFormatException e) {
        out.println("<p>Error: Invalid Question ID format.</p>");
        return; // Exit if the Question ID is not a valid integer
    }

    // Handle the answer submission when the form is posted
    String answerText = request.getParameter("answer_text");
    if (answerText != null && !answerText.trim().isEmpty()) {
        try {
            // JDBC connection setup
            String myUsername = "jasminejustin7";
            String myPassword = "BlackLagoon2006!";
            String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);

            // Retrieve the username from the session
            String username = (String) session.getAttribute("user");

            // If no username is found in the session, display an error
            if (username == null) {
                out.println("<p>Error: No username found in session.</p>");
                conn.close();
                return; // Exit if no username is found
            }

            // Query to get the representative's ID (e_id) using the username
            String sqlGetRepId = "SELECT e_id FROM employees WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sqlGetRepId);
            ps.setString(1, username); // Set the username as the parameter
            ResultSet rs = ps.executeQuery();

            int e_id = -1; // Default value if no matching representative is found
            if (rs.next()) {
                e_id = rs.getInt("e_id"); // Retrieve the e_id (representative ID) from the database
            }

            // Check if e_id was found
            if (e_id == -1) {
                out.println("<p>Error: Representative not found for the username.</p>");
                conn.close();
                return; // Exit if no representative is found
            }

            // Insert the answer into the database
            String sql = "INSERT INTO answers (question_id, e_id, answer_text) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, questionIdInt); // Set the question ID
            stmt.setInt(2, e_id); // Set the representative's ID (e_id)
            stmt.setString(3, answerText); // Set the answer text
            int result = stmt.executeUpdate();

            if (result > 0) {
                // Update the question status to 'Answered'
                String updateStatusSQL = "UPDATE questions SET status = 'Answered' WHERE question_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateStatusSQL);
                updateStmt.setInt(1, questionIdInt);
                updateStmt.executeUpdate();
                out.println("Answer submitted successfully!");
                out.println("<br>");
                out.println("<a href='employeeAuthentication.jsp'>Go back to Employee Home page</a>");
                out.println("<br>");
                out.println("<a href='logout.jsp'>Log out</a>");
            } else {
                out.println("Error submitting answer.");
            }

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    } else {
        // Display the question and the form for answering
        try {
            // JDBC connection setup
            String myUsername = "jasminejustin7";
            String myPassword = "BlackLagoon2006!";
            String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);

            // Retrieve the question text from the database based on the question_id
            String sql = "SELECT * FROM questions WHERE question_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, questionIdInt); // Set the question_id in the query
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String questionText = rs.getString("question_text");
%>
                <h3>Answer Question</h3>
                <p><strong>Question:</strong> <%= questionText %></p>

                <form method="post" action="answerQuestions.jsp">
                    <input type="hidden" name="question_id" value="<%= questionIdInt %>" />
                    <textarea name="answer_text" placeholder="Your answer..."></textarea><br/>
                    <input type="submit" value="Submit Answer" />
                </form>
<%
            } else {
                out.println("<p>Error: Question not found.</p>");
            }

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error retrieving question: " + e.getMessage());
        }
    }
%>
