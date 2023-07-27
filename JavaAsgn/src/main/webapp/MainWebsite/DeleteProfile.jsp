<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Profile</title>
<%--
    
Author             : Thet Htar San
Date                 : 28/07/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : p2235077
Class             : DIT/FT/2A/03
--%>
<script>
	
</script>
</head>
<body onload="deleted()">
	<%
	String id = request.getParameter("id");
	
	try {
		// Step 1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create PreparedStatement object
		String sqlStr = "DELETE FROM javaassignment.user WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, id);

		// Step 5: Execute the DELETE statement
		 pstmt.executeUpdate();

		// Step 6: Process Results

		// Step 7: Close connection
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e);
	}
	 request.getSession().invalidate();
	response.sendRedirect("Login2.jsp");
	%>
</body>
</html>
