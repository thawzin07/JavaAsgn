package mybooks;

public class cartBooks {
    private String Title;
    private float Price;
    private String Image;
    private int qty;
    private String isbn;
    private int id;
    
    public  cartBooks(int bookid, String title,float price,int quantity, String image, String ISBN) {
        Title=title;
        Price=price;
        Image=image;
        qty=quantity;
        isbn=ISBN;
        id=bookid;
        
        
                
    }
    
        public int getBookId() {
        	return id;
   
        }
        public void setid(int bookid) {
            this.id = bookid;
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





    public String getImage() {
        return Image;
    }





    public int getQty() {
        return qty;
    }
}