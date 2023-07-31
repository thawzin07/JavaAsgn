package mybooks;

public class CartItems {
	private String title;
	private int qty;
	private float price;
	private int bookid;
	private String image;
	private int count;
	public CartItems(String Title,int quantity,float Price, int bookID, String Img) {
		title=Title;
		qty=quantity;
		price=Price;
		bookid=bookID;
		image=Img;
		//count=Count;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int Count) {
		this.count = Count;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getBookid() {
		return bookid;
	}
	public void setBookid(int bookid) {
		this.bookid = bookid;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}

}
