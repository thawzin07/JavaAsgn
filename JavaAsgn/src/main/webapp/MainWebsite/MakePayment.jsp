<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, dbaccess.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Sales Management</title>
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <nav class="navbar navbar-expand navbar-dark bg-dark">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="#">Sales Of Books</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Purchased Items</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Get Purchase Data By Period</a></li>
            <!-- Add other navigation items as needed -->
        </ul>
    </nav>
<%@include file="header.html" %>
    <% // Fetch data and calculate total price
        ArrayList<PurchaseItem> purchasedItems = new ArrayList<>();
   
        float grandTotal = 0;

      
        try {
            Connection conn = DBConnection.getConnection();
            String sqlSelect = "SELECT p.book_id, b.title AS book_name, b.price, u.username, p.count, p.purchased_date "
                    + "FROM purchase p JOIN book b ON p.book_id = b.id JOIN user u ON p.user_id = u.id";
            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
            ResultSet rs = selectStmt.executeQuery();
            
          
            

            while (rs.next()) {
                PurchaseItem purchaseBean = new PurchaseItem();
                purchaseBean.setBookid(Integer.parseInt(rs.getString("book_id")));
                purchaseBean.setBookname(rs.getString("book_name"));
                purchaseBean.setUsername(rs.getString("username"));
                purchaseBean.setCount(rs.getInt("count"));
                purchaseBean.setDatePurchased(rs.getString("purchased_date"));
				float price=rs.getFloat("price");
				int count=rs.getInt("count");
				float total=price*count;
				grandTotal+=total;
                purchasedItems.add(purchaseBean);
            }
            rs.close();
            selectStmt.close();
            conn.close();
            
            
           
          
           
           
           
          
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>


    <div class="container mt-4">
        <h2>Sales Of Books</h2>
        <p>Total Price of All Purchases: $<%= grandTotal %></p>

        <h3>Purchased Items</h3>
        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Book ID</th>
                    <th>Book Name</th>
                    <th>Username</th>
                    <th>Count</th>
                    <th>Date Purchased</th>
                </tr>
            </thead>
            <tbody>
                <% for (PurchaseItem item : purchasedItems) { %>
                    <tr>
                        <td><%= item.getBookid() %></td>
                        <td><%= item.getBookname() %></td>
                        <td><%= item.getUsername() %></td>
                        <td><%= item.getCount() %></td>
                        <td><%= item.getDatePurchased() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Add the forms for other functionalities as needed -->
        <form action="<%= request.getContextPath() %>/GetBookSalesByPeriod" method="post">
            <h3>Get Purchase Data By Period</h3>
            <div class="form-group">
                <label for="datefrom">Date From: (Example: 2023-08-04)</label>
                <input type="text" class="form-control" name="datefrom">
            </div>
            <div class="form-group">
                <label for="dateto">Date To: (Example: 2023-08-04)</label>
                <input type="text" class="form-control" name="dateto">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    
      <form action="<%= request.getContextPath() %>/GetBookSalesByMonth" method="post">
    <h3>Get Purchase Data By Month</h3>
    <label for="month">Month: (Example: 08)</label> <br/>
    <input type="text" name="month"><br/>
    
   
    
    <input type="submit" name="Submit">
    </form>
    
       <form action="<%= request.getContextPath() %>/GetTopTenUsers" method="get">
    <h3>Get Top Ten Users</h3>
  
    <input type="submit" name="Submit">
    </form>
    
      <form action="<%= request.getContextPath() %>/GetUsersByBookId" method="post">
    <h3>Get Users By Book ID</h3>
    <label for="bookid">Enter Book ID:</label>
  <input type="text" name="bookid"><br/>
    <input type="submit" name="Submit">
    </form>
    </div>
    <%@include file="footer.html" %>
      <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>