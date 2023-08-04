package dbaccess;

public class PurchaseData {
	private int bookid;
	private String bookname;
	private String username;
	private int count;
	private String datePurchased;

	public PurchaseData(int bookId,String bookName,String userName,int Count,String datepurchased) {
		bookid=bookId;
		bookname=bookName;
		username=userName;
		count=Count;
		datePurchased=datepurchased;
	}
	
	public int getBookid() {
		return bookid;
	}
	public void setBookid(int bookid) {
		this.bookid = bookid;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getDatePurchased() {
		return datePurchased;
	}
	public void setDatePurchased(String datePurchased) {
		this.datePurchased = datePurchased;
	}
}
