
-- create Database
CREATE database Production;
use Production;

-- create tables
DROP TABLE IF EXISTS `Production.Categories`;


select * from Production.Categories;
CREATE TABLE Production.Categories (
	Category_Id INT PRIMARY KEY,
	Category_Name VARCHAR (255) NOT NULL
);




DROP TABLE IF EXISTS `Production.Brands`;
CREATE TABLE Production.Brands (
	Brand_Id INT PRIMARY KEY,
	Brand_Name VARCHAR (50) NOT NULL
);

select * from Production.Products;

DROP TABLE IF EXISTS `Production.Products`;
CREATE TABLE Production.Products (
	Product_Id INT PRIMARY KEY,
	Product_Name VARCHAR (255) NOT NULL,
	Brand_Id INT NOT NULL,
	Category_Id INT NOT NULL,
	Product_Price DECIMAL (5, 2) NOT NULL,
	FOREIGN KEY (Category_Id) REFERENCES Production.categories (Category_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Brand_Id) REFERENCES Production.brands (Brand_Id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE DATABASE Inventory;
USE Inventory;



alter table inventory.customers drop column middle_name;
DROP TABLE IF EXISTS `Inventory.Customers`;
CREATE TABLE Inventory.Customers (
	Customer_Id INT PRIMARY KEY,
	First_Name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	Cell_No VARCHAR (25),
	Email_Address VARCHAR (50) NOT NULL,
	Street VARCHAR (255),
	City VARCHAR (50),
	State VARCHAR (25),
	Postal_Code VARCHAR (7)
);

DROP TABLE IF EXISTS `Inventory.Stores`;
CREATE TABLE Inventory.Stores (
	Store_Id INT PRIMARY KEY,
	Store_Name VARCHAR (255) NOT NULL,
	Store_Phone VARCHAR (15),
	Store_Email VARCHAR (255),
	Street VARCHAR (255),
	City VARCHAR (255),
	State VARCHAR (10),
	Zip_Code VARCHAR (7)
);

DROP TABLE IF EXISTS `Inventory.Staff`;
CREATE TABLE Inventory.Staff (
	Staff_Id INT PRIMARY KEY,
	First_Name VARCHAR (50) NOT NULL,
	Last_Name VARCHAR (50) NOT NULL,
	Staff_Email VARCHAR (255) NOT NULL UNIQUE,
	Staff_Phone VARCHAR (25),
	Store_Id INT NOT NULL,
	Staff_Manager_Id INT,
	FOREIGN KEY (Store_Id) REFERENCES Inventory.Stores (Store_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Staff_Manager_Id) REFERENCES Inventory.Staff (Staff_Id) ON DELETE NO ACTION ON UPDATE NO ACTION
);


select * from inventory.Orders;




DROP TABLE IF EXISTS `Inventory.Orders`;
CREATE TABLE Inventory.Orders (
	Order_Id INT  PRIMARY KEY,
	Customer_Id INT,
	Order_Status INT NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	Order_Date DATE NOT NULL,
	Required_Date DATE NOT NULL,
	Shipped_Date DATE,
	Store_Id INT NOT NULL,
	Staff_Id INT NOT NULL,
	FOREIGN KEY (Customer_Id) REFERENCES Inventory.Customers (Customer_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Store_Id) REFERENCES Inventory.Stores (Store_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Staff_Id) REFERENCES Inventory.Staff (Staff_Id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

select * from inventory.Order_Items;
select * from Production.Products;
select * from inventory.Orders;
DROP TABLE IF EXISTS `Inventory.Order_Items`;
CREATE TABLE Inventory.Order_Items (
	Order_Id INT,
	Item_Id INT,
	Product_Id INT NOT NULL,
	Quantity INT NOT NULL,
	List_Price DECIMAL (10, 2) NOT NULL,
	Discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (Order_Id, Item_Id),
	FOREIGN KEY (Order_Id) REFERENCES Inventory.Orders (Order_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Product_Id) REFERENCES Production.Products (Product_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

select * from Production.Stocks;


DROP TABLE IF EXISTS `Production.Stocks`;
CREATE TABLE Production.Stocks (
	Store_Id INT,
	Product_Id INT,
	Quantity INT,
	PRIMARY KEY (Store_Id, Product_Id),
	FOREIGN KEY (Store_Id) REFERENCES Inventory.Stores (Store_Id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Product_Id) REFERENCES Production.Products (Product_Id) ON DELETE CASCADE ON UPDATE CASCADE
);

