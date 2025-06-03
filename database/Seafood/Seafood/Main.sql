-- Tạo database SeafoodProject
CREATE DATABASE SeafoodProject;
USE SeafoodProject;

GO

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NULL,
    Username NVARCHAR(50) NULL,
    Password NVARCHAR(255) NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NULL,
    BirthDate DATE NULL,
    Address NVARCHAR(255) NULL,
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
    Status INT CHECK (Status BETWEEN 1 AND 3) DEFAULT 1, -- 1. Pending ,2. Comfirm ,3. Cancelled --
    State INT DEFAULT 1, -- 1: Active, 0: Disabled
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
	State INT DEFAULT 1, -- 1. Active, 2. Delete
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Payments
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    PaymentType NVARCHAR(50) NOT NULL DEFAULT 'Offline', -- 1. COD , 2. Bank
    PaymentStatus NVARCHAR(50) DEFAULT 'Pending', -- 1. Pending, 2. Confirm, 3. Denide
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
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Tạo bảng Contact
CREATE TABLE Contact (
    ContactID INT PRIMARY KEY IDENTITY(1,1),
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
	SeverityLevel NVARCHAR(20) DEFAULT 'INFO', -- 1. INFO, 2. WARNING, 3. ERROR, 4. CRITICAL 
    Timestamp DATETIME DEFAULT GETDATE(),
    Location NVARCHAR(255) NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
);
	
-- Tạo bảng OTP 
CREATE TABLE Otp (
	otpId INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    otp_code VARCHAR(10) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    expires_at DATETIME NOT NULL,
	is_verified BIT DEFAULT 0, -- 0. False, 1. True
	State INT DEFAULT 1,

    FOREIGN KEY (user_id) REFERENCES Users(UserID) ON DELETE CASCADE
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
    (N'Cá',  N'Các loại cá tươi sống và cá xuất khẩu (Cá Chim, Cá Cơm, Cá Hồi, ... Tuna Fish)'),
    (N'Chả', N'Các loại chả cá và chả mực đặc sản'),
    (N'Cua', N'Các loại cua tươi: cua đá, cua hoàng đế, cua thiết giáp'),
    (N'Mực', N'Các loại mực tươi (mực lá, mực nang, mực ống, mực sim, mực trứng)'),
    (N'Ốc',  N'Các loại ốc biển tươi ngon (ốc bàn tay, ốc cà na, ốc hương, ốc mỡ, ốc móng tay)'),
    (N'Tôm', N'Các loại tôm biển tươi (tôm sú, tôm càng xanh, tôm đất, tôm hẻ, tôm hùm, ...)');
GO

INSERT INTO Suppliers (SupplierName, ContactName, Phone, Email, Address)
VALUES
    (N'Công ty TNHH Tôm Việt', N'Minh Tâm', '0901111111', 'tomviet@example.com', N'Cà Mau'),
    (N'Công ty Cua Biển',      N'Thành Long','0902222222', 'cuabien@example.com',   N'Quảng Ninh'),
    (N'Cá Hồi Na Uy',          N'Lê Hải',    '0903333333', 'cahoinauy@example.com', N'TP.HCM'),
    (N'Công ty Ốc Biển Bắc',   N'Thảo Vy',   '0904444444', 'ocbienbac@example.com', N'Bắc Ninh'),
    (N'Công ty Mực Miền Trung',N'Minh Đức',  '0905555555', 'mucmientrung@example.com', N'Quảng Ngãi'),
    (N'Chuỗi Hải Sản Sạch',    N'Tuấn Anh',  '0906666666', 'haisan@example.com',      N'Đà Nẵng'),
    (N'Công ty Cá Vàng',       N'Bảo An',    '0907777777', 'cavang@example.com',       N'Hải Phòng'),
    (N'Công ty Tôm Đông',      N'Hồng Sơn',  '0908888888', 'tomdong@example.com',      N'Cà Mau'),
    (N'Công ty Thủy Sản ABC',   N'Lan Hương', '0909999999', 'thuyysanabc@example.com',  N'TP.HCM');
GO


-- Nhóm Cá (CategoryID = 1)
INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight, State) VALUES
(N'Cá Chim',        1, 200000.00, 50,  1, N'Cá Chim tươi, thịt thơm, thích hợp nướng hoặc hấp',      N'Biển Đông',        N'Bảo quản lạnh 0–4°C', '2025-07-01', 1.2, 1),
(N'Cá Cơm',         1, 150000.00, 80,  1, N'Cá Cơm đánh bắt trong ngày, thịt dai',                     N'Vịnh Bắc Bộ',      N'Bảo quản lạnh 0–4°C', '2025-06-25', 0.5, 1),
(N'Cá Hồi',         1, 300000.00, 30,  2, N'Cá Hồi Nauy nhập khẩu, thịt đỏ tươi',                     N'Na Uy',            N'Bảo quản đông –18°C', '2025-08-10', 2.0, 1),
(N'Cá Mú',          1, 250000.00, 40,  2, N'Cá Mú đỏ tươi, thịt chắc, phù hợp kho tộ',                  N'Biển Đông',        N'Bảo quản lạnh 0–4°C', '2025-07-15', 1.5, 1),
(N'Cá Ngừ',         1, 280000.00, 35,  2, N'Cá Ngừ đại dương, thịt săn chắc, giàu dinh dưỡng',          N'Thái Bình Dương',  N'Bảo quản đông –18°C', '2025-09-01', 1.8, 1),
(N'Cá Nục',         1, 180000.00, 60,  1, N'Cá Nục đánh bắt sáng sớm, thịt ngọt mềm',                   N'Vịnh Bắc Bộ',      N'Bảo quản lạnh 0–4°C', '2025-06-20', 0.7, 1),
(N'Cá Thu',         1, 220000.00, 45,  1, N'Cá Thu tươi, thớ thịt dày, phù hợp làm sashimi',            N'Biển Đông',        N'Bảo quản lạnh 0–4°C', '2025-07-05', 1.3, 1),
(N'Cá Trà',         1, 200000.00, 50,  3, N'Cá Trà tươi ngon, vị ngọt tự nhiên',                         N'Miền Trung',       N'Bảo quản lạnh 0–4°C', '2025-07-08', 1.1, 1),
(N'Cá Trích',       1, 190000.00, 55,  3, N'Cá Trích béo ngậy, thích hợp rán giòn',                      N'Vịnh Bắc Bộ',      N'Bảo quản lạnh 0–4°C', '2025-06-30', 0.9, 1),
(N'Tuna Fish',      1, 350000.00, 30,  9, N'Cá Ngừ đại dương tươi, thịt đỏ, chất lượng cao',            N'Đại Dương Thái Bình Dương', N'Bảo quản đông –18°C', '2025-09-30', 1.8, 1);

