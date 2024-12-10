<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%

// Load MySQL JDBC Driver
Class.forName("com.mysql.jdbc.Driver");

String myUsername = "jasminejustin7";
String myPassword = "BlackLagoon2006!";
String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";

//String customerId = request.getParameter("c_id");
String questionText = request.getParameter("question_text");

    if (questionText != null && !questionText.trim().isEmpty()) {
        try {
        
            // JDBC connection
            Connection conn = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);
            String sql = "INSERT INTO questions (question_text) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            //stmt.setInt(1, Integer.parseInt(customerId));
            stmt.setString(1, questionText);
            int result = stmt.executeUpdate();
            if (result > 0) {
                out.println("Question submitted successfully!");
            } else {
                out.println("Error submitting question.");
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
%>

<form method="post" action="askQuestions.jsp">
    Question: <textarea name="question_text"></textarea><br/>
    <input type="submit" value="Submit" />
    <a href="customerAuthentication.jsp">Go back to the Customer home page</a>
</form>
