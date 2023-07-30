package dbaccess;
import java.sql.*;
import java.util.ArrayList;

public class UserDAO {
	public User getUserDetails(String userid) throws SQLException{
		User uBean=null;
		Connection conn=null;
		try {
			conn = DBConnection.getConnection();
			String sqlStr="SELECT * FROM user WHERE id=?";
			PreparedStatement pstmt=conn.prepareStatement(sqlStr);
			pstmt.setString(1, userid);
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
		            uBean = new User();
		            uBean.setUsername(rs.getString("userid"));
		            uBean.setAge(rs.getInt("age"));
		            uBean.setGender(rs.getString("gender"));
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
	
	
	public int insertUser( String userid, int age, String gender) throws SQLException, ClassNotFoundException{
		Connection conn=null;
		int nrow=0;
		//int generatedId=0;
		try {
			conn= DBConnection.getConnection();
			String sqlStr="INSERT INTO user_details (userid,age,gender) VALUES (?,?,?)";
			PreparedStatement pstmt=conn.prepareStatement(sqlStr);
			
			pstmt.setString(1, userid);
			pstmt.setInt(2, age);
			pstmt.setString(3, gender);
			nrow=pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return nrow;
	}
	
	public int updateUser(String userid, User user) throws SQLException,ClassNotFoundException{
		Connection conn=null;
		int nrow=0;
		try {
			conn= DBConnection.getConnection();
			
			String sqlStr="SELECT * FROM user_details WHERE userid=?";
			PreparedStatement pstmt=conn.prepareStatement(sqlStr);
			
			pstmt.setString(1, userid);
			
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				sqlStr="Update user_details SET gender=?, age=? WHERE userid=?";
				pstmt= conn.prepareStatement(sqlStr);
				pstmt.setString(1, user.getGender());
				pstmt.setInt(2, user.getAge());
				pstmt.setString(3, user.getUserid());
				nrow=pstmt.executeUpdate();
				System.out.print("done updating user!....");
				
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.print(".....UserDAO:"+e);
		}
		
		return nrow;
	}
	public int deleteUser(String userid) throws SQLException, ClassNotFoundException {

	    Connection conn = null;
	    int nrow = 0;
	    
	    try {
	        conn = DBConnection.getConnection();
	        String sqlStr = "DELETE FROM user_details WHERE userid=?";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	        pstmt.setString(1, userid);
	        
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
