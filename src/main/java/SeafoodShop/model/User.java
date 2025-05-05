package SeafoodShop.model;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
    private int userID;
    private String fullName;
    private String username;
    private String password;
    private String email;
    private String phone;
    private Date birthday;
    private String address;
    private int role;// 1. User - 2. Manage - 3. Admin
    private int ban;// 1. Ban - 0. Unban
    private int state;// 1. Active - 0. Delete
    private Timestamp editCreatedAt;

    public User() {
    }

    public User(int userID, String address, Date birthday, String phone, String email, String password, String username, String fullName) {
        this.userID = userID;
        this.address = address;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.username = username;
        this.fullName = fullName;
    }

    public int getBan() {
        return ban;
    }

    public void setBan(int ban) {
        this.ban = ban;
    }

    public Timestamp getEditCreatedAt() {
        return editCreatedAt;
    }

    public void setEditCreatedAt(Timestamp createDate) {
        this.editCreatedAt = createDate;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getBirthday() {
        return birthday;
    }

    public String getBirthdayFormatted() {
        if (birthday != null) {
            return new java.text.SimpleDateFormat("yyyy-MM-dd").format(birthday);
        }
        return null;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }
}
