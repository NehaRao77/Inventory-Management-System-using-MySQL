
-- Query1
-- Find how many stores are there to store the inventory
select store_name, count(*) 
from Inventory.Stores group by city;

-- Query2
-- Find how many orders were placed by staff
SELECT staff.staff_id, staff.First_name , count(*)
FROM Inventory.Staff staff
INNER JOIN inventory.Orders orders ON staff.staff_id=orders.staff_id
group by staff.staff_id;

-- Query3
-- How much inventory is  there in a stores
Select p.Product_id, p.Product_name, b.Brand_name, s.quantity from
production.products p , production.stocks s, Production.Brands b
where p.Product_Id = s.product_id and p.Brand_Id = b.brand_id;

-- Query4
--  Which Product has the Maximum Quantity
SELECT P.Product_Name, MAX(quantity) AS Max_Inventory
FROM Production.Stocks S, Production.Products P where 
P.product_id = s.product_id;


-- Query5
-- Check Stock Category whether it is a Small, Mid and Large Cap
SELECT Product_ID, Quantity,
CASE
    WHEN Quantity < 60  THEN 'Product is in Small-Cap'
    WHEN Quantity BETWEEN  60 AND 120 THEN 'Product is in Mid-Cap'
    ELSE 'The quantity is Large-cap'
END AS QuantityText
FROM Production.Stocks;

-- Query6
-- Using the Procedure get Product_Name  and Product_Price
DELIMITER //

CREATE PROCEDURE GetAllProduct()
BEGIN
	SELECT Product_Name,Product_Price  FROM Production.Products;
END //

DELIMITER ;

CALL GetAllProduct();

-- Query7
-- Find the Category of each Product

select P.Product_Name, C.Category_Name from 
Production.Products P , Production.Categories C
where  C.Category_id = P.Category_Id;

-- Query8
-- Select the customers whose First_Name starts with N and  Placed and Order from store=1

select * from inventory.customers C , inventory.Orders I where
C.First_Name like 'N%' and C.Customer_ID = I.Customer_ID and I.store_ID=1;