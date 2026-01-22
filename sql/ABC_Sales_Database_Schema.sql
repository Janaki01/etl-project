-- customer TABLE
CREATE TABLE IF NOT EXISTS customer ( 
	customerid SERIAL PRIMARY KEY, 
    customername VARCHAR(200) NOT NULL, 
    address1 VARCHAR(200), 
    address2 VARCHAR(200), 
    city VARCHAR(100), 
    state VARCHAR(100), 
    country VARCHAR(100), 
    status VARCHAR(50) NOT NULL DEFAULT 'Active', 
    createdOn TIMESTAMP NOT NULL DEFAULT 
    CURRENT_TIMESTAMP, 
    updatedon  TIMESTAMP
    );   

 -- product TABLE 
CREATE TABLE IF NOT EXISTS product ( 
	productid SERIAL PRIMARY KEY, 
    productname VARCHAR(200) NOT NULL, 
    manufacturingdate DATE,
    shelflifeinmonths INT, 
    rate DECIMAL(18,2) NOT NULL, 
    quantity INT NOT NULL DEFAULT 0,         -- current stock 
    createdOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    UpdatedOn TIMESTAMP 
	); 


-- discount 
CREATE TABLE IF NOT EXISTS discount ( 
	discountid SERIAL PRIMARY KEY, 
    productid INT,                        
    discountamount DECIMAL(18,2),        
    discountpercentage DECIMAL(5,2),      
    status VARCHAR(50) NOT NULL DEFAULT 'Active', 
    CreatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    UpdatedOn TIMESTAMP, 
    CONSTRAINT fk_discount_product FOREIGN KEY (productid) REFERENCES product(productid) 
    ); 
 -- Truncate Table discount
TRUNCATE TABLE discount;


-- taxation 
CREATE TABLE IF NOT EXISTS taxation ( 
    taxidINT SERIAL PRIMARY KEY, 
    taxname VARCHAR(200) NOT NULL, 
    taxtypeapplicable VARCHAR(50) NOT NULL CHECK (taxtypeapplicable IN ('orders','products')), 
    taxamount DECIMAL(18,2),    
    applicableyorn CHAR(1) NOT NULL CHECK (applicableyorn IN ('Y','N')), 
    createdon TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    UpdatedOn TIMESTAMP NULL 
    ); 
-- Truncate Table taxation
TRUNCATE TABLE taxation;


-- order TRANSACTION 
CREATE TABLE IF NOT EXISTS ordertransaction ( 
	orderid SERIAL PRIMARY KEY, 
    customerid INT NOT NULL, 
    discountid INT, 
    taxid INT,                              
    totalamount DECIMAL(18,2),              
    createdon TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    UpdatedOnpdatedOn TIMESTAMP, 
    CONSTRAINT fk_order_customer FOREIGN KEY (customerid) REFERENCES customer(customerid), 
    CONSTRAINT fk_order_discount FOREIGN KEY (discountid) REFERENCES discount(discountid), 
    CONSTRAINT fk_order_tax FOREIGN KEY (taxid) REFERENCES taxation(taxid) 
    ); 
-- Truncate Table order Transaction
TRUNCATE TABLE ordertransactionrdertransaction;

      
-- order LINE ITEMS  
CREATE TABLE IF NOT EXISTS orderlineitems ( 
	orderlineitemid SERIAL PRIMARY KEY, 
    orderid INT NOT NULL, 
    productid INT NOT NULL, 
    quantity INT NOT NULL CHECK (quantity > 0), 
    uom VARCHAR(50), 
    rate DECIMAL(18,2) NOT NULL,          
    discountid INT, 
    taxid INT,                         
    amount DECIMAL(18,2),              
    createdon TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), 
    updatedon TIMESTAMP, 
    CONSTRAINT fk_oli_order FOREIGN KEY (orderid) REFERENCES orderTransaction(orderid), 
    CONSTRAINT fk_oli_product FOREIGN KEY (productid) REFERENCES product(productid), 
    CONSTRAINT fk_oli_discount FOREIGN KEY (discountid) REFERENCES discount(discountid), 
    CONSTRAINT fk_oli_tax FOREIGN KEY (taxid) REFERENCES taxation(taxid) 
    ); 
-- Truncate Table order Line Items
TRUNCATE TABLE orderlineitems;
---------------------------------------------------------------------------------------------------------


-- Insert into customer 
INSERT INTO customer (customername, city, state, country)
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
Select *  from customer;


-- Insert into product
INSERT INTO product (productname, manufacturingdate, shelflifeinmonths, rate, quantity)
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
Select * from product;


-- Insert into taxation 
INSERT INTO taxation (taxname, taxtypeapplicable, taxamount, applicableyorn)
VALUES
-- product-LEVEL taxES 
('GST 5%', 'Products', 5, 'Y'),
('GST 12%', 'Products', 12, 'Y'),
('GST 18%', 'Products', 18, 'Y'),
('GST 28%', 'Products', 28, 'Y'),

-- Non-taxable product 
('GST Exempt', 'Products', NULL, 'N'),

-- order-LEVEL taxES
('Service Charge 5%', 'Orders', 5, 'Y'),
('Service Charge 10%', 'Orders', 10, 'Y'),
('Packaging Tax 2%', 'Orders', 2, 'Y'),
('Delivery Tax', 'Orders', NULL, 'N');
Select * from taxation;


-- Insert into discount
INSERT INTO discount (productid, discountamount, discountpercentage, status)
VALUES    
(1, NULL, 8, 'Active'),     -- Laptop
(2, 100, NULL, 'Active'),   -- Smartphone
(3, NULL, 5, 'Active'),     -- Tablet
(4, 1000, NULL, 'Active'),  -- Monitor
(5, NULL, 10, 'Active'),    -- Keyboard
(6, NULL, 5, 'Active'),     -- Mouse
(7, 500, NULL, 'Active'),   -- Printer
(8, NULL, 12, 'Active'),    -- WiFi Router
(9, 750, NULL, 'Active'),   -- External Hard Drive
(10, NULL, 7, 'Active');    -- Webcam
select * from discount;
                 
--------------------------------------------------------------------------------------------
-- Delete Column discountid from orderTransaction
-- Drop the foreign key constraint 
ALTER TABLE orderTransaction
DROP CONSTRAINT FK_order_discount;

-- Drop the discountid column
ALTER TABLE orderTransaction
DROP COLUMN discountid;
--------------------------------------------------------------------------------------------

-- Insert into orderTransaction
INSERT INTO ordertransaction(customerid, taxid, totalamount)
VALUES(2, 6, 118731.9),
(4, 8, 816),
(1, 7, 20303.8),
(3, 9, 62790);
select * from ordertransaction;


-- Insert into orderlineitems
INSERT INTO orderlineitems (orderid, productid, quantity, uom, rate, discountid, taxid, amount)
VALUES (1, 1, 1, 'Nos', 65000, 1, 1, 62790),
(1, 2, 1, 'Nos', 45000, 2, 2, 50288),
(2, 6, 1, 'Nos', 800, 6, 1, 800),
(3, 10, 2, 'Nos', 2500, 10, 2, 5208),
(3, 7, 1, 'Nos', 9000, 7, 3, 10030),
(3, 8, 1, 'Nos', 3500, 8, 5, 3220),
(4, 1, 1, 'Nos', 65000, 1, 1, 62790);
select * from orderlineitems;
