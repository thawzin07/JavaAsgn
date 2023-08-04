package dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Purchase {
	public void insertPurchaseRecord(int userid) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int book_id = 0;
	    int count = 0;
	    int nrow = 0;
	    Date currentDate = new Date();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    String formattedDate = dateFormat.format(currentDate);
	    String datePurchased = formattedDate;
	    
	    try {
	        conn = DBConnection.getConnection();
	        String sqlSelect = "SELECT book_id, count FROM cart WHERE user_id = ?";
	        PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	        selectStmt.setInt(1, userid);
	        ResultSet rs = selectStmt.executeQuery();
	        
	        while (rs.next()) {
	            book_id = rs.getInt("book_id");
	            count = rs.getInt("count");
	            
	            // Step 4: Move data to the purchase table
	            String sqlInsert = "INSERT INTO purchase (user_id, book_id, count, purchased_date) VALUES (?, ?, ?, ?)";
	            PreparedStatement insertStmt = conn.prepareStatement(sqlInsert);
	            insertStmt.setInt(1, userid);
	            insertStmt.setInt(2, book_id);
	            insertStmt.setInt(3, count);
	            insertStmt.setString(4, datePurchased);
	            nrow = insertStmt.executeUpdate();
	        }

	        // Step 5: Delete cart items for the specific user
	        String sqlDelete = "DELETE FROM cart WHERE user_id = ?";
	        PreparedStatement deleteStmt = conn.prepareStatement(sqlDelete);
	        deleteStmt.setInt(1, userid);
	        deleteStmt.executeUpdate(); // Execute the delete statement
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            conn.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}







}
