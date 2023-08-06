<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@page import="java.util.*, dbaccess.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Get Users By Book ID</title>
</head>
<body>
<%
Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
String role=(String)session.getAttribute("role");
if (isLoggedIn == null || !isLoggedIn) {
	if(role!="admin")
	{
    response.sendRedirect("Login2.jsp");
	}
}
%>
<%@include file="header.html" %>
<button onClick="goBack()">Go Back</button>   
<%String booktitle=(String)request.getAttribute("bookTitle");
 int bookid=Integer.parseInt((String)request.getParameter("bookid"));%>
<h2>Users who bought <%=booktitle %> (Book Id=<%=bookid %>)</h2>
<% if (request.getAttribute("usersByBookId") != null) { %>
        <%-- Fetch data and calculate total price from the request attributes --%>
        <% ArrayList<User> usersByBookId = (ArrayList<User>) request.getAttribute("usersByBookId"); %>
       
 
   

    
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Phone</th>
            <th>Email</th>
           
           
           
        </tr>
        <% for (User user : usersByBookId) { %>
        <tr>
            <td><%= user.getUsername() %></td>
            <td><%= user.getPhone() %></td>
            <td><%= user.getEmail() %></td>
          
         
            
        </tr>
        <% } 
        
        }%>
      
        
    </table>


<%@include file="footer.html" %>
</body>
</html>