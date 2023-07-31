<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="mybooks.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<%--
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03

--%>
<meta charset="ISO-8859-1">
<title>View Cart</title>
<script>
        function goBack() {
            window.history.back();
        }
       
        	 function updateQuantity(bookId, newQuantity) {
        	        // Use AJAX to send the updated quantity to the server
        	        const xhr = new XMLHttpRequest();
        	        const url = "<%=request.getContextPath() %>/UpdateCartServlet";
        	        const params = `bookId=${bookId}&newQuantity=${newQuantity}`;
        	        xhr.open("POST", url, true);
        	        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        	        xhr.onreadystatechange = function () {
        	            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
        	                // Handle the response if needed
        	                console.log(xhr.responseText);
        	            }
        	        };
        	        xhr.send(params);
        	    }

        	  function updateQuantities() {
        	        // Submit the form to update all quantities at once
        	        document.getElementById("updateForm").submit();
        	    }
        
       
    </script>
<style>
.container {
	text-align: center;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

body {
	background-color: #E8DFDF;
}

.blue-button {
	background-color: blue;
	color: white;
	padding: 5px 10px;
	border: none;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px;
	cursor: pointer;
	align-items: center;
}

img {
	width: 150px;
	height: auto;
}
</style>
</head>
<body>
	<%
Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
if (isLoggedIn == null || !isLoggedIn) {
    response.sendRedirect("Login2.jsp");
}
%>
	<button onClick="goBack()">Go Back</button>
	<h1>View Cart</h1>
	<form action="/checkout" method="post">
    <!--  <input type="checkbox" id="selectAll" name="selectAll" onchange="toggleSelectAll(this)">
    <label for="selectAll">Select All</label> -->

    <table border="1">
        <tr>
            <th>Title</th>
            <th>Price</th>
            <th>Image</th>
            <th>Qty</th>
            <th>Select</th>
        </tr>

			

			<%
           
        String userIdStr = session.getAttribute("sessUserID").toString();
        int userid=Integer.parseInt(userIdStr);
        
        
        

            // Step 1: Load JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            // Step 2: Define Connection URL
            String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

            // Step 3: Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);

            // Step 4: Create PreparedStatement object
            String sqlStr = "SELECT b.title,b.id, b.price,b.quantity, b.image,b.quantity, c.count " +
                    "FROM cart c " +
                    "JOIN book b ON c.book_id = b.id " +
                    "WHERE c.user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sqlStr);
            pstmt.setInt(1, userid);

            // Step 5: Execute the query to fetch cart items for the specific user
            ResultSet rs = pstmt.executeQuery();
	if(!rs.next()){
		%>
			<tr>
				<td colspan="3">Your cart is empty.</td>

			</tr>
			<% 
	}
	else{
          do {
                String title = rs.getString("title");
                float price = rs.getFloat("price");
                String image = rs.getString("image");
                int count = rs.getInt("count");
                int bookid=rs.getInt("id");
                int qty=rs.getInt("quantity");
              
                
        %>

			<tr>
				<td><%= title %></td>
				<td>$<%= price %></td>
				<td><img src="<%= image %>" alt="Book Cover"></td>
				<td>
					
    <input type="number" name="quantity_<%= bookid %>" value="<%= count %>" min="1" max="<%= qty %>" 
     onchange="updateQuantity(<%= bookid %>, this.value)" >
</td>
				<td>
                <input type="checkbox" name="selectedItems" value="<%= bookid %>">
            </td>

			</tr>

			<%
            }  while (rs.next());
	}
            // Step 6: Close connection
            conn.close();
        %>
		</table>
		<button class="blue-button">Checkout</button>
		 <button type="button" onclick="updateQuantities()">Update Quantities</button>
		</form>
	</div>
	<p>
		Final prices will be calculated at checkout.
		
</body>
</html>