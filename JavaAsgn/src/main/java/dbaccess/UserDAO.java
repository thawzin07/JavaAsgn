package dbaccess;
import java.sql.*;
import java.util.ArrayList;

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
	
	
	public int insertUser( String username, String email, String phone, String password, String role, String image, String dateJoined) throws SQLException, ClassNotFoundException{
		Connection conn=null;
		
		int nrow=0;
		//int generatedId=0;
		try {
			conn= DBConnection.getConnection();
			 String sqlStr = "INSERT INTO user (username, email, phone, password,role,image,joinedDate) VALUES (?,?, ?, ?, ?,?,?)";
			    PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			    // Step 5: Set parameter values
			    pstmt.setString(1, username);
			    pstmt.setString(2, email);
			    pstmt.setString(3, phone);
			    pstmt.setString(4, password);
			    pstmt.setString(5, role);
			    pstmt.setString(6, image);
			    pstmt.setString(7, dateJoined);

			    // Step 6: Execute the INSERT query
			    int rowsAffected = pstmt.executeUpdate();

			    // Step 7: Close resources
			    pstmt.close();
			    conn.close();

			 
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return nrow;
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
