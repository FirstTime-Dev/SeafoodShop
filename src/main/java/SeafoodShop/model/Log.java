package SeafoodShop.model;

import java.sql.Timestamp;

public class Log {
    private java.sql.Timestamp timestamp;
    private int userID;
    private String action;
    private String resource;
    private String levels;
    private String before;
    private String after;
    private String location;
    private String ip;

    public Log() {
    }

    public Log(int userID, String action, String resource, String levels, String before, String after, String location, String ip) {
        this.userID = userID;
        this.action = action;
        this.resource = resource;
        this.levels = levels;
        this.before = before;
        this.after = after;
        this.location = location;
        this.ip = ip;
    }

    public java.sql.Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getLevels() {
        return levels;
    }

    public void setLevels(String levels) {
        this.levels = levels;
    }

    public String getBefore() {
        return before;
    }

    public void setBefore(String before) {
        this.before = before;
    }

    public String getAfter() {
        return after;
    }

    public void setAfter(String after) {
        this.after = after;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

}
