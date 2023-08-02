<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>Make Payment</h1>
    
    <%-- Retrieve the selected item IDs from the form --%>
    <% String[] selectedItems = request.getParameterValues("selectedItems"); %>
    <% if (selectedItems != null && selectedItems.length > 0) { %>
        <p>Selected Item IDs: <%= Arrays.toString(selectedItems) %></p>
        <%-- Here, you can process the selected item IDs and perform payment-related operations --%>
        <%-- For example, you can retrieve the details of the selected items from the database --%>
    <% } else { %>
        <p>No items selected for payment.</p>
    <% } %>


</body>
</html>