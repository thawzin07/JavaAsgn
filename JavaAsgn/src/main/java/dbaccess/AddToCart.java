package dbaccess;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mybooks.CartItems;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**Author             : Thet Htar San
Date                 : 30/07/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
**/
public class AddToCart {
	public int addToCart(int userid, int bookid, int count) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int nrow = 0;

	    try {
	        // Step1: Load JDBC Driver
	        conn = DBConnection.getConnection();
	        //check cart for existing items
	        String checkCartSQL = "SELECT count FROM cart WHERE user_id = ? AND book_id = ?";
	        PreparedStatement checkCartStmt = conn.prepareStatement(checkCartSQL);
	        checkCartStmt.setInt(1, userid);
	        checkCartStmt.setInt(2, bookid);
	        ResultSet checkCartRs = checkCartStmt.executeQuery();

	        if (checkCartRs.next()) {
	            // If the item is already in the cart, update the quantity
	            int existingCount = checkCartRs.getInt("count");
	            count += existingCount;

	            String updateCartSQL = "UPDATE cart SET count = ? WHERE user_id = ? AND book_id = ?";
	            PreparedStatement updateCartStmt = conn.prepareStatement(updateCartSQL);
	            updateCartStmt.setInt(1, count);
	            updateCartStmt.setInt(2, userid);
	            updateCartStmt.setInt(3, bookid);
	            updateCartStmt.executeUpdate();

	            // Close the resources for the update operation
	            updateCartStmt.close();
	        } else {

	        String sqlStr = "INSERT INTO cart (user_id, book_id, count) VALUES (?, ?, ?)";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        pstmt.setInt(1, userid);
	        pstmt.setInt(2, bookid);
	        pstmt.setInt(3, count);

	        nrow = pstmt.executeUpdate();
	        pstmt.close();
	        }

	        // Step 7: Close resources
	        checkCartStmt.close();
	        conn.close();

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return nrow;
	}
	
	
	 public int removeFromCart(int bookId) throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        int rowsAffected = 0;

	        try {
	            conn = DBConnection.getConnection();
	            String sqlStr = "DELETE FROM cart WHERE book_id = ?";
	            PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	            pstmt.setInt(1, bookId);

	            rowsAffected = pstmt.executeUpdate();
	            pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            if (conn != null) {
	                conn.close();
	            }
	        }

	        return rowsAffected;
	    }
	 public int updateQuantity(int bookId, int updateqty, int user_id) throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        int rowsAffected = 0;

	        try {
	            conn = DBConnection.getConnection();
	            String sqlStr = "UPDATE cart SET count = ? WHERE book_id = ? AND user_id = ?";
	            PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	            pstmt.setInt(1, updateqty);
	            pstmt.setInt(2,bookId);
	            pstmt.setInt(3,user_id);

	            rowsAffected = pstmt.executeUpdate();
	            pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            if (conn != null) {
	                conn.close();
	            }
	        }

	        return rowsAffected;
	    }
	public static List<CartItems> getCartItems(int userId) throws SQLException, ClassNotFoundException {
		 DBConnection dbConnection = new DBConnection();
		    Connection conn = null;
	    List<CartItems> cartItems = new ArrayList<>();
	   

	    try {
	        conn = DBConnection.getConnection();

	        String sqlStr = "SELECT b.title, b.price, b.image,b.quantity, c.count " +
                    "FROM cart c " +
                    "JOIN book b ON c.book_id = b.id " +
                    "WHERE c.user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sqlStr);
            pstmt.setInt(1, userId);

            // Step 5: Execute the query to fetch cart items for the specific user
            ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            int cartId = rs.getInt("id");
	            int bookId = rs.getInt("book_id");
	            int count = rs.getInt("count");
	            int qty = rs.getInt("quantity");
	            String title = rs.getString("title");
	            float price = rs.getFloat("price");
	            String image = rs.getString("image");

	            // Create a new CartItem object and add it to the list
	            CartItems cartItem = new CartItems(title, qty, price, bookId, image);
	            cartItems.add(cartItem);
	        }

	        // Close resources
	        rs.close();
	        pstmt.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }

	    return cartItems;
	}
	
	
	}
	

