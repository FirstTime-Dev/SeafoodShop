CREATE DATABASE SeafoodProject;
USE SeafoodProject;

GO
-- B?ng user: l?u th?ng tin user - quy?n c?a user - tr?ng th?i user --
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    BirthDate DATE NOT NULL,
    Address NVARCHAR(255),
    Role INT CHECK (Role BETWEEN 1 AND 3) DEFAULT 1, -- 1: User, 2: Low Admin, 3: High Admin
    State INT DEFAULT 1, -- 1: Active, 0: Disabled
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- B?ng ph?n lo?i: l?u gi?u c?c lo?i s?n ph?m - m? t?
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255),
    State INT DEFAULT 1
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100),
    Phone NVARCHAR(15) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Address NVARCHAR(255),
    State INT DEFAULT 1
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    SupplierID INT,
    Description NVARCHAR(MAX),  -- M? t? chi ti?t v? s?n ph?m
    Origin NVARCHAR(100),  -- Xu?t x? (VD: Vi?t Nam, Nh?t B?n)
    StorageCondition NVARCHAR(255),  -- ?i?u ki?n b?o qu?n (VD: -18?C, ??ng g?i ch?n kh?ng)
    ExpiryDate DATE,  -- Ng?y h?t h?n
    Weight DECIMAL(10,2) CHECK (Weight > 0),  -- Tr?ng l??ng trung b?nh (kg)
    State INT DEFAULT 1,  -- 1: Hi?n th?, 0: ?n n?u kh?ng c?n b?n
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- B?ng H?nh ?nh S?n Ph?m (Images)
CREATE TABLE Images (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    ImageURL NVARCHAR(255) NOT NULL,
    UploadedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) DEFAULT 0,
    Status NVARCHAR(50) DEFAULT 'Pending',
    ShippingStatus NVARCHAR(50) DEFAULT 'Not Shipped',
    State INT DEFAULT 1,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Total AS (Quantity * Price) PERSISTED,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    AddedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL, -- "Credit Card", "Bank Transfer", "COD"
    PaymentType NVARCHAR(50) NOT NULL DEFAULT 'Offline', -- Online / Offline
    PaymentStatus NVARCHAR(50) DEFAULT 'Pending',
    PaymentDate DATETIME DEFAULT GETDATE(),
    AmountPaid DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    Carrier NVARCHAR(100) NOT NULL, -- T?n ??n v? v?n chuy?n
    TrackingNumber NVARCHAR(50),
    EstimatedDelivery DATE,
    DeliveryStatus NVARCHAR(50) DEFAULT 'Processing',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Contact (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    StoreName NVARCHAR(100) NOT NULL,  -- T?n c?a h?ng
    Phone NVARCHAR(15) UNIQUE NOT NULL,  -- S? ?i?n tho?i hotline
    Email NVARCHAR(100) UNIQUE NOT NULL,  -- Email h? tr? kh?ch h?ng
    Address NVARCHAR(255) NOT NULL,  -- ??a ch? c?a h?ng ch?nh
    WorkingHours NVARCHAR(100),  -- Gi? l?m vi?c (VD: "8:00 - 22:00")
    Facebook NVARCHAR(255),  -- Link Facebook c?a h?ng
    Zalo NVARCHAR(50),  -- S? Zalo li?n h?
    Instagram NVARCHAR(255),  -- Link Instagram c?a h?ng
    Note NVARCHAR(255),  -- Ghi ch? th?m (n?u c?)
    State INT DEFAULT 1  -- 1: Ho?t ??ng, 0: V? hi?u h?a
);


CREATE TABLE LogActivity (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NULL, -- NULL n?u l? h? th?ng t? ??ng log
    Action NVARCHAR(255) NOT NULL,
    Resource NVARCHAR(100) NOT NULL, -- T?n b?ng ho?c API b? t?c ??ng
    DataBefore NVARCHAR(MAX) NULL, -- D? li?u tr??c thay ??i (JSON)
    DataAfter NVARCHAR(MAX) NULL, -- D? li?u sau thay ??i (JSON)
    IPAddress NVARCHAR(50) NULL,
    Timestamp DATETIME DEFAULT GETDATE(),
    Location NVARCHAR(255) NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
);