-- Nhóm Chả (CategoryID = 2)
INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight, State) VALUES
(N'Chả Cá Rô Phi',   2, 100000.00, 100, 4, N'Chả cá Rô Phi thơm ngon, giã tay',                                N'Đồng bằng Sông Cửu Long', N'Bảo quản đông –18°C', '2025-10-01', 0.5, 1),
(N'Chả Cá Thát Lát', 2, 120000.00,  80, 4, N'Chả cá Thát Lát đặc sản miền Tây',                                  N'Đồng bằng Sông Cửu Long', N'Bảo quản đông –18°C', '2025-09-15', 0.6, 1),
(N'Chả Mực',         2, 150000.00,  70, 5, N'Chả mực giã tay Phú Quốc, thơm béo',                             N'Phú Quốc',               N'Bảo quản đông –18°C', '2025-10-10', 0.4, 1);

-- Nhóm Cua (CategoryID = 3)
INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight, State) VALUES
(N'Cua Đá Bắc Giang',   3, 350000.00, 20,  6, N'Cua đá Bắc Giang đậm đà vị biển',                      N'Bắc Giang',      N'Bảo quản lạnh 0–4°C', '2025-07-20', 1.5, 1),
(N'Cua Đá Lý Sơn',      3, 360000.00, 15,  6, N'Cua đá Lý Sơn tươi ngon, thịt chắc',                   N'Lý Sơn',         N'Bảo quản lạnh 0–4°C', '2025-08-05', 1.6, 1),
(N'Cua Hoàng Đế',       3,1200000.00, 10,  7, N'Cua Hoàng Đế Alaska siêu to khổng lồ',                 N'Alaska',         N'Bảo quản đông –18°C', '2025-10-20', 2.5, 1),
(N'Cua Thiết Giáp Tây Nguyên',3,380000.00, 12, 7, N'Cua thiết giáp Tây Nguyên hiếm, chất lượng cao',   N'Tây Nguyên',     N'Bảo quản đông –18°C', '2025-09-30', 1.8, 1);

