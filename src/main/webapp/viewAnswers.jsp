<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<html>
<head>
    <title>View Answers</title>
</head>
<body>
    <h1>Customer Questions and Answers</h1>

    <!-- Search form -->
    <form action="viewAnswers.jsp" method="get">
        <label for="searchKeyword">Search for answers:</label>
        <input type="text" id="searchKeyword" name="searchKeyword" placeholder="Enter keyword">
        <input type="submit" value="Search">
    </form>

    <hr/>

    <%
        // Retrieve the search keyword from the form (if present)
        String searchKeyword = request.getParameter("searchKeyword");
        
        Connection con = null;
        Statement stmt = null;
        ResultSet rsQuestions = null;
        ResultSet rsAnswers = null;

        try {
            String myUsername = "jasminejustin7";  // Your MySQL database username
            String myPassword = "BlackLagoon2006!"; // Your MySQL database password
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_booking", myUsername, myPassword);
            stmt = con.createStatement();

            // Query to fetch questions with their answers, with optional keyword search
            String sql = "SELECT q.question_id, q.question_text, q.status, a.answer_text, e.f_name, e.l_name " +
                         "FROM questions q LEFT JOIN answers a ON q.question_id = a.question_id " +
                         "LEFT JOIN employees e ON a.e_id = e.e_id ";

            // Modify the query if a search keyword is provided
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                sql += "WHERE q.question_text LIKE ? OR a.answer_text LIKE ?";
            }

            sql += " ORDER BY q.question_id";

            PreparedStatement pstmt = con.prepareStatement(sql);
            
            // Set the parameters for the query (if a search keyword is provided)
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                String keyword = "%" + searchKeyword + "%";  // Use % for partial match
                pstmt.setString(1, keyword);
                pstmt.setString(2, keyword);
            }

            // Execute the query
            rsQuestions = pstmt.executeQuery();

            // Loop through questions and display their answers
            boolean foundResults = false; // Flag to check if any results were found
            while (rsQuestions.next()) {
                foundResults = true;  // At least one result is found

                int questionId = rsQuestions.getInt("question_id");
                String questionText = rsQuestions.getString("question_text");
                String status = rsQuestions.getString("status");
                String answerText = rsQuestions.getString("answer_text");
                String employeeName = (answerText != null) ? rsQuestions.getString("f_name") + " " + rsQuestions.getString("l_name") : "No Answer Yet";

                out.println("<h3>Question #" + questionId + "</h3>");
                out.println("<p><strong>Question:</strong> " + questionText + "</p>");
                out.println("<p><strong>Status:</strong> " + status + "</p>");

                if (answerText != null) {
                    out.println("<p><strong>Answer:</strong> " + answerText + "</p>");
                    out.println("<p><strong>Answered by:</strong> " + employeeName + "</p>");
                } else {
                    out.println("<p><strong>No Answer Yet</strong></p>");
                }
                
                out.println("<hr/>");
            }

            // If no results were found, show a message
            if (!foundResults) {
                out.println("<p>No questions or answers found matching your keyword.</p>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving data.</p>");
        } finally {
            try {
                if (rsQuestions != null) rsQuestions.close();
                if (rsAnswers != null) rsAnswers.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
