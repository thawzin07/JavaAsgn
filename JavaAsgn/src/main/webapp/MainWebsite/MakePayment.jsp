<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Arrays" %>
    <%@ page import="java.sql.*"%>
    <%@page import="dbaccess.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Make Payment</title>
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

// Replace these variables with your sandbox merchant account credentials
String merchantEmail = "sb-nolzg26673505@business.example.com";
String currencyCode = "SGD"; // Change this to the appropriate currency code
String returnURL = "http://localhost:8080/JavaAsgn/MainWebsite/PaymentSuccess.jsp"; // Replace with your success page URL
String cancelURL = "http://localhost:8080/JavaAsgn/MainWebsite/viewcart.jsp"; // Replace with your cancel page URL

// Total amount to be paid (you can fetch this from your backend)
double totalAmount = 100.0; // Replace with the total amount to be paid

// PayPal sandbox endpoint
String paypalEndpoint = "https://sandbox.paypal.com";

%>
<h1>Make Payment</h1>
    
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
                    <input type="number" name="quantity_<%= bookid %>" value="<%= count %>" disabled >
                </td>
               
            </tr>
        <%
            } while (rs.next());
        }

        // Step 6: Close connection
        conn.close();
        %>
    </table>  

<input="text" name="address" value="${address}"  disabled />
<Label for="address">Address: </Label>
<input="text" name="postal" value="${postal}"disabled />
<Label for="postal">Postal: </Label>

 <form action="<%= paypalEndpoint %>" method="post">
        <!-- Required PayPal parameters for Buy Now button -->
        <input type="hidden" name="cmd" value="_xclick">
        <input type="hidden" name="business" value="<%= merchantEmail %>">
        <input type="hidden" name="item_name" value="Your Item Name">
        <input type="hidden" name="amount" value="<%= totalAmount %>">
        <input type="hidden" name="currency_code" value="<%= currencyCode %>">
        <input type="hidden" name="return" value="<%= returnURL %>">
        <input type="hidden" name="cancel_return" value="<%= cancelURL %>">

        <!-- Customize the appearance of the PayPal button -->
        <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_buynow_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online.">
    </form>




</body>
</html>