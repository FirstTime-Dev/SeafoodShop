-- Test thử query --

USE SeafoodProject;

GO

-- Query ktra tồnn kho --
SELECT 
    p.ProductID,
    p.Name,
    p.StockQuantity AS InitialStock,
    ISNULL(SUM(pid.Quantity), 0) AS TotalImported,
    ISNULL(SUM(od.Quantity), 0) AS TotalSold,
    (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) AS CurrentStock
FROM 
    Products p
LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 'Completed'
GROUP BY 
    p.ProductID, p.Name, p.StockQuantity
ORDER BY 
    CurrentStock ASC;

-- Lấy sản phẩm hết hàng
SELECT 
    COUNT(*) AS OutOfStockCount
FROM (
    SELECT 
        p.ProductID,
        (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) AS CurrentStock
    FROM 
        Products p
    LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID
    LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
    LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 'Completed'
    GROUP BY 
        p.ProductID, p.StockQuantity
) AS InventoryCalc
WHERE CurrentStock <= 0;

-- Lấy sản phẩm sắp hết hạn --
SELECT 
    p.ProductID,
    p.Name,
    SUM(pid.Quantity) AS TotalStockQuantity,
    SUM(CASE 
        WHEN pid.ExpiryDate < CAST(GETDATE() AS DATE) 
        THEN pid.Quantity ELSE 0 END
    ) AS ExpiredQuantity,
    SUM(CASE 
        WHEN pid.ExpiryDate BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 7, GETDATE()) 
        THEN pid.Quantity ELSE 0 END
    ) AS ExpiringSoonQuantity,
    MIN(pid.ExpiryDate) AS EarliestExpiryDate,
    MIN(pid.CreatedDate) AS FirstImportDate
FROM 
    ProductInDetail pid
JOIN 
    Products p ON pid.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.Name
HAVING 
    SUM(CASE 
        WHEN pid.ExpiryDate BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 7, GETDATE()) 
        THEN pid.Quantity ELSE 0 END
    ) > 0
ORDER BY 
    EarliestExpiryDate ASC;

-- Lấy số lượng sản phẩm sắp hết hạn --
SELECT 
    SUM(pid.Quantity) AS TotalExpiringSoonQuantity
FROM 
    ProductInDetail pid
WHERE 
    pid.Quantity > 0
    AND pid.ExpiryDate BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 30, GETDATE());

-- Lấy số lượng sản phẩm hết hạn --
SELECT 
    ISNULL(SUM(pid.Quantity), 0) AS TotalExpiredQuantity
FROM 
    ProductInDetail pid
WHERE 
    pid.Quantity > 0
    AND pid.ExpiryDate < CAST(GETDATE() AS DATE);

-- Tổng số loại sản phẩm hiện có --
SELECT 
    COUNT(*) AS TotalCategories
FROM 
    Categories;

-- Tồn kho của tất cả các sản phẩm --
SELECT 
    SUM(CurrentStock) AS TotalStock
FROM (
    SELECT 
        p.ProductID,
        p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0) AS CurrentStock
    FROM 
        Products p
    LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID
    LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
    LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 'Completed' 
    GROUP BY 
        p.ProductID, p.StockQuantity
) AS StockCalculation;

-- Lấy sản phẩm sắp hết tồn kho --
SELECT 
    p.ProductID,
    p.Name,
    (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) AS CurrentStock
FROM 
    Products p
LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID         -- Liên kết với bảng ProductInDetail để lấy số lượng nhập kho
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID             -- Liên kết với bảng OrderDetails để lấy số lượng đã bán
LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = '1' -- Chỉ tính đơn hàng đã hoàn thành
GROUP BY 
    p.ProductID, p.Name, p.StockQuantity
HAVING 
    (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) <= 40  -- Ngưỡng tồn kho dưới 10
ORDER BY 
    CurrentStock ASC;

-- Lấy tổng số tài khoản theo trạng thái (1-Active ; 2-Disable) --
-- Active --
SELECT COUNT(*) AS ActiveAccountCount
FROM Users
WHERE State = 1;
-- Disable --
SELECT COUNT(*) AS DisabledAccountCount
FROM Users
WHERE State = 0;

-- Lấy tổng số các nhà tài trợ/ cung cấp --
SELECT COUNT(*) AS ActiveAccountCount
FROM Suppliers

-- Lấy tổng số danh mục --
SELECT COUNT(*) AS CategoryCount
From Categories

