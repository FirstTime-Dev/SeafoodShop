package SeafoodShop.model;

import java.sql.Date;

public class OrderDetail {
    private int orderID;
    private String productName;
    private int quantity;
    private double price;
    private double total;
    private String fullName;
    private String phoneNumber;
    private String email;
    private String address;
    private Date orderDate;
    private int status; // 1: Pending, 2: Completed, 3: Cancelled

    public OrderDetail() {}

    public OrderDetail(int orderID, String productName, int quantity, double price, double total,
                       String fullName, String phoneNumber, String email, String address, int status, Date orderDate) {
        this.orderID = orderID;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
        this.total = total;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.orderDate = orderDate;
        this.status = status;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getOrderDate() {
        return orderDate;
    }

}
