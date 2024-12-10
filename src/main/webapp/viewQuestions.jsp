<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%


	//Load MySQL JDBC Driver
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
        //String customerName = rs.getString("customer_name");
%>
        <div>
            <h4>Question ID: <%= questionId %></h4>
            <p>Question: <%= questionText %></p>
            <a href="answerQuestions.jsp?question_id=<%= questionId %>">Answer</a>
        </div>
<%
    }
    conn.close();
%>
