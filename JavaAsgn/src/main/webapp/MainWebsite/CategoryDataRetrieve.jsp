<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
		<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Category Data Retrieve</title>
<%--
	- Author 			: Thaw Zin Htun
	- Date 				: 25/05/2023
	- Copyright Notice 	: NA
	- @(#)
	- Description 		: 
	- Admission no		: P2234894
	- Class 			: DIT/FT/2A/03
--%>
<body>


	<%
//---------------START - initialisation of variables--------------------
Boolean found = false ;	//to indicate if found or not
ArrayList<String> category = new ArrayList<>();
//---------------ENd   - initialization of variables-------------------


	int id;
	String name;
	try {
		// Step1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/db1?user=root&password=root1234&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);
		// Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		// Step 5: Execute SQL Command
		//ResultSet rs = stmt.executeQuery(sqlStr);
		String sqlStr = "SELECT name FROM category ";
		
		System.out.print(sqlStr); //print to console
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);	
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		if(rs.next()){
			System.out.print("record found!");
			found=true;
			
			String catName = rs.getString("name");
			category.add(catName);
			
		}else {
			//do nothing
			System.out.print("record not found!");
		}

		// Step 7: Close connection
		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}
	session.setAttribute("catName", category);
	session.setMaxInactiveInterval(86400);
	%>



</body>
</html>