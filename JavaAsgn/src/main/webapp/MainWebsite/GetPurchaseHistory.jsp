<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.*, dbaccess.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@include file="header.html" %>
   <h2>Purchase History</h2>
    <table border="1">
        <tr>
            <th>Book ID</th>
            <th>Book Name</th>
            <th>Price</th>
            <th>Count</th>
            <th>Date Purchased</th>
        </tr>
        <%-- Retrieve the purchaseList from the request --%>
        <% ArrayList<PurchaseItem> purchaseList = (ArrayList<PurchaseItem>) request.getAttribute("purchaseList"); %>
        <%-- Loop through the purchaseList and display each purchase item --%>
        <% for (PurchaseItem item : purchaseList) { %>
        <tr>
            <td><%= item.getBookid() %></td>
            <td><%= item.getBookname() %></td>
            <td><%= item.getPrice() %></td>
            <td><%= item.getCount() %></td>
            <td><%= item.getDatePurchased() %></td>
        </tr>
        <% } %>
    </table>
    <%@include file="footer.html" %>
</body>
</html>