<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="dbaccess.*" %>
    <%@ page import="mybooks.Book" %>
    <%@ page import="java.util.*" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ListBookSales</title>
</head>
<body>
<%
ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("bookdata");

if (books != null && !books.isEmpty()) {
%>
    <h1>List of Books:</h1>
    <ul>
        <% for (Book book : books) { %>
            <li><%= book.getTitle() %> - <%= book.getAuthor() %></li>
        <% } %>
    </ul>
<%
} else {
%>
    <p>No books available.</p>
<%
}
%>

</body>
</html>