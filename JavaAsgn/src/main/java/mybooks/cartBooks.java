package mybooks;

public class cartBooks {
	private String Title;
	private float Price;
	private String Image;
	private int qty;
	private String isbn;
	
	public  cartBooks(String title,float price,int quantity, String image, String ISBN) {
		Title=title;
		Price=price;
		Image=image;
		qty=quantity;
		isbn=ISBN;
		
		
				
	}
	
		
	public String getTitle() {
		return Title;
	}
	
	
	public float getPrice() {
		return Price;
	}

	public String getImage() {
		return Image;
	}
	
	public int getQty() {
		return qty;
	}
	public String getISBN() {
		return isbn;
	}
}
