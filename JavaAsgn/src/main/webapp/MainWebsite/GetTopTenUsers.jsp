<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*,dbaccess.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Top Ten Users</title>
<script>

function goBack() {
	  window.location.href="MainWebsite/SalesManagement.jsp";
}
</script>
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
<% if (request.getAttribute("toptenusers") != null) { %>
        <%-- Fetch data and calculate total price from the request attributes --%>
        <% ArrayList<User> toptenusers = (ArrayList<User>) request.getAttribute("toptenusers"); %>
  
  <button onClick="goBack()">Go Back</button>     
 <h2>Top Ten Users</h2>
   

    
    <table border="1">
        <tr>
            <th>Username</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Total Spend</th>
           
           
        </tr>
        <% for (User user : toptenusers) { %>
        <tr>
            <td><%= user.getUsername() %></td>
            <td><%= user.getPhone() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getTotalSpent() %></td>
         
            
        </tr>
        <% } 
        
        }%>
      
        
    </table>
<%@include file="footer.html" %>
</body>
</html>