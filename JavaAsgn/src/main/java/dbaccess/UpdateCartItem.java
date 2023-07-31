package dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateCartItem {
	
	public void updateCartItem(int userId, int bookId, int newQuantity) throws SQLException, ClassNotFoundException {
		 
	        try {
	            Connection conn = DBConnection.getConnection();
	            String updateCartSQL = "UPDATE cart SET count = ? WHERE user_id = ? AND book_id = ?";
	            PreparedStatement updateCartStmt = conn.prepareStatement(updateCartSQL);
	            updateCartStmt.setInt(1, newQuantity);
	            updateCartStmt.setInt(2, userId);
	            updateCartStmt.setInt(3, bookId);
	            updateCartStmt.executeUpdate();
	            conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

}
