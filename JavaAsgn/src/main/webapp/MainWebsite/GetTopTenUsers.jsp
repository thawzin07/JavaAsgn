<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*,dbaccess.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Top Ten Users</title>
</head>
<body>
<% if (request.getAttribute("toptenusers") != null) { %>
        <%-- Fetch data and calculate total price from the request attributes --%>
        <% ArrayList<User> toptenusers = (ArrayList<User>) request.getAttribute("toptenusers"); %>
       
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

</body>
</html>