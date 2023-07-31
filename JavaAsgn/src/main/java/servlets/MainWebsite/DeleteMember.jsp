<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DeleteMemberLogic</title>
<%--
    
Author             : Thaw Zin Htun
Date                 : 14/05/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2234894
Class             : DIT/FT/2A/03
--%>
<script>
	
</script>
</head>
<body onload="deleted()">
	<%
	String id = request.getParameter("id");
	int count = 0;

	try {
		// Step 1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/db1?user=root&password=root1234&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create PreparedStatement object
		String sqlStr = "DELETE FROM javaassignment.user WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, id);

		// Step 5: Execute the DELETE statement
		count = pstmt.executeUpdate();

		// Step 6: Process Results

		// Step 7: Close connection
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e);
	}

	response.sendRedirect("AdminViewMembers.jsp");
	%>
</body>
</html>
=======
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>DeleteMemberLogic</title>
<%--
    
Author             : Thaw Zin Htun
Date                 : 14/05/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2234894
Class             : DIT/FT/2A/03
--%>
<script>
	
</script>
</head>
<body onload="deleted()">
	<%
	String id = request.getParameter("id");
	int count = 0;

	try {
		// Step 1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/db1?user=root&password=root1234&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create PreparedStatement object
		String sqlStr = "DELETE FROM javaassignment.user WHERE id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, id);

		// Step 5: Execute the DELETE statement
		count = pstmt.executeUpdate();

		// Step 6: Process Results

		// Step 7: Close connection
		conn.close();
	} catch (Exception e) {
		out.println("Error: " + e);
	}

	response.sendRedirect("AdminViewMembers.jsp");
	%>
</body>
</html>
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn
