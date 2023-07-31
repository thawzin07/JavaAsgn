package dbaccess;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;

/**Author             : Thet Htar San
Date                 : 30/07/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
**/
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

