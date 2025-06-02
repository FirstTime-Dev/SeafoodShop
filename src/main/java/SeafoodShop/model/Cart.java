package SeafoodShop.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Cart {
    int cartId;
    int userId;
    int productId;
    int quantity;
    Date addAt;
    String productName;
    BigDecimal productPrice;
    String productImageURL;
    public Cart(int cartId, int userId, int productId, int quantity, Date addAt,String productName,BigDecimal productPrice,String productImageURL) {
        this.cartId = cartId;
        this.userId = userId;
        this.productId = productId;
        this.quantity = quantity;
        this.addAt = addAt;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImageURL = productImageURL;
    }

    public Cart() {}

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getAddAt() {
        return addAt;
    }

    public void setAddAt(Date addAt) {
        this.addAt = addAt;
    }

    public String getProductName() {return productName;}

    public void setProductName(String productName) {this.productName = productName;}

    public BigDecimal getProductPrice() {return productPrice;}

    public void setProductPrice(BigDecimal productPrice) {this.productPrice = productPrice;}

    public String getProductImageURL() {return productImageURL;}

    public void setProductImageURL(String productImageURL) {this.productImageURL = productImageURL;}
}
