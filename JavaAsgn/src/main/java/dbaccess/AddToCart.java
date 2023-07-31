package dbaccess;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class AddToCart {
	public int addToCart(int userid, int bookid, int count)throws SQLException, ClassNotFoundException {
		Connection conn = null;
		int nrow=0;

	try {
	    // Step1: Load JDBC Driver
		 conn = DBConnection.getConnection();
	    
	    String sqlStr = "INSERT INTO cart (user_id, book_id, count) VALUES (?, ?, ?)";  
	    PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	    pstmt.setInt(1,userid);
	    pstmt.setInt(2,bookid);
	    pstmt.setInt(3, count);

	    pstmt.executeUpdate();


	    
	 
	  
	    // Step 7: Close connection
	    conn.close();
	    
	}
	catch (SQLException e) {
        e.printStackTrace();
	}
	
	
	
	
	return nrow;
	
	}
	}