-- Nhóm Mực (CategoryID = 4)
INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight, State) VALUES
(N'Mực lá',      4, 250000.00, 50, 1, N'Mực lá tươi, thịt chắc, thích hợp nướng hoặc xào',         N'Biển Đông',     N'Bảo quản lạnh 0–4°C', '2025-08-15', 1.0, 1),
(N'Mực nang',    4, 280000.00, 40, 1, N'Mực nang tươi, thịt dai, vị ngọt tự nhiên',                    N'Biển Đông',     N'Bảo quản lạnh 0–4°C', '2025-08-10', 1.2, 1),
(N'Mực ống',     4, 300000.00, 30, 1, N'Mực ống tươi, thớ thịt mềm, phù hợp nấu lẩu',                   N'Hải Phòng',     N'Bảo quản lạnh 0–4°C', '2025-08-05', 1.5, 1),
(N'Mực sim',     4, 220000.00, 45, 2, N'Mực sim dai, vị ngọt, thích hợp chiên giòn hoặc xào sả ớt',      N'Quảng Ninh',    N'Bảo quản lạnh 0–4°C', '2025-07-30', 0.8, 1),
(N'Mực trứng',   4, 240000.00, 35, 2, N'Mực trứng phần trứng căng, thơm béo',                           N'Quảng Ninh',    N'Bảo quản lạnh 0–4°C', '2025-07-28', 1.0, 1);

-- Nhóm Ốc (CategoryID = 5)
INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight, State) VALUES
(N'Ốc bàn tay',  5, 180000.00, 60, 3, N'Ốc bàn tay to, thịt giòn ngọt, thích hợp xào tỏi ớt',      N'Bình Thuận',    N'Bảo quản lạnh 0–4°C', '2025-07-20', 0.7, 1),
(N'Ốc cà na',   5, 160000.00, 70, 3, N'Ốc cà na béo ngậy, vỏ dày, thích hợp nấu cháo hoặc hấp',   N'Kiên Giang',    N'Bảo quản lạnh 0–4°C', '2025-07-18', 0.5, 1),
(N'Ốc hương',   5, 250000.00, 40, 3, N'Ốc hương thơm, ngọt thịt, thích hợp nướng mỡ hành',        N'Phú Quốc',      N'Bảo quản lạnh 0–4°C', '2025-07-22', 0.9, 1),
(N'Ốc mỡ',      5, 200000.00, 55, 4, N'Ốc mỡ thớ thịt mềm, thích hợp xào bơ tỏi',                    N'Khánh Hòa',     N'Bảo quản lạnh 0–4°C', '2025-07-25', 0.8, 1),
(N'Ốc móng tay',5, 190000.00, 65, 4, N'Ốc móng tay vỏ dài, thịt mềm, thích hợp luộc hoặc nướng',       N'Khánh Hòa',     N'Bảo quản lạnh 0–4°C', '2025-07-23', 0.6, 1);

-- Nhóm Tôm (CategoryID = 6)
INSERT INTO Products (Name, CategoryID, Price, StockQuantity, SupplierID, Description, Origin, StorageCondition, ExpiryDate, Weight, State) VALUES
(N'Tôm sú',            6, 450000.00, 25, 5,  N'Tôm sú tươi, thịt chắc, phù hợp nướng hoặc hấp',          N'Cà Mau',        N'Bảo quản lạnh 0–4°C', '2025-07-28', 1.5, 1),
(N'Tôm càng xanh',     6, 400000.00, 30, 5,  N'Tôm càng xanh thân to, phù hợp hấp hoặc nấu canh',       N'Kiên Giang',     N'Bảo quản lạnh 0–4°C', '2025-07-30', 1.2, 1),
(N'Tôm đất',           6, 350000.00, 40, 5,  N'Tôm đất tươi, thịt ngọt, thích hợp chiên bơ tỏi',       N'Bến Tre',       N'Bảo quản lạnh 0–4°C', '2025-07-26', 1.0, 1),
(N'Tôm hẻ',            6, 300000.00, 50, 5,  N'Tôm hẻ nhỏ, phù hợp luộc hoặc làm gỏi',                  N'Bến Tre',       N'Bảo quản lạnh 0–4°C', '2025-08-01', 0.8, 1),
(N'Tôm hùm',           6,1200000.00, 10, 6,  N'Tôm hùm Alaska cao cấp, thịt chắc, ngọt tự nhiên',       N'Alaska',        N'Bảo quản đông –18°C', '2025-09-05', 2.5, 1),
(N'Tôm hùm đất',       6, 900000.00, 12, 6,  N'Tôm hùm đất Việt Nam, tươi ngon, thích hợp hấp bia',      N'Biển Việt Nam', N'Bảo quản đông –18°C', '2025-09-10', 2.0, 1),
(N'Tôm phốc',          6, 380000.00, 20, 6,  N'Tôm phốc tươi, thịt dai, phù hợp nấu lẩu',                 N'Cà Mau',        N'Bảo quản lạnh 0–4°C', '2025-08-15', 1.1, 1),
(N'Tôm sắt',           6, 280000.00, 30, 7,  N'Tôm sắt nhỏ, thịt thơm, thích hợp chiên tỏi hoặc kho tương',N'Vũng Tàu',      N'Bảo quản lạnh 0–4°C', '2025-07-22', 0.8, 1),
(N'Tôm sú Cà Mau',     6, 500000.00, 15, 7,  N'Tôm sú Cà Mau ngon, cỡ vừa, thịt dai béo',               N'Cà Mau',        N'Bảo quản lạnh 0–4°C', '2025-08-05', 1.4, 1),
(N'Tôm sú mẹ',         6, 550000.00,  8, 7,  N'Tôm sú mẹ to, chất lượng hàng đầu, phù hợp tiệc sang trọng',N'Cà Mau',        N'Bảo quản đông –18°C', '2025-09-12', 1.6, 1),
(N'Tôm thẻ',           6, 320000.00, 40, 8,  N'Tôm thẻ tươi, thịt săn chắc, thích hợp xào, luộc',        N'Miền Tây',      N'Bảo quản lạnh 0–4°C', '2025-08-18', 1.0, 1),
(N'Tôm tích',          6, 380000.00, 25, 8,  N'Tôm tích tươi sống, thịt thơm, thích hợp nướng',          N'Miền Tây',      N'Bảo quản lạnh 0–4°C', '2025-08-20', 1.2, 1);
GO



-- ProductID từ 1 đến 10 là nhóm Cá
INSERT INTO Images (ProductID, ImageURL) VALUES
(1,  'IMG/ca-chim.jpg'),
(2,  'IMG/ca-com.jpg'),
(3,  'IMG/ca-hoi.jpg'),
(4,  'IMG/ca-mu.jpg'),
(5,  'IMG/ca-ngu.jpg'),
(6,  'IMG/ca-nuc.jpg'),
(7,  'IMG/ca-thu.jpg'),
(8,  'IMG/ca-tra.jpg'),
(9,  'IMG/ca-trich.jpg'),
(10, 'IMG/tunaFish.png');

-- ProductID từ 11 đến 13 là nhóm Chả
INSERT INTO Images (ProductID, ImageURL) VALUES
(11, 'IMG/cha-ca-ro-phi.jpg'),
(12, 'IMG/cha-ca-that-lat.jpg'),
(13, 'IMG/cha-muc.jpg');

-- ProductID từ 14 đến 17 là nhóm Cua
INSERT INTO Images (ProductID, ImageURL) VALUES
(14, 'IMG/cua-da-bac-giang.png'),
(15, 'IMG/cua-da-ly-son.webp'),
(16, 'IMG/cua-hoang-de.jpg'),
(17, 'IMG/cua-thiet-giap-tay-nguyen.webp');

-- ProductID từ 18 đến 22 là nhóm Mực
INSERT INTO Images (ProductID, ImageURL) VALUES
(18, 'IMG/muc-la.jpg'),
(19, 'IMG/muc-nang.jpg'),
(20, 'IMG/muc-ong.jpg'),
(21, 'IMG/muc-sim.jpg'),
(22, 'IMG/muc-trung.jpg');

-- ProductID từ 23 đến 27 là nhóm Ốc
INSERT INTO Images (ProductID, ImageURL) VALUES
(23, 'IMG/oc-ban-tay.jpg'),
(24, 'IMG/oc-ca-na.jpg'),
(25, 'IMG/oc-huong.jpg'),
(26, 'IMG/oc-mo.jpg'),
(27, 'IMG/oc-mong-tay.jpg');

-- ProductID từ 28 đến 39 là nhóm Tôm
INSERT INTO Images (ProductID, ImageURL) VALUES
(28, 'IMG/shrimpSu.png'),
(29, 'IMG/tom-cang-xanh.jpg'),
(30, 'IMG/tom-dat.jpg'),
(31, 'IMG/tom-he.jpg'),
(32, 'IMG/tom-hum.jpg'),
(33, 'IMG/tom-hum-dat.jpg'),
(34, 'IMG/tom-phoc.jpg'),
(35, 'IMG/tom-sat.jpg'),
(36, 'IMG/tom-su-ca-mau.jpg'),
(37, 'IMG/tom-su-me.jpg'),
(38, 'IMG/tom-the.jpg'),
(39, 'IMG/tom-tic.jpg');
GO

INSERT INTO Orders (UserID, TotalAmount, Status)
VALUES 
(1, 750000, 1),
(2, 1200000, 2),
(3, 320000, 3);

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

INSERT INTO Shipping (OrderID, Carrier, TrackingNumber, EstimatedDelivery)
VALUES 
(1, N'GHN', N'GHN123456', '2025-04-20'),
(2, N'Viettel Post', N'VT123123', '2025-04-25');

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
























DROP TABLE IF EXISTS Otp;

DROP TABLE IF EXISTS ProductInDetail;
DROP TABLE IF EXISTS ProductIn;
DROP TABLE IF EXISTS ProductDiscount;
DROP TABLE IF EXISTS Discounts;

DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS PasswordResets;
DROP TABLE IF EXISTS LogActivity;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Shipping;
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Cart;

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

