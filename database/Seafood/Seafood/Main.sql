-- Tạo database SeafoodProject
CREATE DATABASE SeafoodProject;
USE SeafoodProject;

GO

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    BirthDate DATE NOT NULL,
    Address NVARCHAR(255),
    Role INT CHECK (Role BETWEEN 1 AND 3) DEFAULT 1, -- 1: User, 2: Manage, 3: Admin
	Ban INT DEFAULT 0, -- 0: Unban, 1: Ban
    State INT DEFAULT 1, -- 1: Active, 0: Disabled
    CreatedAt DATETIME DEFAULT GETDATE()
);


CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255),
    State INT DEFAULT 1
);

-- Tạo bảng Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100),
    Phone NVARCHAR(15) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Address NVARCHAR(255),
    State INT DEFAULT 1
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    SupplierID INT,
    Description NVARCHAR(MAX),
    Origin NVARCHAR(100),
    StorageCondition NVARCHAR(255),
    ExpiryDate DATE,
    Weight DECIMAL(10,2) CHECK (Weight > 0),
    State INT DEFAULT 1,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Images (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    ImageURL NVARCHAR(255) NOT NULL,
    UploadedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Orders
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

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Total AS (Quantity * Price) PERSISTED,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);


-- Tạo bảng Cart
CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    AddedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    PaymentType NVARCHAR(50) NOT NULL DEFAULT 'Offline',
    PaymentStatus NVARCHAR(50) DEFAULT 'Pending',
    PaymentDate DATETIME DEFAULT GETDATE(),
    AmountPaid DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Tạo bảng Shipping
CREATE TABLE Shipping (
    ShippingID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    Carrier NVARCHAR(100) NOT NULL,
    TrackingNumber NVARCHAR(50),
    EstimatedDelivery DATE,
    DeliveryStatus NVARCHAR(50) DEFAULT 'Processing',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Tạo bảng Contact
CREATE TABLE Contact (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
<<<<<<< HEAD
    StoreName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15) UNIQUE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    WorkingHours NVARCHAR(100),
    Facebook NVARCHAR(255),
    Zalo NVARCHAR(50),
    Instagram NVARCHAR(255),
    Note NVARCHAR(255),
    State INT DEFAULT 1
);

-- Tạo bảng LogActivity
CREATE TABLE LogActivity (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NULL,
    Action NVARCHAR(255) NOT NULL,
    Resource NVARCHAR(100) NOT NULL,
    DataBefore NVARCHAR(MAX) NULL,
    DataAfter NVARCHAR(MAX) NULL,
    IPAddress NVARCHAR(50) NULL,
    Timestamp DATETIME DEFAULT GETDATE(),
    Location NVARCHAR(255) NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
);

-- Tạo bảng PasswordResets
CREATE TABLE PasswordResets (
    ResetID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Token NVARCHAR(255) UNIQUE NOT NULL,
    ExpiryTime DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Tạo bảng Reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(1000),
    ReviewDate DATETIME DEFAULT GETDATE(),
    State INT DEFAULT 1,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Discounts
CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY IDENTITY(1,1),
    Code NVARCHAR(50) UNIQUE NOT NULL,
    DiscountType NVARCHAR(20) CHECK (DiscountType IN ('Percentage', 'Fixed')) NOT NULL,
    Value DECIMAL(10,2) NOT NULL CHECK (Value > 0),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    MinimumOrderAmount DECIMAL(10,2) DEFAULT 0,
    MaxUsage INT DEFAULT NULL,
    UsageCount INT DEFAULT 0,
    IsActive BIT DEFAULT 1,
    Description NVARCHAR(255)
);

-- Tạo bảng ProductDiscount
CREATE TABLE ProductDiscount (
    ProductID INT,
    DiscountID INT,
    PRIMARY KEY (ProductID, DiscountID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID) ON DELETE CASCADE
);

-- Tạo bảng ProductIn
CREATE TABLE ProductIn (
    ProductInID INT PRIMARY KEY IDENTITY(1,1),
    SupplierID INT NOT NULL,
    ImportDate DATETIME DEFAULT GETDATE(),
    Notes NVARCHAR(255),
    CreatedBy INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
);

