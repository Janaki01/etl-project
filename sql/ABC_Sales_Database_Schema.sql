-- Create database 
CREATE DATABASE ABC_Sales; 

USE ABC_Sales; 
---------------------------------------------------------------------------------------------

-- Create Tables
-- CUSTOMER 
CREATE TABLE Customer ( 
	CustomerID INT IDENTITY(1,1) PRIMARY KEY, 
    CustomerName VARCHAR(200) NOT NULL, 
    Address1 VARCHAR(200) NULL, 
    Address2 VARCHAR(200) NULL, 
    City VARCHAR(100) NULL, 
    State VARCHAR(100) NULL, 
    Country VARCHAR(100) NULL, 
    Status VARCHAR(50) NOT NULL DEFAULT 'Active', 
    CreatedOn DATETIME NOT NULL DEFAULT SYSDATETIME(), 
    UpdatedOn DATETIME NULL 
    );   
-- Truncate Table Customer
TRUNCATE TABLE Customer;


-- PRODUCT 
CREATE TABLE Product ( 
	ProductID INT IDENTITY(1,1) PRIMARY KEY, 
    ProductName VARCHAR(200) NOT NULL, 
    ManufacturingDate DATE NULL, 
    ShelfLifeInMonths INT NULL, 
    Rate DECIMAL(18,2) NOT NULL, 
    Quantity INT NOT NULL DEFAULT 0,         -- current stock 
    CreatedOn DATETIME NOT NULL DEFAULT SYSDATETIME(), 
    UpdatedOn DATETIME NULL 
	); 
-- Truncate Table Product
TRUNCATE TABLE Product;


-- DISCOUNT 
CREATE TABLE Discount ( 
	DiscountID INT IDENTITY(1,1) PRIMARY KEY, 
    ProductID INT NULL,                        
    DiscountAmount DECIMAL(18,2) NULL,        
    DiscountPercentage DECIMAL(5,2) NULL,      
    Status VARCHAR(50) NOT NULL DEFAULT 'Active', 
    CreatedOn DATETIME NOT NULL DEFAULT SYSDATETIME(), 
    UpdatedOn DATETIME NULL, 
    CONSTRAINT FK_Discount_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID) 
    ); 
 -- Truncate Table Discount
TRUNCATE TABLE Discount;


-- TAXATION 
CREATE TABLE Taxation ( 
	TaxID INT IDENTITY(1,1) PRIMARY KEY, 
    TaxName VARCHAR(200) NOT NULL, 
    TaxTypeApplicable VARCHAR(50) NOT NULL CHECK (TaxTypeApplicable IN ('Orders','Products')), 
    TaxAmount DECIMAL(18,2) NULL,    
    ApplicableYorN CHAR(1) NOT NULL CHECK (ApplicableYorN IN ('Y','N')), 
    CreatedOn DATETIME NOT NULL DEFAULT SYSDATETIME(), 
    UpdatedOn DATETIME NULL 
    ); 
-- Truncate Table Taxation
TRUNCATE TABLE Taxation;


-- ORDER TRANSACTION 
CREATE TABLE OrderTransaction ( 
	OrderID INT IDENTITY(1,1) PRIMARY KEY, 
    CustomerID INT NOT NULL, 
    DiscountID INT NULL, 
    TaxID INT NULL,                              
    TotalAmount DECIMAL(18,2) NULL,              
    CreatedOn DATETIME NOT NULL DEFAULT SYSDATETIME(), 
    UpdatedOn DATETIME NULL, 
    CONSTRAINT FK_Order_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID), 
    CONSTRAINT FK_Order_Discount FOREIGN KEY (DiscountID) REFERENCES Discount(DiscountID), 
    CONSTRAINT FK_Order_Tax FOREIGN KEY (TaxID) REFERENCES Taxation(TaxID) 
    ); 
-- Truncate Table Order Transaction
TRUNCATE TABLE OrderTransaction;

      
-- ORDER LINE ITEMS  
CREATE TABLE OrderLineItems ( 
	OrderLineItemID INT IDENTITY(1,1) PRIMARY KEY, 
    OrderID INT NOT NULL, 
    ProductID INT NOT NULL, 
    Quantity INT NOT NULL CHECK (Quantity > 0), 
    UOM VARCHAR(50) NULL, 
    Rate DECIMAL(18,2) NOT NULL,          
    DiscountID INT NULL, 
    TaxID INT NULL,                         
    Amount DECIMAL(18,2) NULL,              
    CreatedOn DATETIME NOT NULL DEFAULT SYSDATETIME(), 
    UpdatedOn DATETIME NULL, 
    CONSTRAINT FK_OLI_Order FOREIGN KEY (OrderID) REFERENCES OrderTransaction(OrderID), 
    CONSTRAINT FK_OLI_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID), 
    CONSTRAINT FK_OLI_Discount FOREIGN KEY (DiscountID) REFERENCES Discount(DiscountID), 
    CONSTRAINT FK_OLI_Tax FOREIGN KEY (TaxID) REFERENCES Taxation(TaxID) 
    ); 
-- Truncate Table Order Line Items
TRUNCATE TABLE OrderLineItems;
---------------------------------------------------------------------------------------------------------


-- Insert into Customer 
INSERT INTO Customer (CustomerName, City, State, Country)
VALUES 
('Haynes', 'Gandhinagar', 'Gujrat', 'India'),
('Sneha', 'Bangalore', 'Karnataka', 'India'),
('Tamanna', 'Delhi', 'Delhi', 'India'),
('Janaki', 'Hyderabad', 'Telangana', 'India'),
('Krishna', 'Hyderabad', 'Telangana', 'India'),
('Rashmi', 'Noida', 'Uttar Pradesh', 'India'),
('Akhila', 'Gandhinagar', 'Gujrat', 'India'),
('Pranjali', 'Mumbai', 'Maharashtra', 'India'),
('Rohit', 'Gandhinagar', 'Gujrat', 'India'),
('Gaurav', 'Pune', 'Maharashtra', 'India');
Select *  from Customer;


-- Insert into Product
INSERT INTO Product (ProductName, ManufacturingDate, ShelfLifeInMonths, Rate, Quantity)
VALUES
('Laptop','2025-01-10', 24, 65000.00, 30),
('Smartphone','2025-02-15', 18, 45000.00, 50),
('Tablet','2025-03-20', 18, 30000.00, 40),
('Monitor','2025-01-05', 36, 12000.00, 25),
('Keyboard','2025-04-12', 48, 1500.00, 100),
('Mouse','2025-04-18', 48, 800.00, 120),
('Printer','2025-02-22', 24, 9000.00, 15),
('WiFi Router','2025-03-28', 36, 3500.00, 35),
('External Hard Drive','2025-01-09', 24, 6000.00, 20),
('Webcam','2025-02-11', 36, 2500.00, 60);
Select * from Product;


-- Insert into Taxation 
INSERT INTO Taxation (TaxName, TaxTypeApplicable, TaxAmount, ApplicableYorN)
VALUES
-- PRODUCT-LEVEL TAXES 
('GST 5%', 'Products', 5.00, 'Y'),
('GST 12%', 'Products', 12.00, 'Y'),
('GST 18%', 'Products', 18.00, 'Y'),
('GST 28%', 'Products', 28.00, 'Y'),

-- Non-Taxable Product 
('GST Exempt', 'Products', NULL, 'N'),

-- ORDER-LEVEL TAXES
('Service Charge 5%', 'Orders', 5.00, 'Y'),
('Service Charge 10%', 'Orders', 10.00, 'Y'),
('Packaging Tax 2%', 'Orders', 2.00, 'Y'),
('Delivery Tax', 'Orders', NULL, 'N');
Select * from Taxation;


-- Insert into Discount
INSERT INTO Discount (ProductID, DiscountAmount, DiscountPercentage, Status)
VALUES    
(1, NULL, 8.00, 'Active'),     -- Laptop
(2, 100.00, NULL, 'Active'),   -- Smartphone
(3, NULL, 5.00, 'Active'),     -- Tablet
(4, 1000.00, NULL, 'Active'),  -- Monitor
(5, NULL, 10.00, 'Active'),    -- Keyboard
(6, NULL, 5.00, 'Active'),     -- Mouse
(7, 500.00, NULL, 'Active'),   -- Printer
(8, NULL, 12.00, 'Active'),    -- WiFi Router
(9, 750.00, NULL, 'Active'),   -- External Hard Drive
(10, NULL, 7.00, 'Active');    -- Webcam
select * from Discount;
                 
--------------------------------------------------------------------------------------------
-- Delete Column DiscountId from OrderTransaction
-- Drop the foreign key constraint 
ALTER TABLE OrderTransaction
DROP CONSTRAINT FK_Order_Discount;

-- Drop the DiscountID column
ALTER TABLE OrderTransaction
DROP COLUMN DiscountID;
--------------------------------------------------------------------------------------------

-- Insert into OrderTransaction
INSERT INTO OrderTransaction(CustomerID, TaxID, TotalAmount)
VALUES(2, 6, 118731.9),
(4, 8, 816),
(1, 7, 20303.8),
(3, 9, 62790);
select * from OrderTransaction;


-- Insert into OrderLineItems
INSERT INTO OrderLineItems (OrderID, ProductID, Quantity, UOM, Rate, DiscountID, TaxID, Amount)
VALUES (1, 1, 1, 'Nos', 65000, 1, 1, 62790),
(1, 2, 1, 'Nos', 45000, 2, 2, 50288),
(2, 6, 1, 'Nos', 800, 6, 1, 800),
(3, 10, 2, 'Nos', 2500, 10, 2, 5208),
(3, 7, 1, 'Nos', 9000, 7, 3, 10030),
(3, 8, 1, 'Nos', 3500, 8, 5, 3220),
(4, 1, 1, 'Nos', 65000, 1, 1, 62790);
select * from OrderLineItems;



