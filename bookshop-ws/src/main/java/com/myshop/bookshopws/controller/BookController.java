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
	@RequestMapping(method=RequestMethod.GET, path="/ListBookSales")
	public ArrayList<Book> getUser() {
		ArrayList<Book> bookArray = new ArrayList<Book>();
		Book b = new Book();
		try {
			BookDB db = new BookDB();
			bookArray = db.listBookSales();
		} catch (Exception e) {
			System.out.print("Error : "  + e);
		}
		return bookArray;
	}

}