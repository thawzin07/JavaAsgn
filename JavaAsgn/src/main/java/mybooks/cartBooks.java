package mybooks;

public class cartBooks {
	private String Title;
	private float Price;
	private String Image;
	private int qty;
	
	public  cartBooks(String title,float price,int quantity, String image) {
		Title=title;
		Price=price;
		Image=image;
		qty=quantity;
		
		
				
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
}
