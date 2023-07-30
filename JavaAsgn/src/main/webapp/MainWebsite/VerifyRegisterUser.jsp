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
<%@page import="dbaccess.UserDAO" %>

<%

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



UserDAO userDAO = new UserDAO();
try {
    boolean isDuplicate = userDAO.checkDuplicateUser(username, phone, email);
    if (isDuplicate) {
        // A record with the same username, phone, or email already exists
        response.sendRedirect(response.encodeRedirectURL("Register.jsp?msgCode=duplicate")); // Redirect with an error code
    } else {
        // No duplicate found, insert the new user record
        int rowsAffected = userDAO.insertUser(username, email, phone,password, role, image, dateJoined);
        if (rowsAffected > 0) {
            // Data inserted successfully
            response.sendRedirect(response.encodeRedirectURL("Login2.jsp?msgCode=successRegister"));
        } else {
            // Error occurred during insertion
            response.sendRedirect(response.encodeRedirectURL("Register.jsp?msgCode=invalidRegister"));
        }
    }
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
    response.sendRedirect(response.encodeRedirectURL("Register.jsp?msgCode=errorRegister"));
}

 


%>

</body>
</html>