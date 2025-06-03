package SeafoodShop.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Product {
    int productID;
    String name;
    int categoryID;
    BigDecimal price;
    int stockQuantity;
    String supplierID;
    String description;
    String origin;
    String storageCondition;
    Date expiryDate;
    BigDecimal weight;
    int state;
    String imgUrl;
    public Product(){}
    public Product(String description, int productID, String name, int categoryID, BigDecimal price, int stockQuantity, String supplierID, String origin, String storageCondition, Date expiryDate, BigDecimal weight, int state, String imgUrl) {
        this.description = description;
        this.productID = productID;
        this.name = name;
        this.categoryID = categoryID;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.supplierID = supplierID;
        this.origin = origin;
        this.storageCondition = storageCondition;
        this.expiryDate = expiryDate;
        this.weight = weight;
        this.state = state;
        this.imgUrl = imgUrl;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public void setSupplierID(String supplierID) {
        this.supplierID = supplierID;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public void setStorageCondition(String storageCondition) {
        this.storageCondition = storageCondition;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getProductID() {
        return productID;
    }

    public String getName() {
        return name;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public String getSupplierID() {
        return supplierID;
    }

    public String getDescription() {
        return description;
    }

    public String getOrigin() {
        return origin;
    }

    public String getStorageCondition() {
        return storageCondition;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public BigDecimal getWeight() {
        return weight;
    }

    public int getState() {
        return state;
    }

    public String getImgUrl() {return imgUrl;}

    public void setImgUrl(String imgUrl) {this.imgUrl = imgUrl;}

    @Override
    public String toString() {
        return "Product{" +
                "productID=" + productID +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", stockQuantity=" + stockQuantity +
                '}';
    }
}

