package dbaccess;

public class PurchaseData {
	private int bookid;
	private String bookname;
	private String username;
	private int count;
	private String datePurchased;
	private float total;

	public PurchaseData(int bookId,String bookName,String userName,int Count,String datepurchased,float Total) {
		bookid=bookId;
		bookname=bookName;
		username=userName;
		count=Count;
		datePurchased=datepurchased;
		total=Total;
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

	public float getTotal() {
		return total;
	}

	public void setTotal(float total) {
		this.total = total;
	}
}
