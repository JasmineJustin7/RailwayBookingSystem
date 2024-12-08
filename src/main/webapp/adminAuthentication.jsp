<%@ page import ="java.sql.*" %>
<%
	String userid = request.getParameter("username");
	String pwd = request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	String myUsernmae = "jasminejustin7";
	String myPassword = "BlackLagoon2006!";
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/railway_booking", myUsernmae,
	myPassword);
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from admin where username='" + userid + "' and password='" + pwd
	+ "'");
	if (rs.next()) {
		session.setAttribute("user", userid); // the username will be stored in the session
		out.println("welcome " + userid);
		out.println("<a href='logout.jsp'>Log out</a>");
		response.sendRedirect("success.jsp");
	} else {
		out.println("Invalid password <a href='generalLoginPage.jsp'>try again</a>");
	}
%>