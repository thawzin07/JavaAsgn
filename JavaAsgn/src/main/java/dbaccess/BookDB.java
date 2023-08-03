package dbaccess;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import dbaccess.Book;

public class BookDB {
	public ArrayList<Book> listTopSales() throws SQLException {
		Book uBean = null;
		Connection conn = null;
		ArrayList<Book> books = new ArrayList<Book>();

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT * FROM javaassignment.book ORDER BY sold_count DESC LIMIT 3";
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

	public ArrayList<Book> listLeastSales() throws SQLException {
		Book uBean = null;
		Connection conn = null;
		ArrayList<Book> books2 = new ArrayList<Book>();

		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT * FROM javaassignment.book ORDER BY sold_count ASC LIMIT 3";

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

				books2.add(uBean);
				System.out.print("....done writing to bean!....");

			}
		} catch (Exception e) {
			System.out.print("..........UserDetailsDB:" + e);
		} finally {
			conn.close();
		}

		return books2;
	}

	public Book bookSearchBar(String title) {

		Connection conn = null;

		Book uBean = null;
		try {

			conn = DBConnection.getConnection();

			String query = "SELECT * FROM javaassignment.book where title = ?";
			PreparedStatement statement = conn.prepareStatement(query);
			statement.setString(1, title);

			// Execute the query
			ResultSet rs = statement.executeQuery();
			// Retrieve the count of matching records
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
			}

		} catch (Exception e) {
			System.out.print("..........UserDetailsDB:" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return uBean;
	}

	public boolean createBook(Book book) {

		Connection conn = null;
		boolean isSuccess = false;

		try {
			conn = DBConnection.getConnection();

			String query = "SELECT COUNT(*) FROM javaassignment.book WHERE ISBN = ? OR title = ?";
			PreparedStatement statement = conn.prepareStatement(query);
			statement.setString(1, book.getISBN());
			statement.setString(2, book.getTitle());

			// Execute the query
			ResultSet resultSet = statement.executeQuery();
			// Retrieve the count of matching records
			int count = 0;
			if (resultSet.next()) {
				count = resultSet.getInt(1);
			}

			// Check the count and take appropriate action
			if (count > 0) {
				// A record with the same ISBN and title already exists
				// Perform any necessary error handling or return false to indicate failure
				return false;
			} else {
				String sql = "INSERT INTO javaassignment.book (isbn, title, author, price, quantity, publisher, publication_date, cat_id, image) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);

				// Set parameter values
				pstmt.setString(1, book.getISBN());
				pstmt.setString(2, book.getTitle());
				pstmt.setString(3, book.getAuthor());
				pstmt.setDouble(4, book.getPrice());
				pstmt.setInt(5, book.getQuantity());
				pstmt.setString(6, book.getPublisher());
				pstmt.setString(7, book.getPublication_date());
				pstmt.setInt(8, book.getCat_id());
				pstmt.setString(9, book.getImage());
				// Execute the INSERT query
				int rowsAffected = pstmt.executeUpdate();
				// Close resources
				pstmt.close();
				if (rowsAffected > 0) {
					// Book inserted successfully
					isSuccess = true;
				}
			}
		} catch (Exception e) {
			System.out.print("..........UserDetailsDB:" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return isSuccess;
	}

	public boolean updateBook(Book book) {

		Connection conn = null;
		boolean isUpdated = false;

		try {
			conn = DBConnection.getConnection();

			String sql = "UPDATE javaassignment.book SET ISBN=?, title=?, author=?, price=?, quantity=?, publisher=?, publication_date=?, cat_id=?, image=? WHERE id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			// Set parameter values
			pstmt.setString(1, book.getISBN());
			pstmt.setString(2, book.getTitle());
			pstmt.setString(3, book.getAuthor());
			pstmt.setDouble(4, book.getPrice());
			pstmt.setInt(5, book.getQuantity());
			pstmt.setString(6, book.getPublisher());
			pstmt.setString(7, book.getPublication_date());
			pstmt.setInt(8, book.getCat_id());
			pstmt.setString(9, book.getImage());
			pstmt.setInt(10, book.getId());
			// Execute the INSERT query
			int rowsAffected = pstmt.executeUpdate();
			// Close resources
			pstmt.close();
			if (rowsAffected > 0) {
				// Book inserted successfully
				isUpdated = true;
			}

		} catch (Exception e) {
			System.out.print("..........UserDetailsDB:" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return isUpdated;
	}

	public boolean deleteBook(String id) {

		Connection conn = null;
		boolean isDeleted = false;

		try {
			conn = DBConnection.getConnection();

			String sqlStr = "DELETE FROM javaassignment.book WHERE id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			// set parameter value
			pstmt.setString(1, id);

			// Execute the INSERT query
			int rowsAffected = pstmt.executeUpdate();
			// Close resources
			pstmt.close();
			if (rowsAffected > 0) {
				// Book inserted successfully
				isDeleted = true;
			}

		} catch (Exception e) {
			System.out.print("..........UserDetailsDB:" + e);
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

	/**
	 * Author : Thet Htar San Date : 30/07/2023 Copyright Notice : NA
	 * 
	 * @(#) Description : JavaAsgn Admission no : P2235077 Class : DIT/FT/2A/03
	 **/
	public int insertBook(Book book) throws SQLException, ClassNotFoundException {
		Connection conn = null;
		int nrow = 0;

		try {
			String sql = "INSERT INTO javaassignment.book (isbn,title,author,price,quantity,publisher,publication_date,cat_id,image) values(?,?,?,?,?,?,?,?,?)";
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

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return nrow;
	}
}
