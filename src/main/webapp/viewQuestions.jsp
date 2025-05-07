<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    // Load MySQL JDBC Driver
    Class.forName("com.mysql.jdbc.Driver");

    String myUsername = "jasminejustin7";
    String myPassword = "BlackLagoon2006!";
    String jdbcUrl = "jdbc:mysql://localhost:3306/railway_booking?useSSL=false&serverTimezone=UTC";

    // JDBC connection
    Connection conn = DriverManager.getConnection(jdbcUrl, myUsername, myPassword);
    String sql = "SELECT * FROM questions WHERE status = 'Pending'";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
        int questionId = rs.getInt("question_id");
        String questionText = rs.getString("question_text");
%>
    <div>
        <h4>Question ID: <%= questionId %></h4>
        <p>Question: <%= questionText %></p>
        <!-- Link to answer the question, use a session to store question_id -->
        <form action="answerQuestions.jsp" method="post">
            <input type="hidden" name="question_id" value="<%= questionId %>" />
            <input type="submit" value="Answer" />
        </form>
    </div>
<%
    }
    conn.close();
%>
