<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
    String action = request.getParameter("action");
    String employeeId = request.getParameter("e_id");

    // Retrieve the logged-in admin username from session
    String userid = (String) session.getAttribute("user");

    // If no session exists, redirect to login page
    if (userid == null) {
        response.sendRedirect("generalLoginPage.jsp");
    }

    // Setup the database connection
    Class.forName("com.mysql.jdbc.Driver");
    String myUsername = "jasminejustin7";
    String myPassword = "BlackLagoon2006!";
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_booking", myUsername, myPassword);
    Statement st = con.createStatement();

    if ("delete".equals(action) && employeeId != null) {
        // Perform delete operation
        String deleteQuery = "DELETE FROM employees WHERE e_id = ?";
        PreparedStatement pst = con.prepareStatement(deleteQuery);
        pst.setInt(1, Integer.parseInt(employeeId));
        pst.executeUpdate();
        out.println("<h3>Employee " + employeeId + " deleted successfully.</h3>");
    } else if ("update".equals(action) && employeeId != null) {
        // Perform update operation (retrieve employee data for update)
        String updateQuery = "SELECT * FROM employees WHERE e_id = ?";
        PreparedStatement pst = con.prepareStatement(updateQuery);
        pst.setInt(1, Integer.parseInt(employeeId));
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            String fName = rs.getString("f_name");
            String lName = rs.getString("l_name");
            String username = rs.getString("username");
            String password = rs.getString("p_word");
            String ssn = rs.getString("ssn");
        }
    } else if ("add".equals(action)) {
        // Handle adding new employee (form submitted)
        String fName = request.getParameter("f_name");
        String lName = request.getParameter("l_name");
        String username = request.getParameter("username");
        String password = request.getParameter("p_word");
        String ssn = request.getParameter("ssn");

        if (fName != null && lName != null && username != null && password != null && ssn != null) {
            String insertQuery = "INSERT INTO employees (f_name, l_name, username, p_word, ssn) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(insertQuery);
            pst.setString(1, fName);
            pst.setString(2, lName);
            pst.setString(3, username);
            pst.setString(4, password);
            pst.setString(5, ssn);
            pst.executeUpdate();
            out.println("<h3>Employee " + fName + " " + lName + " added successfully.</h3>");
        }
    }
%>

<html>
<head>
    <title>Admin - Manage Employees</title>
    <style>
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .section-title {
            text-align: center;
            font-size: 24px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <h2>Welcome, <%= userid %></h2>

    <!-- Section to display employees -->
    <div class="section-title">Employee List</div>
    <table>
        <tr>
            <th>Employee ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Username</th>
            <th>SSN</th>
            <th>Actions</th>
        </tr>
        <%
            // Query to get employee data
            String query = "SELECT * FROM employees";
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                int eId = rs.getInt("e_id");
                String fName = rs.getString("f_name");
                String lName = rs.getString("l_name");
                String username = rs.getString("username");
                String ssn = rs.getString("ssn");
        %>
        <tr>
            <td><%= eId %></td>
            <td><%= fName %></td>
            <td><%= lName %></td>
            <td><%= username %></td>
            <td><%= ssn %></td>
            <td>
                <a href="?action=delete&e_id=<%= eId %>">Delete</a> |
                <a href="?action=update&e_id=<%= eId %>">Update</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <!-- Add Employee Form -->
    <div class="section-title">Add New Employee</div>
    <form action="?action=add" method="POST">
        <label for="f_name">First Name:</label>
        <input type="text" name="f_name" required><br><br>
        <label for="l_name">Last Name:</label>
        <input type="text" name="l_name" required><br><br>
        <label for="username">Username:</label>
        <input type="text" name="username" required><br><br>
        <label for="p_word">Password:</label>
        <input type="password" name="p_word" required><br><br>
        <label for="ssn">SSN:</label>
        <input type="text" name="ssn" required><br><br>
        <input type="submit" value="Add Employee">
    </form>

    <br><br>
    <a href="adminAuthentication.jsp">Back to Admin Dashboard</a>
</body>
</html>
