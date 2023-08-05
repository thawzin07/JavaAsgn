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
	
	
	
	
	 public ArrayList<PurchaseItem> getAllPurchases() throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        ArrayList<PurchaseItem> purchaseList = new ArrayList<>();
	        PurchaseItem purchaseBean=null;
	       

	        try {
	            conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT p.book_id, b.title AS book_name,b.price, u.username, p.count, p.purchased_date "
	                    + "FROM purchase p "
	                    + "JOIN book b ON p.book_id = b.id "
	                    + "JOIN user u ON p.user_id = u.id";
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	            ResultSet rs = selectStmt.executeQuery();

	            while (rs.next()) {
	            	purchaseBean = new PurchaseItem();
					purchaseBean.setBookid(Integer.parseInt(rs.getString("book_id")));
					purchaseBean.setBookname(rs.getString("book_name"));
					purchaseBean.setUsername(rs.getString("username"));
					purchaseBean.setCount(rs.getInt("count"));
					purchaseBean.setDatePurchased(rs.getString("purchased_date"));
					
	                
	                

	              
	                purchaseList.add(purchaseBean);
	                System.out.println("purchaseList size: " + purchaseList.size()); 
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (conn != null) {
	                conn.close();
	            }
	        }
	        System.out.print("purchaseList"+purchaseList);
	        return purchaseList;
	    }
	 
	 public ArrayList<PurchaseItem> getAllPurchasesByUserId(int userid) throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        ArrayList<PurchaseItem> purchaseList = new ArrayList<>();
	        PurchaseItem purchaseBean=null;
	       

	        try {
	            conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT p.book_id, b.title AS book_name, b.price, p.count, p.purchased_date "
	            	    + "FROM purchase p "
	            	    + "JOIN book b ON p.book_id = b.id "
	            	    + "JOIN user u ON p.user_id = u.id "
	            	    + "WHERE p.user_id = ?";
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	            selectStmt.setInt(1, userid);
	            ResultSet rs = selectStmt.executeQuery();

	            while (rs.next()) {
	            	purchaseBean = new PurchaseItem();
					purchaseBean.setBookid(Integer.parseInt(rs.getString("book_id")));
					purchaseBean.setBookname(rs.getString("book_name"));
					purchaseBean.setPrice(rs.getFloat("price"));
					
					//System.out.print(rs.getFloat("price"));
					purchaseBean.setCount(rs.getInt("count"));
					purchaseBean.setDatePurchased(rs.getString("purchased_date"));
					
	                
	                

	              
	                purchaseList.add(purchaseBean);
	                //System.out.println("purchaseList size: " + purchaseList.size()); 
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (conn != null) {
	                conn.close();
	            }
	        }
	        System.out.print("purchaseList"+purchaseList);
	        return purchaseList;
	    }
	 public ArrayList<PurchaseItem> getPurchaesByPeriod(String datefrom, String dateto) throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        ArrayList<PurchaseItem> purchaseList = new ArrayList<>();
	        PurchaseItem purchaseBean=null;
	       

	        try {
	            conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT p.book_id, b.title AS book_name,b.price, u.username, p.count, p.purchased_date "
	                    + "FROM purchase p "
	                    + "JOIN book b ON p.book_id = b.id "
	                    + "JOIN user u ON p.user_id = u.id"
	                    +"WHERE p.purchased_date BETWEEN ? AND ?";
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	            selectStmt.setString(1,datefrom);
	            selectStmt.setString(2,dateto);
	            
	            ResultSet rs = selectStmt.executeQuery();

	            while (rs.next()) {
	            	purchaseBean = new PurchaseItem();
					purchaseBean.setBookid(Integer.parseInt(rs.getString("book_id")));
					purchaseBean.setBookname(rs.getString("book_name"));
					purchaseBean.setUsername(rs.getString("username"));
					int count=rs.getInt("count");
					purchaseBean.setCount(count);
					float price=rs.getFloat("price");
					purchaseBean.setPrice(price);
					purchaseBean.setTotal(count*price);
					purchaseBean.setDatePurchased(rs.getString("purchased_date"));
					
	                
	                

	              
	                purchaseList.add(purchaseBean);
	                System.out.println("purchaseList size: " + purchaseList.size()); 
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (conn != null) {
	                conn.close();
	            }
	        }
	        System.out.print("purchaseList"+purchaseList);
	        return purchaseList;
	    }
	 
	 public float getTotalPriceOfAllPurchases() throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        float totalPrice = 0;

	        try {
	            conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT SUM(b.price * p.count) AS total_price "
	                    + "FROM purchase p "
	                    + "JOIN book b ON p.book_id = b.id";
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	            ResultSet rs = selectStmt.executeQuery();

	            if (rs.next()) {
	                totalPrice = rs.getFloat("total_price");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (conn != null) {
	                conn.close();
	            }
	        }

	        return totalPrice;
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
	            
	            String updateQty="UPDATE book SET quantity=quantity-? ,sold_count=sold_count+? WHERE id=?";
	            PreparedStatement qtyStmt=conn.prepareStatement(updateQty);
	            qtyStmt.setInt(1, count);
	            qtyStmt.setInt(2, count);
	            qtyStmt.setInt(3, book_id);
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
