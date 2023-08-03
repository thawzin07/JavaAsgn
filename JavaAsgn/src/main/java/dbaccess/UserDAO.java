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
	public int deleteUser(int userid) throws SQLException, ClassNotFoundException {

	    Connection conn = null;
	    int nrow = 0;
	    
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "DELETE FROM user WHERE id=?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        pstmt.setInt(1, userid);
	        
	        nrow = pstmt.executeUpdate();
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
}
