package dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


import dbaccess.Book;

public class BookDB {
	public ArrayList<Book> listBookSales () throws SQLException {
		Book uBean = null ;
		Connection conn = null;
		ArrayList<Book> books = new ArrayList<Book>();
		
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT * FROM javaassignment.book ORDER BY sold_count DESC LIMIT 5";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			
			ResultSet rs = pstmt.executeQuery();
			
		     while (rs.next()) {
				uBean = new Book();
				uBean.setId(Integer.parseInt(rs.getString("id")));
				uBean.setISBN(rs.getString("ISBN"));
				uBean.setTitle(rs.getString("title"));
				uBean.setAuthor(rs.getString("author"));
				uBean.setPrice(Double.parseDouble(rs.getString("price")));
				uBean.setQuantity(Integer.parseInt(rs.getString("quantity")));
				uBean.setPublisher(rs.getString("publisher"));
				uBean.setPublication_date(rs.getString("publication_date"));
				
				uBean.setCat_id(Integer.parseInt(rs.getString("cat_id")));
				uBean.setImage(rs.getString("image"));
				uBean.setSold_count(Integer.parseInt(rs.getString("sold_count")));
				
				books.add(uBean);
				System.out.print("....done writing to bean!....");

			}
		} catch (Exception e) {
			System.out.print("..........UserDetailsDB:" + e);
		} finally {
			conn.close();
		}

		return books;
	}
	 public int insertBook(Book book) throws SQLException, ClassNotFoundException {
	        Connection conn = null;
	        int nrow = 0;

	       try { String sql = "INSERT INTO javaassignment.book (isbn,title,author,price,quantity,publisher,publication_date,cat_id,image) values(?,?,?,?,?,?,?,?,?)";
		    PreparedStatement pstmt = conn.prepareStatement(sql);

		    // Step 5: Set parameter values
		    pstmt.setString(1, book.getISBN());
		    pstmt.setString(2, book.getTitle());
		    pstmt.setString(3, book.getAuthor());
		    pstmt.setDouble(4, book.getPrice());
		    pstmt.setInt(5, book.getQuantity());
		    pstmt.setString(6, book.getPublisher());
		    pstmt.setString(7, book.getPublication_date());
		    pstmt.setInt(8, book.getCat_id());
		    pstmt.setString(9, book.getImage());
		    

		    // Step 6: Execute the INSERT query
		   nrow = pstmt.executeUpdate();

		    // Step 7: Close resources
		    pstmt.close();
		    conn.close();
	       
		}catch(SQLException e) {
			e.printStackTrace();
		}

	        return nrow;
	    }
}
