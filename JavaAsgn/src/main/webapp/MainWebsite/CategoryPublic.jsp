<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<title>CategoryPublic</title>
<%--
	- Author 			: Thaw Zin Htun
	- Date 				: 29/05/2023
	- Copyright Notice 	: NA
	- @(#)
	- Description 		: JavaAsgn
	- Admission no		: P2234894
	- Class 			: DIT/FT/2A/03
--%>

<style>
/* Style the tab */
.tab {
	float: left;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
	width: 30%;
	height: 300px;
}

/* Style the buttons inside the tab */
.tab button {
	display: block;
	background-color: inherit;
	color: black;
	padding: 22px 16px;
	width: 100%;
	border: none;
	outline: none;
	text-align: left;
	cursor: pointer;
	transition: 0.3s;
	font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
	background-color: #ddd;
}

/* Create an active/current "tab button" class */
.tab button.active {
	background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
	float: left;
	padding: 0px 12px;
	border: 1px solid #ccc;
	width: 70%;
	border-left: none;
	height: 300px;
}

.book {
	float: center;
	border: 1px solid #ccc;
	background-color: #f1f1f1;
	width: 70%;
	height: 300px;
}
</style>
</head>
<body>
	<div
		style="display: flex; flex-direction: row; justify-content: center; width: 90%; height: 30%; margin: 20px auto;">

		<div
			style="display: flex; flex-direction: row; justify-content: center; width: 30%; height: 100%;">
			<img src="../Graphics/ShopIcon.jpg"
				style="width: 100%; height: 100%;">
		</div>

		<div
			style="display: flex; flex-direction: row; justify-content: center; width: 70%; height: 100%;">
			<h1 style="margin-left: 10px;">Welcome!</h1>
		</div>



		<div
			style="display: flex; flex-direction: column; justify-content: center; width: 30%; height: 100%;">
			<button style="margin-bottom: 10%">Button 1</button>
			<button style="margin-bottom: 10%">Button 2</button>
			<button style="margin-bottom: 10%">Button 3</button>
		</div>
	</div>
	<%
	//---------------START - initialisation of variables--------------------
	Boolean found = false; //to indicate if found or not
	ArrayList<String> category = new ArrayList<>();
	//---------------ENd   - initialization of variables-------------------
	try {
		// Step1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);
		// Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		// Step 5: Execute SQL Command

		String sqlStr = "SELECT name FROM category ";
		ResultSet rs = stmt.executeQuery(sqlStr);
		
		String sqlBook = "SELECT title , author , image from book where cat_id = ?";
	%>

	<div class="tab">
		<%
		// Step 6: Process Result
		while (rs.next()) {
			System.out.print("record found!");
			found = true;
		%>
		<button class="tablinks"><%=rs.getString("name")%></button>
		<%
		}
		%>
	</div>
	<%
	
	// Step 7: Close connection
	conn.close();
	} catch (Exception e) {
	out.println("Error :" + e);
	}
	%>
	
	<div class="book">
	
	</div>








</body>
</html>