package dbaccess;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import dbaccess.*;

public class UserDB {
	public ArrayList<User> getAllUsers() throws SQLException{
		User uBean = null;
		Connection conn = null;
		ArrayList<User> userArray = new ArrayList<User>();

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT * FROM javaassignment.user" ;

			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				uBean = new User();
				uBean.setUserid(Integer.parseInt(rs.getString("id")));
				uBean.setUsername(rs.getString("username"));
				uBean.setRole(rs.getString("role"));
				uBean.setPhone(rs.getString("phone"));
				uBean.setEmail(rs.getString("email"));
				uBean.setJoinedDate(rs.getString("joinedDate"));
				uBean.setAddressid(Integer.parseInt(rs.getString("address_id")));
				uBean.setTotalSpent(Float.parseFloat(rs.getString("total_spend")));
				uBean.setLast_update(rs.getTimestamp("last_updated").toString());
				uBean.setImage(rs.getString("image"));
				

				userArray.add(uBean);
				System.out.print("....done writing to bean!....");

			}
		} catch (Exception e) {
			System.out.print("..........BookDetailsDB:" + e);
		} finally {
			conn.close();
		}

		return userArray;
	}
	
	public boolean updateUser(String username , String phone , String email ,  String role , String joinedDate , String id ) throws SQLException{
		
		
		boolean isUpdated = false ;
		Connection conn = null;
		try {
			
			
			conn = DBConnection.getConnection();
			String sqlStr = "UPDATE javaassignment.user SET username=? , phone=?, email=?, role=?,  joinedDate = ? where id=?" ;

			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			pstmt.setString(1, username);
			pstmt.setString(2, phone);
			pstmt.setString(3, email);
			pstmt.setString(4, role);
			pstmt.setString(5, joinedDate);
			pstmt.setString(6, id);
			
			int count  = pstmt.executeUpdate();
			if (count > 0 ) {
				isUpdated = true ;
			}

			
		} catch (Exception e) {
			System.out.print("..........BookDetailsDB:" + e);
		} finally {
			conn.close();
		}

		return isUpdated;
	}
	
	public boolean deleteUser(String id) {

		Connection conn = null;
		boolean isDeleted = false;

		try {
			conn = DBConnection.getConnection();

			String sqlStr = "DELETE FROM javaassignment.user WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			// set parameter value
			pstmt.setString(1, id);

			// Execute the INSERT query
			int rowsAffected = pstmt.executeUpdate();
			// Close resources
			pstmt.close();
			
			
			String sqlStr2 = "DELETE FROM javaassignment.cart WHERE user_id = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(sqlStr2);
			
			pstmt.setString(1, id);
			
			int rowsAffected2 = pstmt.executeUpdate();
			
			if (rowsAffected > 0 || rowsAffected2 > 0) {
				// Book inserted successfully
				isDeleted = true;
			}

		} catch (Exception e) {
			System.out.print("..........BookDetailsDB:" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return isDeleted;
	}
}
