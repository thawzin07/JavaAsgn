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
<script src="inputvalidation.js"></script>
<script>
function goBack(){
	window.location.href="MainWebsite/ViewCart.jsp";
	
}
function buyNow() {
    // Get the PayPal form element
    var paypalForm = document.getElementById('paypalForm');

    // Submit the form to redirect the user to PayPal payment page
    paypalForm.submit();
}

function showCreditCardForm() {
    // Get the credit card form element
    var creditCardForm = document.getElementById('creditCardForm');
    
    // Display the credit card form
    creditCardForm.style.display = 'block';
}

function checkErrors() {
    var errorMessages = document.querySelectorAll(".error-message");
    var submitButton = document.getElementById("submitButton");
    
    for (var i = 0; i < errorMessages.length; i++) {
        if (errorMessages[i].innerText !== "") {
            submitButton.disabled = true;
            submitButton.classList.add("disabled");
            return;
        }
    }
    
    submitButton.disabled = false;
    submitButton.classList.remove("disabled");
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

img {
	width: 150px;
	height: auto;
}
#creditCardForm {
    display: none;
}

.creditCardBtn {
    display: none;
}
.error-message {
	position: relative;
	color: red;
	font-size: 12px;
	bottom: -20px;
}

</style>

</head>
<body>
<%Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
if (isLoggedIn == null || !isLoggedIn) {
    response.sendRedirect("Login2.jsp");
} %>
<%@include file="header.html" %>
<button onClick="goBack()">Go Back</button>  

	<%


// Replace these variables with your sandbox merchant account credentials
String merchantEmail = "sb-5rg1f15257391@business.example.com";
String currencyCode = "SGD"; 
String returnURL = "http://localhost:8080/JavaAsgn/MainWebsite/PaymentSuccess.jsp"; 
String cancelURL = "http://localhost:8080/JavaAsgn/MainWebsite/ViewCart.jsp";



// PayPal sandbox endpoint
String paypalEndpoint = "https://api.sandbox.paypal.com";

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
    <p>Total Price: <%=total %></p>
     
<label for="address">Address:</label>
<input type="text" name="address" value="${address}" disabled /><br>

<label for="address">Postal:</label>
<input type="text" name="postal" value="${postal}" disabled /><br>

 <form id="paypalForm" action="<%= paypalEndpoint %>" method="post">
        <!-- Required PayPal parameters for Buy Now button -->
        <input type="hidden" name="cmd" value="_xclick">
        <input type="hidden" name="business" value="<%= merchantEmail %>">
        <input type="hidden" name="item_name" value="Your Item Name">
        <input type="hidden" name="amount" value="<%= total %>">
        <input type="hidden" name="currency_code" value="<%= currencyCode %>">
        <input type="hidden" name="return" value="<%= returnURL %>">
        <input type="hidden" name="cancel_return" value="<%= cancelURL %>">

       
  
		
        <input type="submit" name="PayPal" onClick="buyNow()">
    </form>
    
    <!-- Credit Card form -->
    <form id="creditCardForm" action="<%= request.getContextPath() %>/MakePaymentServlet" method="post">
        <h2>Credit Card Payment</h2>
        <input type="hidden" name="total" value="<%=total %>">
         <input type="hidden" name="userid" value="<%= userid %>">
        
        <label for="cardNumber">Card Number:</label><br/>
        <input type="text" id="cardNumber" name="cardNumber"  oninput="validateCardNumber(); checkErrors()"><br/>
        <span id="cardnumber-error" class="error-message"></span> <br />
        
        <label for="cardholder">Card Holder Name:</label><br/>
        <input type="text" id="cardholder" name="cardholder"  oninput="validateCardholder(); checkErrors()"><br/>
         <span id="cardholder-error" class="error-message"></span> <br />
         
        <label for="expirydate">Expiry Date:</label><br/>
        <input type="text" id="expirydate" name="expirydate"  oninput="validateExpiry(); checkErrors()"><br/>
         <span id="expirydate-error" class="error-message"></span> <br />
         
        <label for="cvv">CVV:</label><br/>
        <input type="text" id="cvv" name="cvv"  oninput="validateCVV(); checkErrors()"><br/>
         <span id="cvv-error" class="error-message"></span> <br />
         
        <input type="submit" id="submitButton" name="submitCreditCard" value="Pay with Credit Card">
    </form>

    <!-- "Credit Card" button -->
    <button type="button" name="creditCardForm" onClick="showCreditCardForm()">Credit Card</button>


<%@include file="footer.html" %>
</body>
</html>