package com.myshop.bookshopws.controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("users")

public class UserController {
	public String getUser() {
		return "getUser() was being called!";
	}

}
