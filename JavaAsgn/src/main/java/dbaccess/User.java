package dbaccess;
/**Author             : Thet Htar San
Date                 : 30/07/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
**/

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class User {
	private String username;
	private String role;
	private String phone;
	private String email;
	private String image;
	private String password;
	private int userid;
	private float totalspent;
	public String getLast_update() {
		return last_update;
	}
	public void setLast_update(String last_update) {
		this.last_update = last_update;
	}
	
	public User(String username , String phone , String email , String role , int userid ) {
		this.userid = userid ;
		this.phone = phone ;
		this.email = email ;
	    this.role = role ;
	    this.username = username ;
	}
	
	public User() {
		// TODO Auto-generated constructor stub
	}

	private int addressid;
	private String joinedDate ;
	private String last_update ;
	
	
	public float getTotalspent() {
		return totalspent;
	}
	public void setTotalspent(float totalspent) {
		this.totalspent = totalspent;
	}
	public String getJoinedDate() {
		return joinedDate;
	}
	public void setJoinedDate(String joinedDate) {
		this.joinedDate = joinedDate;
	}
	public int getAddressid() {
		return addressid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getAddressId() {
		return addressid;
	}
	public void setAddressid(int addressid) {
		this.addressid = addressid;
	}
	public float getTotalSpent() {
		return totalspent;
	}
	public void setTotalSpent(float totalspent) {
		this.totalspent=totalspent;
	}

	

	

}
