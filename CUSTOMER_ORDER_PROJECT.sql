CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Names VARCHAR(50),
  Email VARCHAR(100)
);

INSERT INTO Customers (CustomerID, Names, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com');

  CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
);

select * from Orders
INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);

  CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);

  ------TASK 1-------

  --1)

  SELECT * FROM Customers

  --2)

  SELECT NAMES,EMAIL
  FROM Customers
  WHERE Names LIKE 'J%'

  --3)

  SELECT OrderID,ProductName,OrderDate,Quantity
  FROM Orders

  --4

  SELECT COUNT(PRODUCTNAME) AS TOTAL_QUANTITY
  FROM Orders

  --5

  

  SELECT NAMES,PRODUCTNAME
  FROM 
  Customers C
  INNER JOIN Orders O
  ON C.CustomerID=O.CustomerID

  --6

  SELECT * FROM products
  WHERE Price > 10

  --7

  SELECT NAMES,OrderDate
  FROM 
  Customers C
  INNER JOIN Orders O
  ON C.CustomerID=O.CustomerID
  WHERE O.OrderDate >= '2023-07-05'

  --8

  SELECT AVG(PRICE) AS AVG_PRICE
  FROM Products

  --9

  SELECT Names,COUNT(QUANTITY) AS TOTAL_QUANTITY
  FROM 
  Customers C
  INNER JOIN Orders O
  ON C.CustomerID=O.CustomerID
  GROUP BY Names
  ORDER BY Names

 SELECT * FROM Orders

 --10

 SELECT ProductName FROM Orders WHERE Quantity IS NULL


 ---TASK -2-----

 --1

 SELECT TOP 5 NAMES,Quantity
 FROM Customers C
 INNER JOIN Orders O
 ON C.CustomerID=O.CustomerID
 ORDER BY Quantity DESC



--2

SELECT ProductName,AVG(Quantity) AS AVERAGE
FROM Orders
GROUP BY ProductName
ORDER BY AVERAGE

--3

SELECT NAMES,ProductName
FROM Orders O
INNER JOIN Customers C
ON O.CustomerID=C.CustomerID
WHERE O.Quantity IS NULL

--4

SELECT NAMES,ORDERID,PRODUCTNAME,QUANTITY
FROM Orders O
INNER JOIN Customers C
ON O.CustomerID=C.CustomerID
WHERE Names LIKE 'M%'

--5

SELECT SUM(QUANTITY) AS TOTAL_REVENUE
FROM Orders 

--6

SELECT Names,SUM(Price*Quantity) AS TOTAL_REVENUE
FROM ORDERS O
INNER JOIN Products P
ON O.ProductName=P.ProductName
INNER JOIN Customers C
ON C.CustomerID=O.CustomerID
GROUP BY Names


--7

SELECT NAMES
FROM ORDERS O
INNER JOIN Customers C
ON O.CustomerID=C.CustomerID
WHERE Quantity >=1 


--8

SELECT 
c.Names 
FROM 
Customers c
 INNER JOIN Orders o1 
ON c.CustomerID = o1.CustomerID 
INNER JOIN 
Orders o2 
ON 
c.CustomerID = o2.CustomerID 
WHERE DATEDIFF(DAY, o1.OrderDate, o2.OrderDate) = 1;

--10

SELECT 
(
      COUNT(CASE WHEN o.Quantity >      avg.Quantity THEN 1 END) * 100.0) / COUNT(*) AS Percentage 
FROM 
Orders o 
CROSS JOIN 
(SELECT AVG(Quantity) AS Quantity FROM Orders) avg;


---TASK 3----

--1

SELECT NAMES 
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID=O.CustomerID
WHERE ProductName = ALL(SELECT ProductName FROM Orders)

--2

SELECT DISTINCT ProductName , Names
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID=O.CustomerID
WHERE Names = ALL(SELECT Names FROM Customers)

--3---DOUBT

SELECT p.ProductName 
FROM Products p INNER JOIN Orders o 
ON p.ProductName = o.ProductName 
GROUP BY p.ProductName 
HAVING COUNT(DISTINCT o.CustomerID) > (SELECT COUNT(*) * 0.5 FROM Customers)


--4
 
(SELECT DISTINCT ProductName FROM Orders
WHERE CustomerID >=(SELECT COUNT(CustomerID)/2 FROM Orders))

--5



SELECT DISTINCT QUANTITY FROM ORDERS ORDER BY QUANTITY DESC

SELECT 



SELECT * FROM Orders
SELECT * FROM products
SELECT * FROM Customers

--5

SELECT TOP 5 CUSTOMERID,SUM(TOTALSALE)'REVENUE' FROM
(SELECT O.CustomerID,(O.Quantity*P.Price) 'TOTALSALE'
FROM ORDERS O
INNER JOIN Products P
ON O.ProductName=P.ProductName) AS CPO
GROUP BY CustomerID
ORDER BY SUM(TOTALSALE) DESC


--6

SELECT * ,(
SELECT SUM(O.QUANTITY)
FROM Orders O
WHERE O.CustomerID <=O1.CUSTOMERID)
AS RUNNING_TOTAL
FROM ORDERS AS O1

--7




--8

SELECT CustomerID,SUM(TotalSale) FROM
(SELECT O.CustomerID ,(O.Quantity*P.Price) 'TotalSale'
FROM Orders O
INNER JOIN Products P
ON O.ProductName=P.ProductName
WHERE DATEDADD(Day,-30,MAX(ORDERDATE)) AS CPO
GROUP BY CustomerID

--9


SELECT c.CustomerID, c.Names 
FROM 
Customers c 
WHERE NOT EXISTS 
	( SELECT 1 FROM 
		( SELECT DISTINCT 
			DATEPART(MONTH, OrderDate) AS Month 
			FROM Orders 
				WHERE DATEPART(YEAR, OrderDate) = 2023 ) m 
					WHERE NOT EXISTS 
						( SELECT 1 FROM Orders o 
							WHERE o.CustomerID = c.CustomerID 
								AND DATEPART(MONTH, o.OrderDate) = m.Month ) )





