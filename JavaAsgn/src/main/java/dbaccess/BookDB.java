package dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mybooks.Book;

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
			
			if (rs.next()) {
				uBean = new Book();
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
}
