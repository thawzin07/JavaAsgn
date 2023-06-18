package servlets;

public class Books {
	
	private String Title;
	private float Price;
	private String Image;
	
	public  Book(String title,float price, String image) {
		Title=title;
		Price=price;
		Image=image;
		
				
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
	
	
}
