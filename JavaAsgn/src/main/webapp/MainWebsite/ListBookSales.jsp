<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dbaccess.Book"%>

<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ListBookSales</title>
</head>
<body>
	<%
ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("bookdata");
	System.out.print(books.size());
%>
	<h2>Top 5 Selling Books</h2>
	<%
for(int x = 0 ; x < books.size() ; x++){
%>
	<img src="<%= books.get(x).getImage() %>">
	<h3>Title</h3>
	<%= books.get(x).getTitle() %>
	<h6>ISBN</h6>
	<%= books.get(x).getISBN() %>
	<h6>Author</h6>
	<%= books.get(x).getAuthor() %>
	<h6>Price Per Book</h6>
	<%= books.get(x).getPrice() %>
	<h6>In stock</h6>
	<%= books.get(x).getQuantity() %>
	<h6>Publisher</h6>
	<%= books.get(x).getPublisher() %>
	<h6>Publication_date</h6>
	<%= books.get(x).getPublication_date() %>
	<h6>Sold_count</h6>
	<%= books.get(x).getSold_count() %>
	<h6>Book ID</h6>
	<%= books.get(x).getId() %>
	<h6>Category ID</h6>
	<%= books.get(x).getCat_id() %>

	<%
}
%>


</body>
</html>