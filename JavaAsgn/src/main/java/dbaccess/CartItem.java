package dbaccess;

public class CartItem {
private int id;
private int userid;
private int bookid;
private int count;

public CartItem(int userID, int bookID, int Count) {
	userid=userID;
	bookid=bookID;
	count=Count;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public int getUserid() {
	return userid;
}
public void setUserid(int userid) {
	this.userid = userid;
}
public int getBookid() {
	return bookid;
}
public void setBookid(int bookid) {
	this.bookid = bookid;
}
public int getCount() {
	return count;
}
public void setCount(int count) {
	this.count = count;
}
}