CREATE TABLE PasswordResets (
    ResetID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Token NVARCHAR(255) UNIQUE NOT NULL,
    ExpiryTime DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,  -- Ng??i ??nh gi?
    ProductID INT NOT NULL,  -- S?n ph?m ???c ??nh gi?
    Rating INT CHECK (Rating BETWEEN 1 AND 5),  -- ??nh gi? t? 1 ??n 5 sao
    Comment NVARCHAR(1000),  -- N?i dung b?nh lu?n
    ReviewDate DATETIME DEFAULT GETDATE(),  -- Th?i gian ??nh gi?
    State INT DEFAULT 1,  -- 1: Hi?n th?, 0: ?n (n?u vi ph?m n?i quy)
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Sample Data for Users
INSERT INTO Users (FullName, Username, Password, Email, PhoneNumber, BirthDate, Address, Role, State)
VALUES 
(N'Nguyen V?n A', 'usera', 'hashedpassword0', 'a@example.com', '0900000001', '1999-03-13', N'H? N?i', 1, 1),
(N'Tr?n Th? B', 'userb', 'hashedpassword1', 'b@example.com', '0900000002', '2001-01-14', N'TP. HCM', 2, 1),
(N'L? V?n C', 'userc', 'hashedpassword2', 'c@example.com', '0900000003', '1998-06-15', N'?? N?ng', 3, 1),
(N'Ph?m Th? D', 'userd', 'hashedpassword3', 'd@example.com', '0900000004', '1997-09-21', N'H?i Ph?ng', 1, 1),
(N'Ho?ng V?n E', 'usere', 'hashedpassword4', 'e@example.com', '0900000005', '2000-11-10', N'C?n Th?', 1, 1);

-- Categories
INSERT INTO Categories (CategoryName, Description, State)
VALUES 
(N'H?i s?n t??i s?ng', N'C?, t?m, cua... t??i s?ng', 1),
(N'H?i s?n ??ng l?nh', N'B?o qu?n nhi?t ?? th?p', 1),
(N'H?i s?n nh?p kh?u', N'Nh?p t? n??c ngo?i', 1),
(N'??c s?n v?ng mi?n', N'S?n ph?m ??a ph??ng n?i b?t', 1),
(N'S?n ph?m ch? bi?n s?n', N'??ng g?i, ?n li?n', 1);

-- Suppliers
INSERT INTO Suppliers (SupplierName, ContactName, Phone, Email, Address, State)
VALUES 
(N'C?ng ty TNHH Bi?n Xanh', N'Tr?n V?n H?i', '0911222333', 'contact@bienxanh.vn', N'Qu?ng Ninh', 1),
(N'Cty CP H?i S?n Mi?n Nam', N'L? Th? Tuy?t', '0933444555', 'info@haisansouth.vn', N'C? Mau', 1),
(N'Seafood Japan Ltd.', N'Yamamoto Kenta', '0812345678', 'export@seafood.jp', N'Tokyo, Japan', 1),
(N'SeaFresh Co.', N'Nguy?n V?n H?ng', '0909988776', 'seafresh@vn.com', N'?? N?ng', 1),
(N'H?i S?n Vina', N'Tr?n Kim Ng?n', '0977554433', 'sales@haisanvina.vn', N'TP. HCM', 1);

-- Products
INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight, State)
VALUES 
(N'T?m S? T??i', 1, 250000, 120, 1, N'T?m s? ??nh b?t trong ng?y.', N'Vi?t Nam', N'0 - 4?C', '2025-08-01', 0.5, 1),
(N'Cua Ho?ng ??', 1, 1200000, 30, 3, N'Cua nh?p kh?u Alaska.', N'M?', N'-18?C', '2025-12-31', 1.8, 1),
(N'C? H?i Phi L?', 2, 380000, 60, 3, N'C? h?i Na Uy phi l? s?n.', N'Na Uy', N'-18?C', '2025-07-15', 1.2, 1),
(N'M?c M?t N?ng', 4, 450000, 45, 4, N'M?c ph?i 1 n?ng t? Phan Thi?t.', N'Vi?t Nam', N'-18?C', '2025-09-01', 0.7, 1),
(N'Ch? M?c H? Long', 5, 320000, 100, 5, N'Ch? m?c ??c s?n H? Long.', N'Vi?t Nam', N'B?o qu?n ??ng l?nh', '2025-10-30', 0.3, 1);

