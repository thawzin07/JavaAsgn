<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%--
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
--%>

<%@page import ="java.sql.*"%>

<%
//Assuming you have obtained the username, phone, and email values from the form data
String username = request.getParameter("loginid");
String phone = request.getParameter("phone");
String email = request.getParameter("email");

Class.forName("com.mysql.jdbc.Driver");  

// Step 2: Define Connection URL
String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=thsSQL4302&serverTimezone=UTC";

// Step 3: Establish connection to URL
Connection conn = DriverManager.getConnection(connURL); 
// Step 4: Create Statement object
Statement stmt = conn.createStatement();
//Create a prepared statement to check for existing records
String query = "SELECT COUNT(*) FROM user WHERE username = ? OR phone = ? OR email = ?";
PreparedStatement statement = conn.prepareStatement(query);
statement.setString(1, username);
statement.setString(2, phone);
statement.setString(3, email);

//Execute the query
ResultSet resultSet = statement.executeQuery();

//Retrieve the count of matching records
int count = 0;
if (resultSet.next()) {
 count = resultSet.getInt(1);
}

//Check the count and take appropriate action
if (count > 0) {
 // A record with the same username, phone, or email already exists
 // Perform any necessary error handling or redirection
 response.sendRedirect("Register.jsp?errCode=duplicate"); // Redirect with an error code
} else {
 // No duplicate records found, proceed with registration process
 // Perform the necessary actions to save the user data to the database
 // Redirect to a success page or perform any additional processing
 response.sendRedirect("login.jsp");
}
%>

</body>
</html>