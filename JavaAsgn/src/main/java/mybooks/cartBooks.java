package mybooks;

public class cartBooks {
<<<<<<< HEAD
    private String Title;
    private float Price;
    private String Image;
    private int qty;
=======
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
	
		
	


	public String getIsbn() {
		return isbn;
	}


	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}


	public void setTitle(String title) {
		Title = title;
	}


	public void setPrice(float price) {
		Price = price;
	}


	public void setImage(String image) {
		Image = image;
	}


	public void setQty(int qty) {
		this.qty = qty;
	}





	public String getTitle() {
		return Title;
	}





	public float getPrice() {
		return Price;
	}
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn

<<<<<<< HEAD
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
=======




	public String getImage() {
		return Image;
	}





	public int getQty() {
		return qty;
	}
}
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn
