CREATE DATABASE SeafoodProject;
USE SeafoodProject;

GO
-- B?ng user: l?u thông tin user - quy?n c?a user - tr?ng thái user --
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

-- B?ng phân lo?i: l?u gi?u các lo?i s?n ph?m - mô t?
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
    Description NVARCHAR(MAX),  -- Mô t? chi ti?t v? s?n ph?m
    Origin NVARCHAR(100),  -- Xu?t x? (VD: Vi?t Nam, Nh?t B?n)
    StorageCondition NVARCHAR(255),  -- ?i?u ki?n b?o qu?n (VD: -18°C, ?óng gói chân không)
    ExpiryDate DATE,  -- Ngày h?t h?n
    Weight DECIMAL(10,2) CHECK (Weight > 0),  -- Tr?ng l??ng trung bình (kg)
    State INT DEFAULT 1,  -- 1: Hi?n th?, 0: ?n n?u không còn bán
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- B?ng Hình ?nh S?n Ph?m (Images)
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
    Carrier NVARCHAR(100) NOT NULL, -- Tên ??n v? v?n chuy?n
    TrackingNumber NVARCHAR(50),
    EstimatedDelivery DATE,
    DeliveryStatus NVARCHAR(50) DEFAULT 'Processing',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Contact (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
    StoreName NVARCHAR(100) NOT NULL,  -- Tên c?a hàng
    Phone NVARCHAR(15) UNIQUE NOT NULL,  -- S? ?i?n tho?i hotline
    Email NVARCHAR(100) UNIQUE NOT NULL,  -- Email h? tr? khách hàng
    Address NVARCHAR(255) NOT NULL,  -- ??a ch? c?a hàng chính
    WorkingHours NVARCHAR(100),  -- Gi? làm vi?c (VD: "8:00 - 22:00")
    Facebook NVARCHAR(255),  -- Link Facebook c?a hàng
    Zalo NVARCHAR(50),  -- S? Zalo liên h?
    Instagram NVARCHAR(255),  -- Link Instagram c?a hàng
    Note NVARCHAR(255),  -- Ghi chú thêm (n?u có)
    State INT DEFAULT 1  -- 1: Ho?t ??ng, 0: Vô hi?u hóa
);


CREATE TABLE LogActivity (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NULL, -- NULL n?u là h? th?ng t? ??ng log
    Action NVARCHAR(255) NOT NULL,
    Resource NVARCHAR(100) NOT NULL, -- Tên b?ng ho?c API b? tác ??ng
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
    UserID INT NOT NULL,  -- Ng??i ?ánh giá
    ProductID INT NOT NULL,  -- S?n ph?m ???c ?ánh giá
    Rating INT CHECK (Rating BETWEEN 1 AND 5),  -- ?ánh giá t? 1 ??n 5 sao
    Comment NVARCHAR(1000),  -- N?i dung bình lu?n
    ReviewDate DATETIME DEFAULT GETDATE(),  -- Th?i gian ?ánh giá
    State INT DEFAULT 1,  -- 1: Hi?n th?, 0: ?n (n?u vi ph?m n?i quy)
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
