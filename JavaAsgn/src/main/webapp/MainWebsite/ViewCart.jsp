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
        
   
       
        function removeFromCart(bookid){
        	 var form = document.createElement("form");
             form.setAttribute("method", "post");
             form.setAttribute("action", "<%= request.getContextPath() %>/RemoveFromCartServlet");

             var hiddenField = document.createElement("input");
             hiddenField.setAttribute("type", "hidden");
             hiddenField.setAttribute("name", "bookid");
             hiddenField.setAttribute("value", bookid);
             form.appendChild(hiddenField);

             document.body.appendChild(form);
             form.submit();
        }
        function goBack() {
            window.location.href="CategoryPublic.jsp";
        }

        function submitCheckoutForm() {
            // Get all the selected checkboxes
            var selectedItems = document.querySelectorAll('input[name="selectedItems"]:checked');

            // Create a hidden input field for each selected item and append them to the form
            for (var i = 0; i < selectedItems.length; i++) {
                var bookId = selectedItems[i].value;
                var hiddenField = document.createElement("input");
                hiddenField.setAttribute("type", "hidden");
                hiddenField.setAttribute("name", "selectedItems");
                hiddenField.setAttribute("value", bookId);
                document.getElementById("checkoutForm").appendChild(hiddenField);
            }

            // Submit the form with the selected items
            document.getElementById("checkoutForm").submit();
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

.red-button {
	background-color: red;
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
	
    <!--  <input type="checkbox" id="selectAll" name="selectAll" onchange="toggleSelectAll(this)">
    <label for="selectAll">Select All</label> -->

<form action="<%= request.getContextPath() %>/ChangeQuantityServlet" method="post">
    <table border="1">
        <tr> 
           
            <th>Title</th>
            <th>Price</th>
            <th>Image</th>
            <th>Qty</th>
           
        </tr>

        <%
        String userIdStr = session.getAttribute("sessUserID").toString();
        int userid = Integer.parseInt(userIdStr);
    		float total=0;
      

        // Step 1: Load JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");

        // Step 2: Define Connection URL
        String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

        // Step 3: Establish connection to URL
        Connection conn = DriverManager.getConnection(connURL);

        // Step 4: Create PreparedStatement object
        String sqlStr = "SELECT b.title, b.id, b.price, b.quantity, b.image, b.quantity, c.count " +
                "FROM cart c " +
                "JOIN book b ON c.book_id = b.id " +
                "WHERE c.user_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
        pstmt.setInt(1, userid);

        // Step 5: Execute the query to fetch cart items for the specific user
        ResultSet rs = pstmt.executeQuery();
        if (!rs.next()) {
        %>
            <tr>
                <td colspan="3">Your cart is empty.</td>
            </tr>
        <%
        } else {
            do {
                String title = rs.getString("title");
                float price = rs.getFloat("price");
                String image = rs.getString("image");
                int count = rs.getInt("count");
                int bookid = rs.getInt("id");
                int qty = rs.getInt("quantity");
                total+=count*price;
             
        %>
            <tr>
                
                <td><%= title %></td>
                <td>$<%= price %></td>
                <td><img src="<%= image %>" alt="Book Cover"></td>
                <td>
                    <input type="number" name="quantity_<%= bookid %>" value="<%= count %>" min="1" max="<%= qty %>">
                </td>
                <td>
                    <button type="button" class="red-button" onClick="removeFromCart(<%= bookid %>)">Remove</button>
                </td>
            </tr>
        <%
            } while (rs.next());
        }

        // Step 6: Close connection
        conn.close();
        %>
    </table>
    <button class="blue-button" type="submit">Update Quantity</button>
</form>

<form action="MakePayment.jsp" method="post">
    <button class="blue-button" type="submit" onClick="submitCheckoutForm()">Checkout</button>
</form>

<p>
    Total price : <%=total %>
</p>
		
</body>
</html>