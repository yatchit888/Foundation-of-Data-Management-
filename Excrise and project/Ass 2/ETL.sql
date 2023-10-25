CREATE DATABASE GBC_Superstore;

USE GBC_Superstore;

CREATE TABLE `records` (
  `OrderNo` varchar(4) NOT NULL,
  `OrderID` varchar(15) NOT NULL,
  `CustomerID` varchar(8) NOT NULL,
  `PostalCode` varchar(5) NOT NULL,
  `ProductID` varchar(15) NOT NULL,
  PRIMARY KEY (`OrderNo`),
  UNIQUE KEY `OrderNo_UNIQUE` (`OrderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customers` (
  `CustomerID` varchar(8) NOT NULL,
  `CustomerName` text NOT NULL,
  `Segment` text NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `CustomerID_UNIQUE` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `addresses` (
  `PostalCode` varchar(5) NOT NULL,
  `Country/Region` text NOT NULL,
  `State` text NOT NULL,
  `City` text NOT NULL,
  `Region` text NOT NULL,
  PRIMARY KEY (`PostalCode`),
  UNIQUE KEY `PostalCode_UNIQUE` (`PostalCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `orders` (
  `OrderID` varchar(15) NOT NULL,
  `OrderDate` DATE NOT NULL,
  `ShipDate` DATE NOT NULL,
  `ShipMode` text NOT NULL,
  `Return_status` text NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE KEY `OrderID_UNIQUE` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `products` (
  `ProductID` varchar(15) NOT NULL,
  `Category` text NOT NULL,
  `SubCategory` text NOT NULL,
  `ProductName` text NOT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `ProductID_UNIQUE` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sales` (
  `OrderNo` varchar(4) NOT NULL,
  `Sales` text NOT NULL,
  `Quantity` int NOT NULL,
  `Discount` double NOT NULL,
  `Profit` text NOT NULL,
  `Price` text NOT NULL,
  PRIMARY KEY (`OrderNo`),
  UNIQUE KEY `OrderNo_UNIQUE` (`OrderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOAD DATA INFILE 'C:\Users\yatch\Desktop\Foundation of Data Management\Ass 2\orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ';' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\Users\yatch\Desktop\Foundation of Data Management\Ass 2\addresses.csv'
INTO TABLE addresses
FIELDS TERMINATED BY ';'ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

ALTER TABLE products MODIFY COLUMN ProductName VARCHAR(250) CHARACTER SET latin1;
SET NAMES utf8; -- or SET NAMES latin1; or the appropriate character set

LOAD DATA INFILE 'C:\Users\yatch\Desktop\Foundation of Data Management\Ass 2\products.csv'
INTO TABLE products
FIELDS TERMINATED BY ';'ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\Users\yatch\Desktop\Foundation of Data Management\Ass 2\customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ';'ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\Users\yatch\Desktop\Foundation of Data Management\Ass 2\sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ';'ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\Users\yatch\Desktop\Foundation of Data Management\Ass 2\records.csv'
INTO TABLE records
FIELDS TERMINATED BY ';'ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

ALTER TABLE `gbc_superstore`.`records` 
ADD INDEX `FK_OrderShip_idx` (`OrderID` ASC) VISIBLE,
ADD INDEX `FK_OrderCustomer_idx` (`CustomerID` ASC) VISIBLE,
ADD INDEX `FK_OrderAddress_idx` (`PostalCode` ASC) VISIBLE,
ADD INDEX `FK_OrderProduct_idx` (`ProductID` ASC) VISIBLE;
;
ALTER TABLE `gbc_superstore`.`records` 
ADD CONSTRAINT `FK_OrderShip`
  FOREIGN KEY (`OrderID`)
  REFERENCES `gbc_superstore`.`orders` (`OrderID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_OrderSales`
  FOREIGN KEY (`OrderNo`)
  REFERENCES `gbc_superstore`.`sales` (`OrderNo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_OrderCustomer`
  FOREIGN KEY (`CustomerID`)
  REFERENCES `gbc_superstore`.`customers` (`CustomerID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_OrderAddress`
  FOREIGN KEY (`PostalCode`)
  REFERENCES `gbc_superstore`.`addresses` (`PostalCode`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `FK_OrderProduct`
  FOREIGN KEY (`ProductID`)
  REFERENCES `gbc_superstore`.`products` (`ProductID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

SELECT COUNT(*) FROM records;
SELECT * FROM records WHERE OrderNo NOT IN (SELECT OrderNo FROM sales);
SELECT * FROM records WHERE CustomerID NOT IN (SELECT CustomerID FROM customers);
SELECT * FROM records WHERE OrderID NOT IN (SELECT OrderID FROM orders);
SELECT * FROM records WHERE ProductID NOT IN (SELECT ProductID FROM products);
SELECT * FROM records WHERE PostalCode NOT IN (SELECT PostalCode FROM addresses);

SELECT COUNT(*) FROM customers;
SELECT * FROM customer WHERE CustomerID IS NULL;
SELECT * FROM customer WHERE CustomerID NOT IN (SELECT CustomerID FROM records);

SELECT COUNT(*) FROM addresses;
SELECT * FROM addresses WHERE PostalCode IS NULL;
SELECT * FROM addresses WHERE PostalCode NOT IN (SELECT PostalCode FROM records);

SELECT COUNT(*) FROM products;
SELECT * FROM product WHERE ProductID IS NULL;
SELECT * FROM product WHERE ProductID NOT IN (SELECT ProductID FROM records);

SELECT COUNT(*) FROM sales;
SELECT * FROM sales WHERE OrderNo IS NULL;
SELECT * FROM sales WHERE OrderNo NOT IN (SELECT OrderNo FROM records);

SELECT COUNT(*) FROM orders;
SELECT * FROM orders WHERE OrderID IS NULL;
SELECT * FROM orders WHERE OrderID NOT IN (SELECT OrderID FROM records);