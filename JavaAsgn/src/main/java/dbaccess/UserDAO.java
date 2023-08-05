package dbaccess;
import java.sql.*;
import java.util.ArrayList;


/**Author             : Thet Htar San
Date                 : 30/07/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
**/


public class UserDAO {
	public User getUserDetails(int userid) throws SQLException{
		User uBean=null;
		Connection conn=null;
		try {
			conn = DBConnection.getConnection();
			String sqlStr="SELECT * FROM user WHERE id=?";
			PreparedStatement pstmt=conn.prepareStatement(sqlStr);
			pstmt.setInt(1, userid);
			ResultSet rs= pstmt.executeQuery();
			if(rs.next()) {
				uBean= new User();
				uBean.setUsername(rs.getString("username"));
				uBean.setPhone(rs.getString("phone"));
				uBean.setEmail(rs.getString("email"));
				uBean.setPassword(rs.getString("password"));
				uBean.setUserid(rs.getInt("id"));
				uBean.setImage(rs.getString("image"));
				uBean.setRole(rs.getString("role"));
				System.out.print("....done writing to bean!....");
				
			}
		}
			catch(Exception e) {
				System.out.print("..........UserDetailsDB:"+e);
			} 
		finally {
			conn.close();
		}
		return uBean;
		}
	
	public ArrayList<User> listAllUsers() throws SQLException{
		ArrayList<User> userList=new ArrayList<User>();
		User uBean=null;
		Connection conn=null;
		try {
			conn = DBConnection.getConnection();
			 String sqlStr = "SELECT * FROM user_details";
		        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		        ResultSet rs = pstmt.executeQuery();
		        while (rs.next()) {
		        	uBean.setUsername(rs.getString("username"));
					uBean.setPhone(rs.getString("phone"));
					uBean.setEmail(rs.getString("email"));
					uBean.setPassword(rs.getString("password"));
					uBean.setUserid(rs.getInt("id"));
					uBean.setImage(rs.getString("image"));
					uBean.setRole(rs.getString("role"));
		            userList.add(uBean);
		        }
		}
			catch(Exception e) {
				System.out.print("..........UserDetailsDB:"+e);
			} 
		finally {
			conn.close();
		}
		
		
		return userList;
	}
	
	public boolean checkDuplicateUser(String username, String phone, String email)
            throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();

            // Create a prepared statement to check for existing records
            String query = "SELECT COUNT(*) FROM user WHERE username = ? OR phone = ? OR email = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, phone);
            stmt.setString(3, email);

            // Execute the query
            rs = stmt.executeQuery();

