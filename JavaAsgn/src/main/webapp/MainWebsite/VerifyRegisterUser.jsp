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
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
if (request.getParameter("submit") != null) {
Date currentDate = new Date();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

String formattedDate = dateFormat.format(currentDate);

String username = request.getParameter("username");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String password=request.getParameter("password1");
String role="user";
String image="../Graphics/DefaultProfile.jpg";
String dateJoined=formattedDate;




Class.forName("com.mysql.jdbc.Driver");  

// Step 2: Define Connection URL
String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

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
}
else {
 //no duplicate found
 try {
   
    // Step 4: Create a PreparedStatement
    String sql = "INSERT INTO user (username, email, phone, password,role,image,joinedDate) VALUES (?,?, ?, ?, ?,?,?)";
    PreparedStatement pstmt = conn.prepareStatement(sql);

    // Step 5: Set parameter values
    pstmt.setString(1, username);
    pstmt.setString(2, email);
    pstmt.setString(3, phone);
    pstmt.setString(4, password);
    pstmt.setString(5, role);
    pstmt.setString(6, image);
    pstmt.setString(7, dateJoined);

    // Step 6: Execute the INSERT query
    int rowsAffected = pstmt.executeUpdate();

    // Step 7: Close resources
    pstmt.close();
    conn.close();

    if (rowsAffected > 0) {
        // Data inserted successfully
        response.sendRedirect("Login2.jsp?msgCode=successRegister"); // Redirect to a success page
    } else {
        // Error occurred during insertion
       response.sendRedirect("Register.jsp?msgCode=invalidRegister"); // Redirect to an error page
    }
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Register.jsp?msgCode=errorRegister"); // Redirect to an error page
}
}
else{
	
}
	
}
 


%>

</body>
</html>