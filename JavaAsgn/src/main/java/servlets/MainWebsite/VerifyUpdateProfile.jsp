<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.InputStream, java.io.OutputStream, java.io.FileOutputStream"%>
<%@ page import="javax.servlet.http.Part"%>
<%@ page import="javax.servlet.annotation.MultipartConfig"%>

<%@ page import="java.sql.*"%>

<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verify Profile Update</title>

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
	<%


String username = request.getParameter("username");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String password = request.getParameter("password");
String image= (String) session.getAttribute("sessPhoto");

int userId = (int) session.getAttribute("sessUserID");

Class.forName("com.mysql.jdbc.Driver");  

// Step 2: Define Connection URL
String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

// Step 3: Establish connection to URL
Connection conn = DriverManager.getConnection(connURL); 
// Step 4: Create Statement object
Statement stmt = conn.createStatement();
//Create a prepared statement to check for existing records
String query = "SELECT COUNT(*) FROM user WHERE (username = ? OR phone = ? OR email = ?) AND id <> ?";

PreparedStatement statement = conn.prepareStatement(query);
statement.setString(1, username);
statement.setString(2, phone);
statement.setString(3, email);
statement.setInt(4,userId);

//Execute the query
ResultSet resultSet = statement.executeQuery();


//Retrieve the count of matching records
int count = 0;
if (resultSet.next()) {
count = resultSet.getInt(1);
}


if (count > 0) {
 //a duplicate record already exists
 response.sendRedirect("Profile.jsp?msgCode=duplicate"); // Redirect with an error code
}
else {
try {
   
    String sql = "UPDATE user SET username=?, phone=?, email=?, password=?, image=? WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    
    pstmt.setString(1, username);
    pstmt.setString(2, phone);
    pstmt.setString(3, email);
    pstmt.setString(4, password);
   
    pstmt.setString(5,image); 
    pstmt.setInt(6, userId);
    
    int rowsAffected = pstmt.executeUpdate();
   
    pstmt.close();
    conn.close();
    if (rowsAffected > 0) {
        // Data updated successfully
       
       session.setAttribute("sessUsername", username);
       session.setAttribute("sessPhone", phone);
       session.setAttribute("sessEmail", email);
       session.setAttribute("sessPhoto",image);
       session.setAttribute("sessPassword",password);
       response.sendRedirect(response.encodeRedirectURL("Profile.jsp?msgCode=successUpdate"));
 // Redirect to the profile page
    } else {
        // Error occurred during update
       response.sendRedirect(response.encodeRedirectURL("Profile.jsp?msgCode=updateError"));
// Redirect to an error page
    }
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect(response.encodeRedirectURL("Profile.jsp?msgCode=updateError"));
 // Redirect to an error page
}
}
%>
</body>
</html>