-- Lấy tổng số khuyến mãi --
SELECT COUNT(*) AS TotalDiscounts FROM Discounts;
-- Các khuyến mãi còn hiệu lực --
SELECT COUNT(*) AS TotalActiveDiscounts
FROM Discounts
WHERE IsActive = 1;

-- Lấy đánh giá --
-- Lấy điểm trung bình --
SELECT AVG(CAST(Rating AS FLOAT)) AS AverageRating
FROM Reviews;
-- Lấy tổng số đánh giá --
SELECT COUNT(*) AS TotalReviews FROM Reviews;

-- Lấy User --
SELECT * FROM Users
WHERE State = 1;

-- update biến Ban --
UPDATE Users SET State=1 WHERE UserID=1;

-- update user --
UPDATE Users 
SET 
    FullName = 'A', 
    Username = 'usera', 
    Password = 'a', 
    Email = 'a@gmail.com', 
    PhoneNumber = '0111111111', 
    BirthDate = '1011-01-01', 
    Address = 'Homeless' 
WHERE UserID = 1;

-- Lấy user theo id --
SELECT * FROM Users WHERE UserID = 1;

-- Tạo thêm Account --
INSERT INTO Users 
(FullName, Username, Password, Email, PhoneNumber, BirthDate, Address)
VALUES 
(N'Nguyễn Văn A', 'nguyenvana', '123456', 'vana@example.com', '0909123456', '1995-08-20', N'123 Đường ABC, Quận 1, TP.HCM');


-- Update biến status trong Order --
UPDATE Orders SET Status=2 WHERE OrderID=2;

-- Update biến status trong Order -- 
UPDATE Orders SET Status=3 WHERE OrderID=2;
UPDATE Products
SET StockQuantity = StockQuantity + OD.Quantity
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
WHERE OD.OrderID = 2;

-- Truy vấn cho Chi tiết đơn hàng -- 
SELECT * FROM OrderDetails WHERE OrderID = ?;

-- Truy vấn cho chỉnh sửa chi tiết đơn hàng --
UPDATE OrderDetails
SET 
    ProductID = ?,
    Quantity = ?,
    Price = ?
WHERE OrderID = ?;

-- Truy vấn các đơn hàng trong trạng thái 'Pending' --
SELECT * FROM Orders WHERE Status=1 AND State=1;

-- Truy vấn các chi tiết đơn hàng --
SELECT * FROM OrderDetails WHERE OrderID=1;

-- Truy vấn chi tiết đơn hàng --
SELECT 
    od.OrderID,
	o.OrderDate,
    p.Name AS ProductName,
    od.Quantity,
    od.Price,
    od.Total,
    u.FullName,
    u.PhoneNumber,
    u.Email,
    u.Address,
    o.Status
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Users u ON o.UserID = u.UserID
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.OrderID = 1;

-- Update orderStatus từ Pending sang Xác nhận hoặc từ status hiện tại sang Cancelled --
-- Check current status --
SELECT Status FROM Orders WHERE OrderID = 2;
-- Update status --
UPDATE Orders SET Status = 2 WHERE OrderID = 2;
UPDATE Orders SET Status = 1 WHERE OrderID = 1;

-- Check User --
SELECT * FROM Users;

-- Update password --
UPDATE Users SET Email = '22130240@st.hcmuaf.edu.vn' WHERE UserID = 3;

SELECT email FROM Users WHERE username = 'hoangvane';

INSERT INTO Otp (user_id, otp_code, created_at, expires_at, is_verified, State)
VALUES (
    1,
    '123456',
    GETDATE(),
    DATEADD(MINUTE, 5, GETDATE()),
    0,
    1
);

SELECT * FROM Products WHERE State = 1 AND (Name LIKE '%Cua%' OR Description LIKE '%Cua%');

SELECT
    p.ProductID,
    p.Name,
    p.CategoryID,
    p.Price,
    p.StockQuantity,
    p.SupplierID,
    p.Description,
    p.Origin,
    p.StorageCondition,
    p.ExpiryDate,
    p.Weight,
    p.State,
    i.ImageURL,
    i.UploadedAt
FROM
    Products AS p
    LEFT JOIN Images AS i
        ON p.ProductID = i.ProductID
WHERE
    p.State = 1
ORDER BY
    p.ProductID ASC,
    i.ImageID ASC;

UPDATE 