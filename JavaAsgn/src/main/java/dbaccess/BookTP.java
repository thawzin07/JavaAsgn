package dbaccess;

public class BookTP {
	private String ISBN;
	private String Title;
	private String Author;
	private String Publisher;
	private int Quantity;
	private double Price;
	private String publication_date ;
	private int cat_id ;
	private String image ;
	private int sold_count;
	private int ID ;
	
	
	public BookTP(String isbn, String title, String author, String publisher,int quantity,double price, String pubdate ,int catid, String img, int soldcount) {
		ISBN=isbn;
		Title=title;
		Author=author;
		Publisher=publisher;
		Quantity=quantity;
		Price=price;
		publication_date=pubdate;
		cat_id=catid;
		image=img;
		sold_count=soldcount;
	}
	public BookTP() {
		
	}
	
	
	
     
	
	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	


	public int getId() {
		return ID;
	}
	public void setId(int id) {
		this.ID = id;
	}
	public String getPublication_date() {
		return publication_date;
	}
	public void setPublication_date(String publication_date) {
		this.publication_date = publication_date;
	}
	public int getCat_id() {
		return cat_id;
	}
	public void setCat_id(int cat_id) {
		this.cat_id = cat_id;
	}
	public String getImage() {
		// Assuming the image file name is stored in the "image" field of the Book object
	    String imageName = this.image;

	    // Construct the relative path to the "Graphics" folder
	    String imagePath = "../Graphics/" + imageName;

	    return imagePath;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getSold_count() {
		return sold_count;
	}
	public void setSold_count(int sold_count) {
		this.sold_count = sold_count;
	}
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getAuthor() {
		return Author;
	}
	public void setAuthor(String author) {
		Author = author;
	}
	public String getPublisher() {
		return Publisher;
	}
	public void setPublisher(String publisher) {
		Publisher = publisher;
	}
	public int getQuantity() {
		return Quantity;
	}
	public void setQuantity(int quantity) {
		Quantity = quantity;
	}
	public double getPrice() {
		return Price;
	}
	public void setPrice(double price) {
		Price = price;
	}
}