-- Tạo bảng ProductInDetail
CREATE TABLE ProductInDetail (
    ProductInDetailID INT PRIMARY KEY IDENTITY(1,1),
    ProductInID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    ImportPrice DECIMAL(10,2) NOT NULL,
	ExpiryDate DATE NOT NULL,
	CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProductInID) REFERENCES ProductIn(ProductInID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Users (FullName, Username, Password, Email, PhoneNumber, BirthDate, Address, Role, Ban, State)
VALUES
(N'Phạm Thị D', 'phamthid', '$2a$10$xJw...', 'd@example.com', '0909123459', '1995-04-15', N'Q4, TP.HCM', 1, 1, 1),
(N'Hoàng Văn E', 'hoangvane', '$2a$10$yKz...', 'e@example.com', '0909123460', '1988-05-20', N'Q5, TP.HCM', 1, 0, 1),
(N'Vũ Thị F', 'vuthif', '$2a$10$zLx...', 'f@example.com', '0909123461', '1993-06-25', N'Q6, TP.HCM', 2, 1, 0),
(N'Đặng Văn G', 'dangvang', '$2a$10$wQv...', 'g@example.com', '0909123462', '1991-07-30', N'Q7, TP.HCM', 3, 1, 1),
(N'Bùi Thị H', 'buithih', '$2a$10$vRt...', 'h@example.com', '0909123463', '1989-08-10', N'Q8, TP.HCM', 1, 0, 0),
(N'Ngô Văn I', 'ngovani', '$2a$10$uSw...', 'i@example.com', '0909123464', '1996-09-05', N'Q9, TP.HCM', 1, 1, 1),
(N'Đỗ Thị K', 'dothik', '$2a$10$tPq...', 'k@example.com', '0909123465', '1997-10-12', N'Q10, TP.HCM', 2, 1, 1),
(N'Mai Văn L', 'maivanl', '$2a$10$sNo...', 'l@example.com', '0909123466', '1985-11-18', N'Q11, TP.HCM', 1, 0, 1),
(N'Lý Thị M', 'lythim', '$2a$10$rMn...', 'm@example.com', '0909123467', '1998-12-22', N'Q12, TP.HCM', 1, 1, 0),
(N'Trịnh Văn N', 'trinhvann', '$2a$10$qKl...', 'n@example.com', '0909123468', '1999-01-30', N'Q1, Hà Nội', 3, 1, 1);

INSERT INTO Categories (CategoryName, Description)
VALUES
(N'Tôm', N'Các loại tôm tươi sống'),
(N'Cua', N'Cua biển cao cấp'),
(N'Cá', N'Cá nhập khẩu'),
(N'Mực', N'Mực một nắng, mực tươi'),
(N'Hải sản chế biến', N'Các sản phẩm hải sản đã qua chế biến');

INSERT INTO Suppliers (SupplierName, ContactName, Phone, Email, Address)
VALUES
(N'Công ty TNHH Tôm Việt', N'Minh Tâm', '0901111111', 'tomviet@example.com', N'Cà Mau'),
(N'Công ty Cua Biển', N'Thành Long', '0902222222', 'cuabien@example.com', N'Quảng Ninh'),
(N'Cá Hồi Na Uy', N'Lê Hải', '0903333333', 'cahoinauy@example.com', N'TP. HCM');

INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight)
VALUES
(N'Tôm sú loại 1', 1, 250000, 100, 1, N'Tôm sú tươi sống loại 1', N'Cà Mau', N'Bảo quản lạnh 0-4 độ C', '2025-04-20', 0.5),
(N'Cua hoàng đế', 2, 1200000, 50, 2, N'Cua hoàng đế siêu to khổng lồ', N'Alaska', N'Đông lạnh -18 độ C', '2025-04-25', 1.2),
(N'Cá hồi phi lê', 3, 400000, 70, 3, N'Cá hồi Na Uy phi lê tươi', N'Na Uy', N'Bảo quản lạnh', '2025-04-22', 1.0),
(N'Mực một nắng', 4, 300000, 40, 1, N'Mực một nắng loại đặc biệt', N'Nha Trang', N'Bảo quản khô ráo', '2025-04-19', 0.8),
(N'Chả mực Hạ Long', 5, 250000, 60, 2, N'Chả mực đặc sản Hạ Long', N'Hạ Long', N'Bảo quản lạnh', '2025-04-30', 0.5);

-- Thêm dữ liệu mẫu cho các bảng Images, Orders, OrderDetails, Cart, Payments, Shipping, Contact, LogActivity, PasswordResets, Reviews
INSERT INTO Images (ProductID, ImageURL)
VALUES 
(1, 'images/tom_su.jpg'),
(2, 'images/cua_hoang_de.jpg'),
(3, 'images/ca_hoi_file.jpg'),
(4, 'images/muc_mot_nang.jpg'),
(5, 'images/cha_muc.jpg');

INSERT INTO Orders (UserID, TotalAmount, Status, ShippingStatus)
VALUES 
(1, 750000, 'Completed', 'Shipped'),
(2, 1200000, 'Pending', 'Processing'),
(3, 320000, 'Cancelled', 'Not Shipped');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 2, 250000),
(2, 2, 1, 1200000),
(3, 5, 1, 320000);

INSERT INTO Cart (UserID, ProductID, Quantity)
VALUES 
(1, 3, 1),
(2, 4, 2),
(3, 1, 3);

INSERT INTO Payments (OrderID, PaymentMethod, PaymentType, AmountPaid)
VALUES 
(1, N'COD', N'Offline', 750000),
(2, N'Bank Transfer', N'Online', 1200000),
(3, N'Credit Card', N'Online', 320000);

