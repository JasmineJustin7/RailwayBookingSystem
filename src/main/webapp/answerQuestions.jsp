<%@ page import="java.sql.*" %>
<%
    String questionId = request.getParameter("question_id");
    String answerText = request.getParameter("answer_text");

    if (answerText != null && !answerText.trim().isEmpty()) {
        try {
            // JDBC connection
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_booking", "jasminejustin7", "BlackLagoon2006!");

            // Retrieve the username from the session
            String username = (String) session.getAttribute("username");

            // If no username is found in the session, display an error
            if (username == null) {
                out.println("<p>Error: No username found in session.</p>");
                return; // Exit if no username is found
            }

            // Query the database to retrieve the representative's ID (e_id) using the username
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
                return; // Exit if no representative is found
            }

            // Insert the answer into the database
            String sql = "INSERT INTO answers (question_id, e_id, answer_text) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(questionId)); // Set the question ID
            stmt.setInt(2, e_id); // Set the representative's ID (e_id)
            stmt.setString(3, answerText); // Set the answer text
            int result = stmt.executeUpdate();

            if (result > 0) {
                // Update the question status to 'Answered'
                String updateStatusSQL = "UPDATE questions SET status = 'Answered' WHERE question_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateStatusSQL);
                updateStmt.setInt(1, Integer.parseInt(questionId));
                updateStmt.executeUpdate();
                out.println("Answer submitted successfully!");
            } else {
                out.println("Error submitting answer.");
            }

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
%>

<form method="post" action="answerQuestions.jsp">
    Answer: <textarea name="answer_text"></textarea><br/>
    <input type="submit" value="Submit Answer" />
</form>
