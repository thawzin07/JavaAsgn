<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dbaccess.Book"%>

<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Inventory Report For Third Party</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	padding: 20px;
}

.search-container {
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #f2f2f2;
	padding: 10px;
	margin-bottom: 20px;
}

.search-input {
	width: 400px;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 17px;
}

.search-button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 8px 16px;
	margin-left: 10px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
}

.search-button:hover {
	background-color: #0056b3;
}

h2 {
	color: #007bff;
	margin-bottom: 20px;
}

.book-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-between; /* Added to evenly space book cards */
}

.book-card {
	border: 1px solid #ddd;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin: 10px;
	flex-basis: calc(33.33% - 20px);
	/* Updated to distribute width equally */
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

h5 {
	font-weight: bold;
}

.green-text {
	color: green;
}

.red-text {
	color: red;
}

.btn {
	display: inline-block;
	background-color: #3498db;
	color: #fff;
	padding: 8px 16px;
	border-radius: 4px;
	text-decoration: none;
	margin-top: 10px;
	transition: background-color 0.3s;
	border: none;
	cursor: pointer;
	font-size: 16px;
}

.btn:hover {
	background-color: #2980b9;
}


</style>

</head>
<script>
    function goBack() {
        window.history.back(); // Go back to the previous page
    }
</script>


<body>
<%@include file="header.html" %>
	<button class="btn" onclick="goBack()">Go Back</button>
	<%
	@SuppressWarnings("unchecked")
	ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("topsales");
	@SuppressWarnings("unchecked")
	ArrayList<Book> books2 = (ArrayList<Book>) request.getAttribute("leastsales");
	@SuppressWarnings("unchecked")
	ArrayList<Book> books3 = (ArrayList<Book>) request.getAttribute("lowstock");
	
	
	//ArrayList<Book> books3 = (ArrayList<Book>) session.getAttribute("lowstock");
	%>
	<div class="search-container">
		<form action="<%= request.getContextPath()%>/SearchBookServlet"
			method="GET">
			<input type="text" class="search-input" name="searchtext"
				placeholder="Search Book by title">
			<button type="submit" class="search-button">Search</button>
		</form>
	</div>


	<h2>Top 3 Selling Books</h2>
	
	<div class="book-container">
		<%
		for (int x = 0; x < books.size(); x++) {
		%>
		<div class="book-card">
			<img
				src="<%=request.getContextPath() + "/Graphics/" + books.get(x).getImage()%>">
			<!-- Display other book details -->
			<h3><%=books.get(x).getTitle()%></h3>
			<h6>ISBN</h6>
			<%=books.get(x).getISBN()%>
			<h6>Author</h6>
			<%=books.get(x).getAuthor()%>
			<h6>Price Per Book</h6>
			<%=books.get(x).getPrice()%>
			<h6>In Stock</h6>
			<%=books.get(x).getQuantity()%>
			<h6>Publisher</h6>
			<%=books.get(x).getPublisher()%>
			<h6>Publication Date</h6>
			<%=books.get(x).getPublication_date()%>
			<h5 class="green-text">Sold Count</h5>
			<%=books.get(x).getSold_count()%>

			<h6>Book ID</h6>
			<%=books.get(x).getId()%>
			<h6>Category ID</h6>
			<%=books.get(x).getCat_id()%>
		</div>
		<%
		}
		%>
	</div>

	<h2>3 Least Selling Books</h2>
	<div class="book-container">
		<%
		for (int x = 0; x < books2.size(); x++) {
		%>
		<div class="book-card">
			<img
				src="<%=request.getContextPath() + "/Graphics/" + books2.get(x).getImage()%>">
			<!-- Display other book details -->
			<h3><%=books2.get(x).getTitle()%></h3>
			<h6>ISBN</h6>
			<%=books2.get(x).getISBN()%>
			<h6>Author</h6>
			<%=books2.get(x).getAuthor()%>
			<h6>Price Per Book</h6>
			<%=books2.get(x).getPrice()%>
			<h6>In Stock</h6>
			<%=books2.get(x).getQuantity()%>
			<h6>Publisher</h6>
			<%=books2.get(x).getPublisher()%>
			<h6>Publication Date</h6>
			<%=books2.get(x).getPublication_date()%>
			<h5 class="red-text">Sold Count</h5>
			<%=books2.get(x).getSold_count()%>

			<h6>Book ID</h6>
			<%=books2.get(x).getId()%>
			<h6>Category ID</h6>
			<%=books2.get(x).getCat_id()%>
		</div>
		<%
		}
		%>
	</div>
	
	<h2 style="color: red;">Low Stock Level Books</h2>
	<div class="book-container">
		<%
		for (int x = 0; x < books3.size(); x++) {
		%>
		<div class="book-card">
			<img
				src="<%=request.getContextPath() + "/Graphics/" + books3.get(x).getImage()%>">
			<!-- Display other book details -->
			<h3><%=books3.get(x).getTitle()%></h3>
			<h6>Book ID</h6>
			<%=books3.get(x).getId()%>
			<h6>Category ID</h6>
			<%=books3.get(x).getCat_id()%>
			<h6>ISBN</h6>
			<%=books3.get(x).getISBN()%>
			<h6>Author</h6>
			<%=books3.get(x).getAuthor()%>
			<h6>Price Per Book</h6>
			<%=books3.get(x).getPrice()%>
			<h6>Current Stock Count</h6>
			<%=books3.get(x).getQuantity()%>
			
			<h5 class="red-text">Sold Count</h5>
			<%=books3.get(x).getSold_count()%>

			
		</div>
		<%
		}
		%>
	</div>
	<%@include file="footer.html" %>

</body>
</html>