-- Images
INSERT INTO Images (ProductID, ImageURL)
VALUES 
(1, 'images/tom_su.jpg'),
(2, 'images/cua_hoang_de.jpg'),
(3, 'images/ca_hoi_file.jpg'),
(4, 'images/muc_mot_nang.jpg'),
(5, 'images/cha_muc.jpg');

-- Orders
INSERT INTO Orders (UserID, TotalAmount, Status, ShippingStatus)
VALUES 
(1, 750000, 'Completed', 'Shipped'),
(2, 1200000, 'Pending', 'Processing'),
(3, 320000, 'Cancelled', 'Not Shipped');

-- OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES 
(1, 1, 2, 250000),
(1, 5, 1, 250000),
(2, 2, 1, 1200000),
(3, 5, 1, 320000);

-- Cart
INSERT INTO Cart (UserID, ProductID, Quantity)
VALUES 
(1, 3, 1),
(2, 4, 2),
(3, 1, 3);

-- Payments
INSERT INTO Payments (OrderID, PaymentMethod, PaymentType, AmountPaid)
VALUES 
(1, N'COD', N'Offline', 750000),
(2, N'Bank Transfer', N'Online', 1200000),
(3, N'Credit Card', N'Online', 320000);

-- Shipping
INSERT INTO Shipping (OrderID, Carrier, TrackingNumber, EstimatedDelivery, DeliveryStatus)
VALUES 
(1, N'GHN', N'GHN123456', '2025-04-20', N'Delivered'),
(2, N'Viettel Post', N'VT123123', '2025-04-25', N'Processing');

-- Contact
INSERT INTO Contact (StoreName, Phone, Email, Address, WorkingHours, Facebook, Zalo, Instagram, Note)
VALUES 
(N'H?i S?n T??i Ngon', '18001234', 'support@haisantuoingon.vn', N'123 L? L?i, Q1, TP.HCM',
 N'7:00 - 21:00', 'https://facebook.com/haisantuoingon', '0909999999', 'https://instagram.com/haisantuoingon', N'Giao h?ng to?n qu?c');

-- LogActivity
INSERT INTO LogActivity (UserID, Action, Resource, DataBefore, DataAfter, IPAddress, Location)
VALUES 
(1, N'T?o ??n h?ng', N'Orders', NULL, N'{orderId: 1, amount: 750000}', '192.168.1.1', N'TP.HCM');

-- PasswordResets
INSERT INTO PasswordResets (UserID, Token, ExpiryTime)
VALUES 
(1, 'resetToken123', DATEADD(HOUR, 1, GETDATE()));

-- Reviews
INSERT INTO Reviews (UserID, ProductID, Rating, Comment)
VALUES 
(1, 1, 5, N'T?m r?t t??i ngon, giao nhanh.'),
(2, 2, 4, N'Cua to, ??ng m? t?.'),
(3, 3, 3, N'C? ok nh?ng h?i ??t.');

























-- Xo? c?c b?ng c? r?ng bu?c foreign key tr??c
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS PasswordResets;
DROP TABLE IF EXISTS LogActivity;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Shipping;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Images;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;
