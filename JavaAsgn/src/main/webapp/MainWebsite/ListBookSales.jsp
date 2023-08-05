<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dbaccess.Book"%>

<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ListBookSales</title>
<style>
	body {
		font-family: Arial, sans-serif;
		background-color: #f5f5f5;
		padding: 20px;
	}

	h2 {
		color: #007bff;
		margin-bottom: 20px;
	}

	.book-container {
		display: flex;
		flex-wrap: wrap;
	}

	.book-card {
		border: 1px solid #ddd;
		box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		padding: 20px;
		margin: 10px;
		flex-basis: calc(33.33% - 40px);
		background-color: #fff;
	}

	.book-card img {
		max-width: 100%;
		height: auto;
		margin-bottom: 10px;
	}

	h3, h6 {
		color: #333;
		margin-bottom: 5px;
	}

	h6 {
		font-weight: normal;
		color: #888;
	}

</style>
</head>
<body>
<%@include file="header.html" %>
	<%
	ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("bookdata");
	%>
	<h2>Top 3 Selling Books</h2>
	<div class="book-container">
	<%
	for(int x = 0 ; x < books.size() ; x++){
	%>
		<div class="book-card">
			<img src="<%= request.getContextPath() + "/Graphics/" + books.get(x).getImage() %>">

			<h3><%= books.get(x).getTitle() %></h3>
			<h6>ISBN</h6>
			<%= books.get(x).getISBN() %>
			<h6>Author</h6>
			<%= books.get(x).getAuthor() %>
			<h6>Price Per Book</h6>
			<%= books.get(x).getPrice() %>
			<h6>In Stock</h6>
			<%= books.get(x).getQuantity() %>
			<h6>Publisher</h6>
			<%= books.get(x).getPublisher() %>
			<h6>Publication Date</h6>
			<%= books.get(x).getPublication_date() %>
			<h6>Sold Count</h6>
			<%= books.get(x).getSold_count() %>
			<h6>Book ID</h6>
			<%= books.get(x).getId() %>
			<h6>Category ID</h6>
			<%= books.get(x).getCat_id() %>
		</div>
	<%
	}
	%>
	</div>
	<%@include file="footer.html" %>
</body>
</html>