package dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Purchase {
	 public ArrayList<PurchaseData> getAllPurchases() throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        ArrayList<PurchaseData> purchaseList = new ArrayList<>();
	        float total=0;

	        try {
	            conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT p.book_id, b.title AS book_name,b.price, u.username, p.count, p.purchase_date "
	                    + "FROM purchase p "
	                    + "JOIN book b ON p.book_id = b.id "
	                    + "JOIN users u ON p.user_id = u.id";
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	            ResultSet rs = selectStmt.executeQuery();

	            while (rs.next()) {
	                int bookId = rs.getInt("book_id");
	                String bookName = rs.getString("book_name");
	                String username = rs.getString("username");
	                int count = rs.getInt("count");
	                String datePurchased = rs.getString("purchase_date");
	                Float price=rs.getFloat("price");
	                 total=price*count;
	                

	                PurchaseData purchaseData = new PurchaseData(bookId, bookName, username, count, datePurchased,total);
	                purchaseList.add(purchaseData);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (conn != null) {
	                conn.close();
	            }
	        }

	        return purchaseList;
	    }
	
	public void insertPurchaseRecord(int userid,float total) throws SQLException, ClassNotFoundException {
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
	        
	        String sqlUpdate="UPDATE user SET total_spend=total_spend + ? WHERE id=?";
	        PreparedStatement updateStmt=conn.prepareStatement(sqlUpdate);
	        updateStmt.setFloat(1, total);
	        updateStmt.setInt(2, userid);
	        updateStmt.executeUpdate();
	        
	        
	        
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
	            
	            String updateQty="UPDATE book SET quantity=quantity-? WHERE id=?";
	            PreparedStatement qtyStmt=conn.prepareStatement(updateQty);
	            qtyStmt.setInt(1, count);
	            qtyStmt.setInt(2, book_id);
	            qtyStmt.executeUpdate();
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