INSERT INTO Shipping (OrderID, Carrier, TrackingNumber, EstimatedDelivery, DeliveryStatus)
VALUES 
(1, N'GHN', N'GHN123456', '2025-04-20', N'Delivered'),
(2, N'Viettel Post', N'VT123123', '2025-04-25', N'Processing');

INSERT INTO Contact (StoreName, Phone, Email, Address, WorkingHours, Facebook, Zalo, Instagram, Note)
VALUES
(N'Hải Sản Tươi Ngon', '18001234', 'support@haisantuoingon.vn', N'123 Lê Lợi, Q1, TP.HCM',
 N'7:00 - 21:00', 'https://facebook.com/haisantuoingon', '0909999999', 'https://instagram.com/haisantuoingon', N'Giao hàng toàn quốc');

INSERT INTO LogActivity (UserID, Action, Resource, DataBefore, DataAfter, IPAddress, Location)
VALUES 
(1, N'Tạo đơn hàng', N'Orders', NULL, N'{orderId: 1, amount: 750000}', '192.168.1.1', N'TP.HCM');


INSERT INTO PasswordResets (UserID, Token, ExpiryTime)
VALUES 
(1, 'resetToken123', DATEADD(HOUR, 1, GETDATE()));

INSERT INTO Reviews (UserID, ProductID, Rating, Comment)
VALUES 
(1, 1, 5, N'Tôm rất tươi ngon, giao nhanh.'),
(2, 2, 4, N'Cua to, đóng gói tốt.'),
(3, 3, 3, N'Cá ok nhưng hơi dở.');

INSERT INTO ProductIn (SupplierID, ImportDate, Notes, CreatedBy)
VALUES
(1, GETDATE(), N'Nhập kho tôm sú', 1),
(2, GETDATE(), N'Nhập kho cua hoàng đế', 1),
(3, GETDATE(), N'Nhập kho cá hồi', 1);

INSERT INTO ProductInDetail (ProductInID, ProductID, Quantity, ImportPrice, ExpiryDate, CreatedDate)
VALUES
(1, 1, 50, 200000, '2025-04-30', GETDATE()),  -- Tôm sú, số lượng 50, giá nhập 200,000, hết hạn 30/04/2025, ngày nhập là ngày hiện tại
(2, 2, 20, 1000000, '2026-06-30', GETDATE()), -- Cua hoàng đế, số lượng 20, giá nhập 1,000,000, hết hạn 30/06/2026, ngày nhập là ngày hiện tại
(3, 3, 30, 400000, '2025-04-20', GETDATE());  -- Cá hồi, số lượng 30, giá nhập 400,000, hết hạn 20/04/2025, ngày nhập là ngày hiện tại

INSERT INTO Discounts (Code, DiscountType, Value, StartDate, EndDate, MinimumOrderAmount, MaxUsage, Description)
VALUES 
('SALE10', 'Percentage', 10.00, '2025-04-01', '2025-04-30', 100.00, 100, N'Giảm 10% cho đơn hàng từ 100k'),
('FIX50K', 'Fixed', 50000.00, '2025-04-15', '2025-05-15', 300.00, 50, N'Giảm cố định 50k cho đơn hàng từ 300k'),
('SPRING20', 'Percentage', 20.00, '2025-03-01', '2025-04-30', 200.00, NULL, N'Ưu đãi mùa xuân 20%'),
('FLASH100K', 'Fixed', 100000.00, '2025-04-10', '2025-04-20', 500.00, 10, N'Giảm 100k trong khung giờ vàng'),
('FREESHIP', 'Fixed', 30000.00, '2025-04-01', '2025-06-01', 0.00, NULL, N'Hỗ trợ phí vận chuyển');

INSERT INTO ProductDiscount (ProductID, DiscountID)
VALUES 
(1, 1),
(2, 1),
(1, 2),
(3, 3),
(4, 4),
(5, 5),
(2, 3);


























<<<<<<< HEAD
DROP TABLE IF EXISTS ProductInDetail;
DROP TABLE IF EXISTS ProductIn;
DROP TABLE IF EXISTS ProductDiscount;
DROP TABLE IF EXISTS Discounts;

=======
-- Xo? c?c b?ng c? r?ng bu?c foreign key tr??c
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS PasswordResets;
DROP TABLE IF EXISTS LogActivity;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Shipping;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Cart;
>>>>>>> 15246e888ac81c363f3bb1711db618affb3c761e
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;

DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Shipping;
DROP TABLE IF EXISTS Payments;

DROP TABLE IF EXISTS Images;
DROP TABLE IF EXISTS Products;

DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS Categories;

DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS PasswordResets;
DROP TABLE IF EXISTS LogActivity;

DROP TABLE IF EXISTS Users;
