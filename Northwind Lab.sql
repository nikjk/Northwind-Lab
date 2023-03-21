-- Select all the rows from the "Customers" table. 
SELECT * FROM Customers;

-- Get distinct countries from the Customers table.
SELECT DISTINCT Country FROM Customers;

-- Get all the rows from the table Customers where the Customer�s ID starts with �BL�.
SELECT * FROM Customers 
WHERE CustomerID LIKE 'BL%';

-- Get the first 100 records of the orders table. DISCUSS: Why would you do this? What else would you likely need to include in this query?
-- You would do this so you to look for data patterns and trends, or for performance. By pulling all records instead of limiting them you could risk using too many resources on the database.
-- Other things you would want to include in this query is showing specific columns, or filtering by specific criteria instead of just showing the first 100. 
SELECT TOP 100 *
FROM Orders;

-- Get all customers that live in the postal codes 1010, 3012, 12209, and 05023.
SELECT * FROM Customers
WHERE PostalCode IN ('1010', '3012', '12209', '05023'); 

-- Get all orders where the ShipRegion is not equal to NULL.
SELECT * FROM Orders
WHERE ShipRegion IS NOT NULL;

-- Get all customers ordered by the country, then by the city.
SELECT * 
FROM Customers
ORDER BY Country, City;

-- Add a new customer to the customers table. You can use whatever values.
INSERT INTO Customers
VALUES ('NHA', 'National Heritage Academies', 'Nik Kuehn', 'System Administrator', '3850 Broadmoor AVE SE', 'Grand Rapids', NULL, '49512', 'USA', '6169542253', NULL);

-- Update all ShipRegion to the value �EuroZone� in the Orders table, where the ShipCountry is equal to France.  
UPDATE Orders
SET ShipRegion = 'EuroZone'
WHERE ShipCountry = 'France';

-- Delete all orders from OrderDetails that have quantity of 1. 
DELETE FROM [Order Details] WHERE Quantity = 1;

-- Find the CustomerID that placed order 10290 (orders table).
SELECT CustomerID FROM Orders
WHERE OrderID = '10290';

-- Join the orders table to the customers table.
SELECT *
FROM Orders
JOIN Customers
ON Orders.CustomerID = Customers.CustomerID;

-- Get employees� firstname for all employees who report to no one.
SELECT FirstName FROM Employees
WHERE ReportsTo IS Null;

-- Get employees� firstname for all employees who report to Andrew.
SELECT FirstName FROM Employees
WHERE ReportsTo = '2';

-- OR

-- Get employees� firstname for all employees who report to Andrew.
SELECT FirstName
FROM Employees
WHERE ReportsTo IN (
	SELECT EmployeeID
	FROM Employees
	WHERE FirstName = 'Andrew'
);

----------------------------------------------------------------------------------------------------------------

--Optional additional query practice (extended challenge):
--Calculate the average, max, and min of the quantity at the orderdetails table, grouped by the orderid. 
SELECT OrderID,
	AVG(quantity) AS average_quantity,
    MAX(quantity) AS max_quantity,
    MIN(quantity) AS min_quantity
FROM [Order Details]
GROUP BY OrderID;

--Calculate the average, max, and min of the quantity at the orderdetails table.
SELECT AVG(quantity) AS average_quantity,
	   MAX(quantity) AS max_quantity,
	   MIN(quantity) AS min_quantity
FROM [Order Details];

--Find all customers living in London or Paris
SELECT * FROM Customers
WHERE City = 'London' OR City = 'Paris';

--Do an inner join, left join, right join on orders and customers tables. 
SELECT Orders.OrderID, Customers.CustomerID
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT Orders.OrderID, Customers.CustomerID
FROM Orders
LEFT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

SELECT Orders.OrderID, Customers.CustomerID
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

--Make a list of cities where customers are coming from. The list should not have any duplicates or nulls.
SELECT DISTINCT City FROM Customers;

--Show a sorted list of employees’ first names. 
SELECT FirstName FROM Employees
ORDER BY FirstName;	

--Find total for each order
SELECT OrderID, SUM(Quantity * UnitPrice) AS order_total 
FROM [Order Details]
GROUP BY OrderID;

--Get a list of all employees who got hired between 1/1/1994 and today
SELECT FirstName, LastName, HireDate FROM Employees
WHERE HireDate >= '1994-01-01' AND HireDate <= CURRENT_TIMESTAMP;

--Find how long employees have been working for Northwind (in years!)
SELECT FirstName, LastName, HireDate,
       FLOOR(DATEDIFF(day, HireDate, GETDATE()) / 365.0) AS years_of_service
FROM Employees;

--Get a list of all products sorted by quantity (ascending and descending order)
-- Ascending
SELECT ProductName,UnitsInStock FROM Products
ORDER BY UnitsInStock ASC;

-- Descending
SELECT ProductName,UnitsInStock FROM Products
ORDER BY UnitsInStock DESC;

--Find all products that are low on stock (quantity less than 6)
SELECT ProductName, UnitsInStock FROM Products
WHERE UnitsInStock < 6;

--Find a list of all discontinued products. 
SELECT ProductName FROM Products
WHERE Discontinued = 'TRUE';

--Find a list of all products that have Tofu in them.
SELECT ProductName FROM Products
WHERE ProductName LIKE '%Tofu%';

--Find the product that has the highest unit price. 
SELECT ProductName, UnitPrice FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products);

--Get a list of all employees who got hired after 1/1/1993
SELECT FirstName, LastName, HireDate FROM Employees
WHERE HireDate > '1993-01-01';

--Get all employees who have title : “Ms.” And “Mrs.”
SELECT * FROM Employees
WHERE TitleOfCourtesy = 'Ms.' OR TitleOfCourtesy = 'Mrs.';

--Get all employees who have a Home phone number that has area code 206
SELECT * FROM Employees
Where HomePhone LIKE '(206)%';
