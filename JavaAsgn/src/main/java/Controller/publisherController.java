package Controller;
import java.sql.SQLException;

import dbaccess.Book;
import dbaccess.BookDB;

public class publisherController {
	private BookDB bookdb; // You should initialize this with the appropriate instance of BookDAO

    public publisherController(BookDB bookdb) {
        this.bookdb = bookdb;
    }

    public void addBook(String isbn, String Title, String Author, String Publisher,int Quantity,double Price, String publication_date ,int cat_id, String image,int sold_count ) throws ClassNotFoundException, SQLException {
       

        // Create a new Book object
        Book newBook = new Book(isbn, Title, Author, Publisher, Quantity, Price, publication_date, cat_id, image,sold_count);

        // Call the BookDAO to add the book to the database
        int nrow = bookdb.insertBook(newBook);

        if (nrow>0) {
            System.out.println("Book added successfully!");
        } else {
            System.out.println("Failed to add the book.");
        }
    }
}
