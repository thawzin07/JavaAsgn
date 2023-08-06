package com.myshop.bookshopws.controller;


import java.util.ArrayList;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.myshop.bookshopws.model.Book;
import com.myshop.bookshopws.model.BookDB;



@RestController

public class BookController {
	@RequestMapping(method=RequestMethod.GET, path="/ListTopSales")
	public ArrayList<Book> getTopSales() {
		ArrayList<Book> bookArray = new ArrayList<Book>();
		
		Book b = new Book();
		try {
			BookDB db = new BookDB();
			bookArray = db.listTopSales();
		} catch (Exception e) {
			System.out.print("Error : "  + e);
		}
		return bookArray;
	}
	
	@RequestMapping(method=RequestMethod.GET, path="/ListLeastSales")
	public ArrayList<Book> getLeastSales() {
		ArrayList<Book> bookArray = new ArrayList<Book>();
		
		Book b = new Book();
		try {
			BookDB db = new BookDB();
			bookArray = db.listLeastSales();
		} catch (Exception e) {
			System.out.print("Error : "  + e);
		}
		return bookArray;
	}
	
	@RequestMapping(method=RequestMethod.GET, path="/ListLowStocks")
	public ArrayList<Book> getLowStocs() {
		ArrayList<Book> bookArray = new ArrayList<Book>();
		
		Book b = new Book();
		try {
			BookDB db = new BookDB();
			bookArray = db.listLowStock();
		} catch (Exception e) {
			System.out.print("Error : "  + e);
		}
		return bookArray;
	}
	
	@RequestMapping(
			path="/createBook",
			consumes="application/json",
			method = RequestMethod.POST)
	public boolean createUser(@RequestBody Book book) {
		boolean isCreated = false ;
		try {
			BookDB db = new BookDB();
			String isbn = book.getISBN();
			System.out.print("...inside BookController...Id: " + isbn);
			String title = book.getTitle();
			System.out.print("...inside BookController...Id: " + title);
			isCreated = db.createBook(book);
			
			System.out.print("...done create user..." + isCreated);
		}catch (Exception e) {
			System.out.print("Error : "  + e.toString());
		}
		return isCreated ; //using the default ResponseBody with custom status from Spring
	}
	

	
	

}