<%@ page import ="java.sql.*" %>
<%
	String userid = request.getParameter("username");
	String pwd = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	String myUsername = "jasminejustin7";
	String myPassword = "BlackLagoon2006!";
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_booking", myUsername,
	myPassword);
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from admin where username='" + userid + "' and password='" + pwd
	+ "'");
	if (rs.next()) {
		session.setAttribute("user", userid); // the username will be stored in the session
		out.println("Welcome " + userid);
		
        out.println("<br>");
		out.println("<a href='adminRepresentativeAssistance.jsp'>Customer Representative Assistance</a>");
        out.println("<br>");
		out.println("<a href='salesReport.jsp'>Sales Report</a>");
        out.println("<br>");
		out.println("<a href='adminReservations.jsp'>List of Reservations</a>");
        out.println("<br>");
		out.println("<a href='adminRevenue.jsp'>Revenue Info</a>");
        out.println("<br>");
		out.println("<a href='adminBestCustomer.jsp'>Best Customer</a>");
        out.println("<br>");
		out.println("<a href='activeTransitLines.jsp'>Most Active Transit Lines</a>");
        out.println("<br>");
		
		out.println("<a href='logout.jsp'>Log out</a>");
		//response.sendRedirect("success.jsp");
	} else {
		out.println("Invalid password <a href='generalLoginPage.jsp'>try again</a>");
	}
%>