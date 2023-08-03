<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.util.Arrays" %>
    <%@ page import="java.sql.*"%>
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

<input="text" name="address"  disabled />
<Label for="address">Address: </Label>
<input="text" name="postal" disabled />
<Label for="postal">Postal: </Label>



</body>
</html>