            // Retrieve the count of matching records
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }

            return count > 0;
        } finally {
            // Close resources
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }
	
	  public int insertUser(String username, String email, String phone, String password, String role, String image, String dateJoined, int addressid) throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        int nrow = 0;
	        float totalspend=0;

	        try {
	            conn = DBConnection.getConnection();
	            String sqlStr = "INSERT INTO user (username, email, phone, password, role, image, joinedDate,total_spend,address_id) VALUES (?, ?, ?, ?, ?, ?, ?,?,?)";
	            PreparedStatement pstmt = conn.prepareStatement(sqlStr);

	            // Set parameter values
	            pstmt.setString(1, username);
	            pstmt.setString(2, email);
	            pstmt.setString(3, phone);
	            pstmt.setString(4, password);
	            pstmt.setString(5, role);
	            pstmt.setString(6, image);
	            pstmt.setString(7, dateJoined);
	            pstmt.setFloat(8, totalspend);
	            pstmt.setInt(9, addressid);
	            // Execute the INSERT query
	            nrow = pstmt.executeUpdate();

	            // Close resources
	            pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            // Close the connection in the finally block to ensure proper cleanup
	            if (conn != null) {
	                conn.close();
	            }
	        }

	        return nrow;
	    }
	  
	  public int insertAddress(String address, String postal) throws SQLException, ClassNotFoundException {
		    Connection conn = null;
		    int addressId = 0;

		    try {
		        conn = DBConnection.getConnection();
		        String sqlStr = "INSERT INTO address (residential, postal) VALUES (?, ?)";
		        PreparedStatement pstmt = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);

		        // Set parameter values
		        pstmt.setString(1, address);
		        pstmt.setString(2, postal);

		        // Execute the INSERT query
		        int rowsAffected = pstmt.executeUpdate();

		        if (rowsAffected > 0) {
		            // Retrieve the auto-generated key (addressId)
		            ResultSet generatedKeys = pstmt.getGeneratedKeys();
		            if (generatedKeys.next()) {
		                addressId = generatedKeys.getInt(1);
		            }
		        }

		        // Close resources
		        pstmt.close();
		    } finally {
		        // Close the connection in the finally block to ensure proper cleanup
		        if (conn != null) {
		            conn.close();
		        }
		    }

		    return addressId;
		}
	public int updateUser( int userid, User user) throws SQLException,ClassNotFoundException{
		Connection conn=null;
		int nrow=0;
		try {
			conn= DBConnection.getConnection();
			
			String sqlStr="SELECT * FROM user WHERE id=?";
			PreparedStatement pstmt=conn.prepareStatement(sqlStr);
			
			pstmt.setInt(1, userid);
			
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				sqlStr="Update user SET username=?, email=?,phone=?, password=?, image=? WHERE id=?";
				pstmt= conn.prepareStatement(sqlStr);
				pstmt.setString(1, user.getUsername());
				pstmt.setString(2, user.getEmail());
				pstmt.setString(3, user.getPhone());
				pstmt.setString(4, user.getPassword());
				pstmt.setString(5, user.getImage());
				pstmt.setInt(6, userid);
				nrow=pstmt.executeUpdate();
				System.out.print("done updating user!....");
				
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.print(".....UserDAO:"+e);
		}
		
		return nrow;
	}
	public int deleteUser(int userId) throws SQLException, ClassNotFoundException {
	    Connection conn = null;
	    int nrow = 0;

	    try {
	        conn = DBConnection.getConnection();

	        // Step 1: Delete rows from the cart table for the given user_id
	        String cartDeleteQuery = "DELETE FROM cart WHERE user_id=?";
	        PreparedStatement cartStmt = conn.prepareStatement(cartDeleteQuery);
	        cartStmt.setInt(1, userId);
	        int deletedCartRows = cartStmt.executeUpdate();
	        cartStmt.close();

	        // Step 2: Delete rows from the purchase table for the given user_id
	        String purchaseDeleteQuery = "DELETE FROM purchase WHERE user_id=?";
	        PreparedStatement purchaseStmt = conn.prepareStatement(purchaseDeleteQuery);
	        purchaseStmt.setInt(1, userId);
	        int deletedPurchaseRows = purchaseStmt.executeUpdate();
	        purchaseStmt.close();

	        // Step 3: Get the address_id from the user table for the given user_id
	        int addressId = 0;
	        String addressIdQuery = "SELECT address_id FROM user WHERE id=?";
	        PreparedStatement addressIdStmt = conn.prepareStatement(addressIdQuery);
	        addressIdStmt.setInt(1, userId);
	        ResultSet addressIdResultSet = addressIdStmt.executeQuery();
	        if (addressIdResultSet.next()) {
	            addressId = addressIdResultSet.getInt("address_id");
	        }
	        addressIdResultSet.close();
	        addressIdStmt.close();

	        // Step 4: Delete rows from the address table for the obtained address_id
	        if (addressId > 0) {
	            String addressDeleteQuery = "DELETE FROM address WHERE id=?";
	            PreparedStatement addressStmt = conn.prepareStatement(addressDeleteQuery);
	            addressStmt.setInt(1, addressId);
	            int deletedAddressRows = addressStmt.executeUpdate();
	            addressStmt.close();
	        }

	        // Step 5: Delete the user from the user table
	        String userDeleteQuery = "DELETE FROM user WHERE id=?";
	        PreparedStatement userStmt = conn.prepareStatement(userDeleteQuery);
	        userStmt.setInt(1, userId);
	        nrow = userStmt.executeUpdate();
	        userStmt.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println(".....deleteUser: " + e);
	    } finally {
	        if (conn != null) {
	            conn.close();
	        }
	    }

	    return nrow;
	}
	
	public static void getAddress(int userid)throws SQLException,ClassNotFoundException{
	
	
    Connection conn = null;
    try {
        conn = DBConnection.getConnection();
        String sqlStr = "SELECT a.* FROM user u " +
                        "JOIN address a ON u.address_id = a.id " +
                        "WHERE u.id = ?";
        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
        pstmt.setInt(1, userid);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
           
            String address=rs.getString("address");
            String postal=rs.getString("postal");
        }
    } catch (Exception e) {
        System.out.print("..........AddressDetailsDB:" + e);
    } finally {
        conn.close();
    }
   
	
	}
}
