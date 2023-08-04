<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*" %>
    <%@page import="dbaccess.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Get Books Sales By Month</title>
</head>
<body>
 <% if (request.getAttribute("purchasedItems") != null) { %>
        <%-- Fetch data and calculate total price from the request attributes --%>
        <% ArrayList<PurchaseItem> purchasedItems = (ArrayList<PurchaseItem>) request.getAttribute("purchasedItems"); %>
        <% float grandTotal = (Float) request.getAttribute("grandTotal"); 
        
        String month=(String)request.getAttribute("month");
        
        %>

        <h2>Sales Of Books In <%=month %> </h2>
        <p>Total Price of All Purchases: $<%= grandTotal %></p>

        <h3>Purchased Items</h3>
        <table border="1">
            <tr>
                <th>Book ID</th>
                <th>Book Name</th>
                <th>Username</th>
                <th>Count</th>
                <th>Date Purchased</th>
               
            </tr>
            <% for (PurchaseItem item : purchasedItems) { %>
                <tr>
                    <td><%= item.getBookid() %></td>
                    <td><%= item.getBookname() %></td>
                    <td><%= item.getUsername() %></td>
                    <td><%= item.getCount() %></td>
                    <td><%= item.getDatePurchased() %></td>
                   
                </tr>
            <% } %>
        </table>
    <% } %>
</body>
</html>