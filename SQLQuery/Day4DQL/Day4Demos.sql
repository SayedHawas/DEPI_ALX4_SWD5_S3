--Day 4
/*
Querying Multiple Tables :-
-----------------------------------------

    -- Lessons :- 
	----------------
	 
	        1- Understanding Joins .
			2- Querying with Inner Joins.
			3- Querying with Outer Joins.
			4- Querying with Cross Joins and Self-Joins.

Querying Multiple Tables
 Inner Join                 Done 
 Outer Join                 Done  
   - Left Outer Join        Done
   - Right Outer Join       Done
   - Full Outer Join        Done
Cross Join                  Done
Self - Join 
*/
-- Join 
--inner join 
-- create dataBase DB 
-- create table department 
-- Create table Employees 
------------------------------
--EX Join 
------------------------------------------
--Code To Create 2 table
GO
Create database Moduel4DB
go
USE Moduel4DB
GO
CREATE TABLE [dbo].[Departments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[salary] [decimal](9, 2) NULL,
	[Job] [nvarchar](50) NULL,
	[departmentID] [int] NULL,
 CONSTRAINT [PK_Emps] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

GO
INSERT [dbo].[Departments] ([ID], [Name]) VALUES (1, N'sales')
GO
INSERT [dbo].[Departments] ([ID], [Name]) VALUES (2, N'IT')
GO
INSERT [dbo].[Departments] ([ID], [Name]) VALUES (3, N'HR')
GO
INSERT [dbo].[Departments] ([ID], [Name]) VALUES (4, N'Training')
GO
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

GO
INSERT employees ([ID], [Name], [salary], [Job], [departmentID]) VALUES (1, N'ahmed Ali', CAST(4000.00 AS Decimal(9, 2)), N'DBA', 2)
GO	   
INSERT employees ([ID], [Name], [salary], [Job], [departmentID]) VALUES (2, N'retaj', CAST(5000.00 AS Decimal(9, 2)), N'Developer', 4)
GO	   
INSERT employees ([ID], [Name], [salary], [Job], [departmentID]) VALUES (3, N'Mohammed', CAST(6000.00 AS Decimal(9, 2)), N'HR', 3)
GO	   
INSERT employees ([ID], [Name], [salary], [Job], [departmentID]) VALUES (4, N'Maraim', CAST(1000.00 AS Decimal(9, 2)), N'developer', NULL)
GO
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
----------------------------------------------------------------------------- 
select * from departments
select * from Employees


SELECT e.ID , e.Name,e.Job,d.Name As [Department Name]
FROM Departments as d Inner Join Employees as e
ON d.ID = e.departmentID 

--ANSI 92
SELECT e.ID , e.Name,e.Job,d.Name As [Department Name]
FROM Departments as d  Join Employees as e
ON d.ID = e.departmentID 

--89
SELECT e.ID , e.Name,e.Job,d.Name As [Department Name]
FROM Departments as d  , Employees as e
where d.ID = e.departmentID


--ANSI 92
SELECT Top 1 e.ID , e.Name,e.Job,d.Name As [Department Name]   --4   --6 Top
FROM Departments as d  Join Employees as e                     --1
ON d.ID = e.departmentID                                       --2
where d.Name like '%i%'                                        --3
Order by Job desc                                              --5                  

--All Row in Department 
Select *
From  Departments as d Left Outer Join Employees as e 
ON  d.ID = e.departmentID


Select *
From  Departments as d Left Join Employees as e 
ON  d.ID = e.departmentID

Select *
From  Departments as d Left Join Employees as e 
ON  d.ID = e.departmentID
where e.Name Is Not NULL

Select *
From  Departments as d right outer Join Employees as e 
ON  d.ID = e.departmentID

Select *
From  Departments as d right Join Employees as e 
ON  d.ID = e.departmentID

Select *
From  Departments as d full outer Join Employees as e 
ON  d.ID = e.departmentID



select e.*,d.Name
from Departments as d  join Employees as e  
on d.ID =e.departmentID

select e.*,d.Name
from Departments as d right join Employees as e  
on d.ID =e.departmentID


select e.*,d.Name
from Departments as d left join Employees as e  
on d.ID =e.departmentID

select e.*,d.Name
from Departments as d full join Employees as e  
on d.ID =e.departmentID
--------------------------------------------------------------------------
--====================================================================================================================
/*
-- 1) Understanding Joins :-
----------------------------
   - T-SQL joins are used to combine rows from two or more tables.
   A) The FROM Clause and Virtual Tables :- 
   -------------------------------------
    - Virtual table will hold the output of the FROM clause and,
	   will be used subsequently by other phases of the SELECT statement, such as the WHERE clause.
	- The virtual table created by a FROM clause is a logical entity only. In SQL Server 2016, no physical table is created.
	- Table aliases improves the readability of the query, without affecting the performance.
	- It is strongly recommended that you use table aliases in your multi-table queries. 
  B) Join Terminology: Cartesian Product :- 
  ---------------------------------------
   - Cartesian product is the product of two sets. The product of a set of 2 items and a set of 6 items is a set of 12 items.
   - The product of a table with 10 rows and a table with 100 rows is a result set with 1,000 rows.  
   - Cartesian product occurs when two input tables are joined without considering any logical relationships.  
  C) Overview of Join Types :- 
  ------------------------------
   - (CROSS JOIN) adds all possible combinations of the two input tables' rows to the virtual table. Any filtering of the                      rows will happen in a WHERE clause. this operator is to be avoided. 
   -  (INNER JOIN) creates a Cartesian product, then filters the results using the predicate supplied in the ON clause,                         removing any rows from the virtual table that do not satisfy the predicate.
                   inner join is a very common type of join for retrieving rows with attributes that match across tables,
	               such as matching Customers to Orders by a common custid.  
   - (OUTER JOIN) creates a Cartesian product, then filters the results to find rows that match in each table. However,
                  all rows from one table are preserved, added back to the virtual table after the initial filter is applied.                  NULLs are placed on attributes where no matching values are found.

  D) T-SQL Syntax Choices :- 
  ---------------------------
   
           - Through the history of versions of SQL Server, 
		     the product has changed to keep pace with changes in the ANSI standards for the SQL language.
		   - In ANSI SQL-89, no (ON) operator was defined. 

		   - This syntax of ANSI SQL-89 is still supported by SQL Server 2016.
		   - ANSI SQL-89-style joins can easily become Cartesian products and cause performance problems. 
		   - The ANSI SQL-92 standard, support for the ON clause was added.
		   - The logical relationship between the tables is represented with the ON clause.
		   - As performance of query optimizer in SQL Server does not favor one syntax over the other.
*/

--JOIN using ANSI SQL-89
USE Northwind
SELECT * 
FROM Products AS P  ,  [Order Details] AS OD
WHERE P.ProductID = OD.ProductID
GO
--JOIN using ANSI SQL-92    -- recommended
USE Northwind
SELECT * 
FROM   Products AS P JOIN   [Order Details] AS OD
ON  P.ProductID = OD.ProductID
GO
/*
---------------------------------------------------------------------------------------------------------------------
-- Lesson 2) Querying with Inner Joins :- 
------------------------------------------
     A) Understanding Inner Joins :-
	 -------------------------------
	    - selects all rows from both tables as long as there is a match between the columns in both tables.
		- INNER JOIN are the most common types of queries to solve many business problems,
		  especially in highly normalized database environments.
		-  By expressing a logical relationship between the tables, 
		   you will retrieve only those rows with matching attributes present in both tables.
     B) Inner Join Syntax :- 
	 ------------------------
	   - Table aliases are preferred not only for the SELECT list, but also for expressing the ON clause.  
	   - INNER JOIN may be performed on a single matching attribute, or on multiple matching attributes.
	     Joins that match multiple attributes are called composite joins
	   - The order in which tables are listed and joined in the FROM clause does not matter to the SQL Server optimizer.
	   - Use the JOIN keyword once for each two tables in the FROM list. For a two-table query, specify one join.
	   - In Syntax both working :-  
		      A) With INNER     ( INNER JOIN )
			  B) Without INNER  ( JOIN )              -- Default Join is Inner in SQL .

	C) Inner Join Examples :- 
	-------------------------
*/

-- JOIN on a single matching attribute :-
USE Northwind
SELECT P.ProductID,P.ProductName,OD.Quantity,OD.Quantity
FROM   Products AS P JOIN   [Order Details] AS OD
ON  P.ProductID = OD.ProductID
GO

-- JOIN on two matching attributes :-
USE Northwind
SELECT DISTINCT C.City, C.Country
FROM   Employees AS E JOIN   Customers AS C
ON     E.Country = C.Country AND    E.City    = C.City        -- Result show Unique cities & countries in matches in both tables.
GO

-- Example For extended JOIN OR Multiple Join Or Nested Join :-
USE Northwind
SELECT E.EmployeeID,E.FirstName + ' ' + E.LastName AS 'Employee Name',C.CustomerID,C.CompanyName AS  'Customer Name',
	   O.OrderID,O.OrderDate
FROM   Customers AS C JOIN   Orders AS O
ON     C.CustomerID = O.CustomerID JOIN   Employees AS E
ON     O.EmployeeID = E.EmployeeID
GO                                     -- Result Show Data from 3 tables .
/*
---------------------------------------------------------------------------------------------------------------------
 -- Lesson 3) Querying with Outer Joins :-
 ------------------------------------------
   A) Understanding Outer Joins :-
   -------------------------------
        - Will retrieve not only rows with matching attributes,
		  but all rows present in one of the tables, whether or not there is a match in the other table.
		- Outer Joins :- 
		        LEFT OUTER :-  returns all rows from the left table with the matching rows in the right table. 
				               The result is NULL in the right side when there is no match.
				RIGHT OUTER :- returns all rows from the right table with the matching rows in the left table.
				               The result is NULL in the left side when there is no match.
				FULL OUTER :-  returns all rows from the left table and All from the right table. 
				               FULL OUTER JOIN combines the result of both LEFT and RIGHT joins.
	B) Outer Join Syntax :- 
	------------------------
	    - Outer joins are expressed using the keywords LEFT, RIGHT, or FULL preceding OUTER JOIN. 
		- As with inner joins, may be performed on a single matching attribute or on multiple matching attributes.
		- Unlike inner joins, the order in which tables are listed and joined in the FROM clause does matter,
		  because it will determine whether you choose LEFT or RIGHT for your join. 
        - To display only rows where no match exists,
		  add a test for NULL in a WHERE clause following an OUTER JOIN predicate. 
		- In Syntax both working :-
		      A) With OUTER ( LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN  )
			  B) Without OUTER  ( LEFT JOIN, RIGHT JOIN, FULL JOIN  
   C) Outer Join Examples :- 
   -------------------------
*/
-- Example for displays all customers and provides information about each customer's orders if any exist :-
USE Northwind
SELECT  C.CompanyName,C.Country,O.OrderDate
FROM    Customers AS C LEFT JOIN Orders AS O
ON   C.CustomerID = O.CustomerID
GO
-- Example displays only customers that have never placed an order:-
USE Northwind
SELECT  C.CompanyName,C.Country,O.OrderDate
FROM    Customers AS C LEFT JOIN Orders AS O
ON   C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL
GO

--------------------------------------------------------------------------------------------------------------------------
/*
-- Lesson 4) Querying with Cross Joins and Self-Joins :-
---------------------------------------------------------
  A) Understanding Cross Join :-  also called " Cartesian products " .
  -----------------------------
      - return all rows from the left table,
        Each row from the left table is combined with all rows from the right table.
	  - Combine each row from first table with each row from second table.
  B) Cross Join Syntax :-
  ------------------------
     - There is no matching of rows performed, and therefore no ON clause is required.
*/
-- CROSS JOIN ANSI-89

Select * from departments 
Select * from Employees

Select *
From  Departments as d Cross Join Employees as e 







USE northwind
SELECT su.companyname,sh.companyname
FROM suppliers AS su , shippers AS sh
GO

-- CROSS JOIN ANSI-92
USE northwind
SELECT su.companyname, sh.companyname
FROM   suppliers AS su CROSS JOIN shippers AS sh
GO





/*
    C) Understanding Self-Joins :-
	--------------------------------
        - Compare rows in same table to each other.
		- At least one alias required.
        - Return all employees and the name of the employeeís manager.
*/
GO
USE Northwind

GO
Select * from Employees

Select EmployeeID , FirstName , LastName , ReportsTo
From  Employees


Select e.EmployeeID , e.FirstName , e.LastName , M.FirstName AS Manager
From Employees as e Join Employees as M
On e.ReportsTo = M.EmployeeID 


Select e.EmployeeID , e.FirstName , e.LastName , ISNULL (M.FirstName ,'CEO') AS Manager 
From Employees as e full Join  Employees as M
On e.ReportsTo = M.EmployeeID 

-- Example for Employee with  manager when a manager exists (inner join):
USE Northwind
SELECT E.EmployeeID,
       E.firstname + ' ' + E.LastName AS 'Employee Name',
       M.firstname + ' ' + M.LastName AS 'Manager Name'
FROM   Employees E JOIN Employees M 
ON     E.ReportsTo = M.employeeID       -- Result show no EmployeeID 2 because there is no manager
GO

-- Example all employees with ID of manager (outer join). This will return NULL for the CEO:
USE Northwind
SELECT E.EmployeeID,
       E.firstname + ' ' + E.LastName AS 'Employee Name',
       M.firstname + ' ' + M.LastName AS 'Manager Name'
FROM   Employees E LEFT JOIN Employees M 
ON     E.ReportsTo = M.employeeID       -- Result show  EmployeeID 2 is no manager AS NULL
GO



--=======================================================================================================
--Ex2
-- Create Table As Souq Customers :-
CREATE TABLE SouqCustomers
(
       CustomerID INT,
	   FirstName NVARCHAR(50),
	   LirstName NVARCHAR(50),
	   Mail VARCHAR(100),
	   City VARCHAR(50)
)
GO

-- Insert Data in Table Souq Customers :-
INSERT INTO SouqCustomers
VALUES ( 1, 'Ahmed', 'Ali', 'Ahmed.Ali.Mohamed@live.com', 'Alexandria' ),
       ( 2, 'Sara', 'Mohamed', 'Sara.Mohamed@live.com', 'Alexandria' ),
	   ( 3, 'Walid', 'Ahmed', 'Walid.Ahmed@live.com', 'Cairo' ),
	   ( 4, 'Ghada', 'Ali', 'Ghada.Ali@live.com', 'Giza' )
GO

-- Create Table As Souq Orders :-
CREATE TABLE SouqOrders
(
       OrderID INT,
	   CustomerID INT,
	   OrderDate Datetime,
	   TotalPrice Money
)
GO

-- Insert Data in Table Souq Orders :-
INSERT INTO SouqOrders
VALUES ( 1, 1, GETDATE(), 500),
       ( 2, 1, GETDATE(), 100),
	   ( 3, 2, GETDATE(), 400)
GO

-- Show Both tables :-
SELECT * FROM   SouqCustomers
GO
SELECT * FROM   SouqOrders
GO

-- INNER JOIN to Show customers with orders :-
SELECT      DISTINCT SC.FirstName + ' ' + SC.LirstName AS FullName,	SC.Mail
FROM        SouqCustomers AS SC JOIN        SouqOrders    AS SO
ON          SC.CustomerID = SO.CustomerID
GO

-- OUTER JOIN to Show Customers Never make any order :- 
SELECT      DISTINCT SC.FirstName + ' ' + SC.LirstName AS FullName,SC.Mail
FROM        SouqCustomers AS SC LEFT JOIN   SouqOrders    AS SO
ON          SC.CustomerID = SO.CustomerID
WHERE SO.CustomerID IS NULL
GO

Select * from Employees where HireDate > '1993-10-17 00:00:00.000'


Select * from Employees 

Select  e1.*
From Employees as e1 Cross Join Employees as E2
Where E1.EmployeeID <> E2.EmployeeID AND E1.HireDate = E2.HireDate
--------------------------------------------------------
Select  * from Orders
Select * from [Order Details]
Select * from Products
---------------------------------------------------------
--nested Join 
SELECT TOP (5) o.OrderID, o.OrderDate, CU.CompanyName, e.FirstName, OD.ProductID, P.ProductName, C.CategoryName, OD.Quantity
FROM     Employees AS e INNER JOIN
                  Orders AS o ON e.EmployeeID = o.EmployeeID INNER JOIN
                  [Order Details] AS OD ON o.OrderID = OD.OrderID INNER JOIN
                  Products AS P ON P.ProductID = OD.ProductID INNER JOIN
                  Categories AS C ON C.CategoryID = P.CategoryID INNER JOIN
                  Customers AS CU ON CU.CustomerID = o.CustomerID
WHERE  (e.FirstName = 'Steven')
ORDER BY OD.Quantity DESC


SELECT Categories.CategoryName, Products.ProductName, Orders.OrderID, Employees.FirstName, [Order Details].Quantity, Orders.OrderDate
FROM     [Order Details] INNER JOIN
                  Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                  Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
                  Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                  Categories ON Products.CategoryID = Categories.CategoryID
WHERE  (Employees.FirstName = N'steven')
ORDER BY [Order Details].Quantity















--====================================== Extra --------------------------
-------------------------------------------
-- Join more than one table (Nested Join)
-- --------------------------------------
select * from Products
select * from Orders
select * from [Order Details]

USE northwind
SELECT orderdate, productname
FROM orders AS O INNER JOIN [order details] AS OD
ON O.orderid = OD.orderid INNER JOIN products AS P
ON OD.productid = P.productid
WHERE orderdate = '7/8/96'

--================ MOC Demo ================================
use Northwind
select * from products
select * from [order details]

select OrderID,od.productid,od.UnitPrice,ProductName
from [Order Details] as od,Products as p
where od.ProductID=p.ProductID

select OrderID,od.productid,od.UnitPrice,ProductName
from [Order Details] as od inner join  Products as p
on od.ProductID=p.ProductID

select OrderID,od.productid,od.UnitPrice,ProductName
from [Order Details] as od  right outer join  Products as p
on od.ProductID=p.ProductID

select OrderID,od.productid,od.UnitPrice,ProductName
from Products as p  left outer join [Order Details] as od  
on od.ProductID=p.ProductID

-------------------------------------------------------------
select orderid,od.productid,productname,od.unitprice,unitsinstock
from Products as p inner join [Order Details] as od
on p.ProductID=od.ProductID
where od.UnitPrice>100
-------------------------------------------------------------
select orderid,od.productid,productname,od.unitprice,unitsinstock
from Products as p inner join [Order Details] as od
on p.ProductID=od.ProductID
where od.UnitPrice between 50 and 100
-------------------------------------------------------------
select orderid,od.productid,productname,od.unitprice,unitsinstock
from Products as p inner join [Order Details] as od
on p.ProductID=od.ProductID
where od.UnitPrice between 50 and 100 and OrderID in (10420,10516,10535)
--------------------------------------------------------------
select orderid,od.productid,productname,od.unitprice,unitsinstock,companyname
from [Order Details] as od   inner join Products as p 
on p.ProductID=od.ProductID inner join Suppliers as s
on p.SupplierID=s.SupplierID
where od.UnitPrice between 50 and 100 and OrderID in (10420,10516,10535)
---------------------------------------------------------------
SELECT c.CUSTOMERID,CompanyName,OrderDate
FROM CUSTOMERS as c INNER JOIN ORDERS as o
ON c.CUSTOMERID=o.CUSTOMERID
ORDER BY c.CUSTOMERID
---------------------------------------------------------------
--left outer join
SELECT c.CUSTOMERID,c.CompanyName,o.CustomerID,o.OrderDate
FROM CUSTOMERS as c left outer join ORDERS as o
ON c.CUSTOMERID=o.CUSTOMERID
ORDER BY c.CUSTOMERID
---------------------------------------------------------------
SELECT c.CUSTOMERID,c.CompanyName,o.CustomerID,o.OrderDate
FROM CUSTOMERS as c left outer join ORDERS as o
ON c.CUSTOMERID=o.CUSTOMERID
where o.customerid is null
ORDER BY c.CUSTOMERID
---------------------------------------------------------------
--right outer join
SELECT  PRODUCTS.PRODUCTID, PRODUCTS.PRODUCTNAME, CATEGORIES.CATEGORYID, CATEGORIES.CATEGORYNAME
FROM PRODUCTS RIGHT OUTER JOIN CATEGORIES 
ON PRODUCTS.CATEGORYID = CATEGORIES.CATEGORYID
---------------------------------------------------------------
SELECT  PRODUCTS.PRODUCTID, PRODUCTS.PRODUCTNAME, CATEGORIES.CATEGORYID, CATEGORIES.CATEGORYNAME
FROM PRODUCTS RIGHT OUTER JOIN CATEGORIES 
ON PRODUCTS.CATEGORYID = CATEGORIES.CATEGORYID
WHERE PRODUCTS.CATEGORYID IS NULL
--------------------------------------------------------------
--full outer join
SELECT c.CustomerID ,c.city  ,c.country,e.firstname,e.lastname 
FROM employees e  FULL OUTER JOIN customers c
ON e.city = c.city 
--===============================================================================
select orderid,od.productid,productname,od.unitprice,unitsinstock,companyname
from [Order Details] as od   inner join Products as p 
on p.ProductID=od.ProductID  inner join Suppliers as s
on p.SupplierID=s.SupplierID
where od.UnitPrice between 50 and 100 and OrderID in (10420,10516,10535)
-------------------------------------------------------------
--acting as inner join 
select *
from Products cross join Categories
where Products.CategoryID=Categories.CategoryID
-------------------------------------------------------------
--self join
select emp.FirstName as employee,mgr.FirstName as manager
from Employees as emp inner join Employees as mgr
on emp.ReportsTo=mgr.EmployeeID
------------------------------------------------------------
select emp.FirstName as employee,mgr.FirstName as manager
from Employees as emp left outer join Employees as mgr
on emp.ReportsTo=mgr.EmployeeID
------------------------------------------------------------
--non-equi join
select emp1.FirstName,emp1.HireDate
from Employees as emp1 inner join Employees as emp2
on emp1.EmployeeID!=emp2.EmployeeID 
and emp1.HireDate=emp2.HireDate
--------------------------------


Select Getdate()
/*
-- Module 8) Using Built-In Functions :- 
 -----------------------------------------
   -- Lessons :-
   -------------
          - Writing Queries with Built-In Functions.
		  - Using Conversion Functions.
		  - Using Logical Functions.
		  - Using Functions to Work with NULL.
-----------------------------------------------
-- What is Functions in T-SQL ?
--------------------------------
 - A T-SQL routine that accepts parameters, performs an action, such as a complex calculation,
     and returns the result of that action as a value.
 - Functions hide the steps and the complexity from other code.
 - Function Operate  
                      A)- (Deterministic = return same result)
                      B)- (Non-Deterministic = may return different result each time) 
					  
-- Why We use Functions ? 
--------------------------
   - Functions can Use & Run almost anywhere .
   - To replace a stored procedure . 
   
   -- Functions Types :-
-------------------------
 1)- User-defined Functions :-       "Developing Course"

                             A) Scalar        :- Return a single value.
							 B) Table-Valued  :- Return a table.

 
 2)- Built-in Function :-   
                             A) Scalar    :- Working on a single row To return a single Value.             " Module Focus "
							 B) Aggregate :- Take one or more input To return a single summarizing value.  " Next Module "
							 C) Window    :- Working on sets of rows.                                      " In This Course"
							 D) Rowset    :- Return a virtual table can be used in a T-SQL statement.      "Admin Course"
*/
----------------------------------------------------------------------------------------------------------------------------------
-- Simple Examples For The Types of Built-in Functions That we will use :-
-- 1) Scalar Simple Example 
SELECT orderid,orderdate,YEAR(orderdate) AS orderyear   -- Scalar
FROM   Orders

-- 2) Aggregate Simple Example 
Select count(*) from Employees
SELECT COUNT(Quantity) AS RowsCount, AVG(Quantity) AS QuantityAverage
FROM  [Order Details]

-- 3) Window Simple Example 
SELECT TOP(10) productid, productname,unitprice,
	   RANK() OVER(ORDER BY unitprice DESC) AS 'Rank By Price' 
FROM   Products 
ORDER BY 'Rank By Price' 
-------------------------------------------------------------------------------------------------------------------------------------


/*
-- Using Conversion Functions :-
--------------------------------
  - Implicit conversion occurs automatically :- Follows data type precedence rules.
  - Use explicit conversion :-
                                A) When implicit would fail or is not permitted.
                                B) To override data type precedence.
 - Conversion Functions :- 
                           A) CAST    :-  To convert a value from one data type to another . " ANSI-Standard "
						   B) CONVERT :-  To convert a value from one data type to another . " SQL SERVER ONLY "
						   C) PARSE  :-  Converts strings to date, time, number types.     " SQL SERVER ONLY "  
						   D) TRY_PARS & TRY_CONVERT :-  like PARSE and CONVERT, But when failed conversions return NULL. 
*/

-- 1) CAST Syntax 
----------------
-- CAST(<Expression> AS DataType)
---------------------------------
-- CAST Example 1)   -- from DateTime to date
SELECT orderid,orderdate AS OrderDateTime,
	   CAST(orderdate AS DATE) AS OrderDateOnly  
FROM   Orders 

Select 'Total : ' + Cast (100 as nvarchar(5))

Select Concat('Total : ' ,100 ,' $')
-- CAST Example 2)    -- from Int to String
SELECT CAST(1 AS Varchar(1))    AS RESULT 

-- CAST Example 2)    -- from String to Decimal
SELECT CAST('20.33' AS decimal(4,2))    AS RESULT 

---------------------------------------------------
-- 2) Convert Syntax 
------------------
-- 1) Normal             CONVERT(DataType , <Expression> ), "Optional Format")
-- 2) With Format        CONVERT(DataType , <Expression> , "Optional Format Number")
--------------------------------------------------------
-- CONVERT Example 1)   -- from DateTime to date

Select  Convert (nvarchar(5) , 100 )+ ' Degree'
SELECT orderid,orderdate AS OrderDateTime,CONVERT(DATE , orderdate , 110) AS OrderDateOnly  
FROM Orders 

-- CONVERT Example 2)    -- from Int to String
SELECT CONVERT(Varchar(1) , 1)  AS RESULT 

-- CONVERT Example 2)    -- from String to Decimal
SELECT CONVERT(Decimal(4,2) , '20.33' )   AS RESULT 
------------------------------------------------------------
-- 3) Parse Syntax 
-----------------
-- 1) Normal          PARS (<String> AS DataType)
-- 2) With Culture    PARS (<String> AS DataType USING 'Culture Name') 
-----------------------------------------------------
-- Parse Example Normal
SELECT PARSE('02/12/2012' AS datetime2) AS Result
Select isDate('2-30-2025') -- MM,DD,YYYY
-- Parse Example Using Culture
SELECT PARSE('02/12/2012' AS datetime2 USING 'ar-EG') AS Result
-------------------------------------------------------------------------
/*
-- Why Try_Parse & Try_Convert ? 
---------------------------------
   - Some Conversion Never works 
   - If the data types are incompatible, 
   - such as attempting to convert a date to a numeric value,
   - (CAST,CONVERT,Parse)  will return an error.
   - So Try_Parse & Try_Convert Will Act Like (CONVERT,Parse) ,
   - AND When Conversion Failed Return NULL instead of Error.
   - Try_Parse Syntax = Parse Syntax
   - Try_Convert Syntax = Convert Syntax
*/
-- Conversion Failed with error like :-
-- CAST Error
SELECT CAST ( '12/12/2012' AS INT )

-- CONVERT Error
SELECT CONVERT ( INT , '12/12/2012' )
-- Parse Error
SELECT Parse ( '12/12/2012' AS INT )
-- USING Try_Parse    -- No Error
SELECT Try_Parse ( '12/12/2012' AS INT ) AS Result
-- USING Try_Convert  -- No Error
SELECT Try_Convert ( INT , '12/12/2012' ) AS Result
-----------------------------------------------------------------------------------------
Select ISNUMERIC('100#')
/* 
  -- Logical Functions :- 
  -------------------------
    - Logical functions that evaluate an expression and return a scalar result.
	- Logical functions :- 
	                      A) ISNUMERIC() :- 
						               - Tests whether an input expression is a valid numeric data type.
						               - Returns a 1 when the input evaluates to any valid numeric type.
									   - Returns 0 otherwise
  
						  B) IIF()  :- 
						               - IIF returns one of two values, depending on a logical test.
									   - Like two-outcome CASE expression.
									   - You may nest a IIF function within another IIF, a maximum level 10.
									   - IIF give error if values NULL.

						  C) CHOOSE() :-
						               - returns an item from a list as specified by an index value.
									   - if the index value not a value in the list, will return a NULL.
*/

-- ISNUMERIC Syntax :-
-- ISNUMERIC ( <Expression> )
------------------------------
-- ISNUMERIC() Example 1)
SELECT ISNUMERIC('SQL') AS Result  -- 'SQL' Not numeric so result = 0
-- ISNUMERIC() Example 2)
SELECT ISNUMERIC('12') AS Result  -- '12' INT so result = 1
-- ISNUMERIC() Example 3)
SELECT ISNUMERIC('100.50') AS Result  -- '100.50' Decimal so result = 1

-- Logical Tests functions 
SELECT ISNUMERIC('SQL') AS isnmumeric_result;
select Isdate(getdate())  --return 1 because its a date
select Isdate('kkk')   -- return 0   because its not a date
select isnumeric ('dfd')  --returns 0 casue its not numeric value
select isnumeric (5)  --returns 1 casue its numeric value

-------------------------------------------------------------------------
-- IIF() Syntax
-- IIF (<Boolean_Expression> , 'Value if true' , 'value if false or unknown')
----------------------------------------------------------------------------
Select IIF(6>3,'True','false')
--IIF() Example 1)  -- Like Case Statement
SELECT productid,unitprice, IIF(unitprice > 50,'high','low') AS pricepoint
FROM   Products

--IIF() Example 2) 
SELECT IIF(1 > 10, 'TRUE', 'FALSE' ) AS Result

--IIF() Example 3)  -- Error because NULL Values
SELECT IIF ( 45 > 30, NULL, NULL ) AS Result

-- IIF() Example 4)  -- Nested IIF
SELECT IIF ( 45 = 30, 'True', IIF(1>2,'Yes','No') ) AS Result
------------------------------------------------------------------------
-- CHOOSE() Syntax
-- CHOOSE (<Index_number>,Value_list)
--------------------------------------
-- CHOOSE() Example 1)  -- Simple Example
SELECT CHOOSE(1,'Spring','Summer','Autumn','Winter') AS Result
-- CHOOSE() Example 2)  -- Null because index number not in values list
SELECT CHOOSE(5,'Spring','Summer','Autumn','Winter') AS Result
-- CHOOSE() Example 3)  -- error if index Char.
SELECT CHOOSE(1,'One','Spring','Summer','Autumn','Winter') AS Result
-- CHOOSE() Example 4)  --  string implicitly converted to INT
SELECT CHOOSE('2','Spring','Summer','Autumn','Winter') AS Result 
-- CHOOSE() Example 5)  -- If index value is numeric, it will be implicitly converted to INT.
SELECT CHOOSE(3.1,'Spring','Summer','Autumn','Winter') AS Result
------------------------------------------------------------------------------------------------------
/*
  --  Functions to Work with NULL :-
  ------------------------------------
      A)- ISNULL()   :-
	               - ISNULL replaces NULL with a specified value.
				   - ISNULL Not ANSI standard.


	  B)- COALESCE() :-
	               - COALESCE is ANSI standard.
				   - returns the first non-NULL value in a list.
				   - If all arguments are NULL, COALESCE returns NULL.

	  C)- NULLIF()  :-
	              - NULLIF is ANSI standard.
	              - NULLIF compares two expressions.
				  - Returns NULL if both are equal.
				  - Returns the first expressions if both not equal.
*/

-- ISNULL() Syntax
-- ISNULL(<expression_to_check> , 'replacement_value')
---------------------------------------------------
-- ISNULL() Example 1)
SELECT EmployeeID,city,Region,ISNULL(region, 'N/A') AS New_Region,country 
FROM Employees 
GO
-- ISNULL() Example 2)  -- ISNULL inside another function
SELECT AVG(ISNULL(quantity, 50)) AS Average
FROM [Order Details]
GO
--------------------------------------------------
-- COALESCE() Syntax
-- COALESCE(<expression_to_check> , 'replacement_value')
-------------------------------------------------------
-- COALESCE() Example 1)  -- Working Like ISNULL()
SELECT country,region,city, country + ',' + COALESCE(region, ' ') + ', ' + city as location
FROM   Employees

-- COALESCE() Example 2)   -- Get First not null value
CREATE TABLE COAL( ID INT, FirstName varchar(20),MiddleName varchar(20), LastName Varchar(20))
 
INSERT INTO COAL VALUES (1,'Ali','Yasser','Walid'), (1,NULL, NULL ,NULL), (1,'Ahmed',NULL,'Ali'),
                        (1,NULL,'Mohamed',NULL),
		                (1,NULL,NULL,'Walid')
GO
SELECT * FROM COAL
GO
SELECT ID,COALESCE(FirstName,MiddleName,LastName) AS Name
FROM COAL
GO
-------------------------------------------------------------------------
-- NULLIF() Syntax
-- NULLIF ( <expression1> , <expression2> )
-------------------------------------------
-- NULLIF() Example 1)
SELECT NULLIF(1,1) AS RESULT

-- NULLIF() Example 2)
SELECT NULLIF(1,2) AS RESULT

-- NULLIF() Example 3)
SELECT NULLIF(2,1) AS RESULT

---------------------------------------------------
--Date Format (Lab HOL)
--------------
create database Module8
go
use Module8
go
Create table Employees2(ID int primary key identity, Name nvarchar(50),DOB Date ,attendTime Time);
insert into Employees2 values('Ahmed',getdate(),getdate());
select * from Employees2
Select Getdate()
Select Format (GetDate(),'dd/MM/yyyy hh:mm:ss')
Select Format (GetDate(),'dddd dd MMMM yyyy hh:mm:ss')

select * ,FORMAT(DOB,'dd/MM/yyyy') as [Date] ,Format(attendTime,'hh:mm:ss') as [Time] from Employees2 -- 
select * ,FORMAT(DOB,'dd/MM/yyyy') as [Date] ,left(attendTime,5) as [Time] from Employees
select format (getdate(),'hh:mm:ss');
select 'this is My DOB '+ convert(varchar(25),format(getdate(),'dddd-MMMM-dd-yyyy')) ;
-----------------------------------------------------------------------------------------------
Select * from Orders 
Select @@ROWCOUNT
--format(value,format,culture)
Declare @x Datetime ;
Set @x = Getdate();
GO
Select @@ROWCOUNT

Declare @x Datetime = Getdate() ;
Select @x


DECLARE @date DATETIME = GETDATE()
SELECT @date AS 'GETDATE()',
       FORMAT( @date, 'd', 'en-US') AS 'DATE IN US Culture',
       FORMAT( @date, 'd', 'en-IN') AS 'DATE IN INDIAN Culture',
       FORMAT( @date, 'd', 'de-DE') AS 'DATE IN GERMAN Culture'

DECLARE @Price INT = 40
SELECT FORMAT(@Price,'c0','en-US') AS 'CURRENCY IN US Culture', 
       FORMAT(@Price,'c1','de-DE') AS 'CURRENCY IN GERMAN Culture',
	   FORMAT(@Price,'c3','ar-EG') AS 'CURRENCY IN Egypt Culture'
        

DECLARE @Price DECIMAL(5,3) = 40.356
SELECT FORMAT( @Price, 'C') AS 'Default',
       FORMAT( @Price, 'C0') AS 'With 0 Decimal',
       FORMAT( @Price, 'C1') AS 'With 1 Decimal',
       FORMAT( @Price, 'C2') AS 'With 2 Decimal',
       FORMAT( @Price, 'C3') AS 'With 3 Decimal'

DECLARE @Percentage float = 0.35674
SELECT FORMAT( @Percentage, 'P') AS '% Default',
       FORMAT( @Percentage, 'P0') AS '% With 0 Decimal',
       FORMAT( @Percentage, 'P1') AS '% with 1 Decimal',
       FORMAT( @Percentage, 'P2') AS '% with 2 Decimal',
       FORMAT( @Percentage, 'P3') AS '% with 3 Decimal'

----------------------------------------------------------------------------------
--String Function
-- Use string functions in a query

SELECT Rtrim('Sayed Hawas           ')
SELECT Ltrim('    Microsoft SQL Server')
SELECT rtrim(Ltrim('    Microsoft SQL Server     '))

SELECT SUBSTRING('Microsoft SQL Server',11,3) AS Result;
SELECT LEFT('Microsoft SQL Server',9)  AS Result;
SELECT RIGHT('Microsoft SQL Server',6);
SELECT LEN('Microsoft SQL Server     ') AS [LEN];
SELECT DATALENGTH('Microsoft SQL Server     ');
SELECT CHARINDEX('SQL','Microsoft SQL Server');
SELECT REPLACE('Microsoft SQL Server 2008','2008','2012');
SELECT UPPER('Microsoft SQL Server');
SELECT LOWER('Microsoft SQL Server');
select firstname , reverse(firstname) as rever from Employees

--Demo On Nested function 
declare @x varchar(200) = '   mIcroSoft sQL SerVER 2016    '
select Concat(Upper( substring(ltrim(@x),1,1)) ,lower(substring (ltrim(@x),2,len(@x))))
--------------------------------------------------------------------------------------------
--Date & Time Functions
select GETDATE()
select GETUTCDATE()
select CURRENT_TIMESTAMP
select SYSDATETIME()
select SYSUTCDATETIME()
select SYSDATETIMEOFFSET()
select DATEPART(day,'1/29/2014')
select DATEPART(MONTH,'1/29/2014')
select DATEPART(YEAR,'1/29/2014')
select DATEFROMPARTS ( 2014, 1, 29 )
select TIMEFROMPARTS(13,26,44,0,0) -- 5 argu

GO
DECLARE @date DATETIME =Getdate();
SELECT EOMONTH ( @date,1 ) AS Result;
GO
DECLARE @date DATETIME = GETDATE();
SELECT EOMONTH ( @date ) AS 'This Month';
SELECT EOMONTH ( @date, 1 ) AS 'Next Month';
SELECT EOMONTH ( @date, -1 ) AS 'Last Month';
GO
SELECT DAY('20120212') AS [Day], MONTH('20120212') AS [Month],YEAR('20120212') AS [Year];


-- Use ISDATE to check validity of inputs:
SELECT ISDATE('20120212'); --is valid
SELECT ISDATE('20120230'); --February doesn't have 30 day
------------------------------ new 
select datepart (q,'1/1/2015') --quarter in Year 
select DATEPART(q,getdate());
select datepart(DW,'8/1/2015') --Day in Week
select Datepart(dw,getdate());
Select datepart(DY,'8/1/2015') --Day in year 
select datepart(dy,getdate()); 
select datepart(WW,getdate());  --Week in Year
-----------------------------------------
-- Using Built-In Functions
-- Scalar Functions
---------------------------------
SELECT ABS(-1.0), ABS(0.0), ABS(1.0);
--Metadata Function
SELECT DB_NAME() AS current_database;
--global variable
select @@VERSION as Edition 
--Module 6
--Working with SQL Server 2016 Data Types
--============================================

Create table MyTable (Id int primary key identity,
                      Name  Nvarchar(150),
					  Email varchar(200),
					  Mobile varchar(11),
					  Notes nvarchar(Max),
					  Age tinyint,
					  Gender bit ,
					  Salary Decimal(9,2)
					  ) 
  
  
GO
Declare @x char(50) = 'Ahmed'
--Set @x = '????'
Select  @x
GO
Declare @x varchar(50) = 'Ahmed'
Select  @x

Declare @y varchar(max) = 'Ahmed'

GO
Declare @x nchar(4000) = N'????'
Select  @x


--0-9 A-f 
Select NewID()

Select * from Orders for xml path
/*
          -- Lessons :-
		  --------------
		               1- Introducing SQL Server 2016 Data Types.
					   2- Working with Character Data.
					   3- Working with Date and Time Data.
--Working with SQL Server Data Types
--==================================================================================
									--Data type 
									--T-SQL Variables Overview :
									--system supplied Data Types
-----------------------------------------------------------------------------------------
--1-Character DataTypes:
dclare 
/*
Non-Unicode character char[(n)]                     1-8000                          n bytes, padded
					  varchar[(n)]                  1-8000                          n+2 bytes
					  varchar(max)                  1-2^31-1 characters             Actual length + 2
					  text							0ñ2(GB)  Deprecated
----------------------------------------------------------------------------
Unicode character     nchar[(n)]                    1ñ4,000 characters             2*n bytes, padded
					  nvarchar[(n)]					1ñ4,000 characters             (2*n) +2 bytes
					  nvarchar(max)					1-2^31-1 characters             Actual length + 2
					  ntext							0-2(GB)  Deprecated
----------------------------------------------------------------------------
*/
--2-Exact Numeric Data Types
/*
													
					  tinyint						0 to 255			           1
					  smallint                      -32,768 to 32,767              2
                      int							-2^31 (-2,147,483,648) to      4
                                                     2^31-1 (2,147,483,647)              
					  bigint                        -2^63 to 2^63-1                8
					                                (+/- 9 quintillion)
					  bit                           1/0 or true/false              1
                     -----------------------------------------------------------------------------
                     decimal/numeric               - 10^38 +1 through 10^38 ñ 1    7-15
					                                when maximum precision is used
      
					 money                          -922,337,203,685,477.5808       8
					                                to 922,337,203,685,477.5807
                     smallmoney                     - 214,748.3648 to 214,748.3647  4
*/
---------------------------------------------------------------------------------------------------
--Note that while decimal is ISO standards-compliant, decimal and numeric
--are equivalent to one another. Numeric is kept for compatibility with earlier versions of SQL Server

-- decimal [ (p[ ,s] )] and numeric[ (p[ ,s] )] 
--p (precision)  : The maximum total number of decimal digits that can be stored
--s (scale)  : The maximum number of decimal digits that can be stored to the right of the decimal point
/*
Precision           Storage bytes
1 - 9               5
10-19               9
20-28               13
29-38               17
*/
----------------------------------------------------------------------------------------------------
--ex:
--Decimal(5)
--Decimal(100)
--Decimal(5,2)
--Money & small money are monetary DataTypes
----------------------------------------------------------------------------------------------------
--3-Approximate Numeric Types
/*
Approximate numeric  float[(n)]                                                     8
					 real                                                           4
----------------------------------------------------------------------------------------------------
-- float [ (n) ]
--it must be a value between 1 and 53. The default value of n is 53.


 n value             Precision          Storage size
 1-24               7 digits           4 bytes
 25-53              15 digits          8 bytes

Note: SQL Server treats n as one of two possible values. If 1<=n<=24, n is treated as 24. If 25<=n<=53, n is treated as 53.
*/
----------------------------------------------------------------------------------------------------
--real is equivalent to float(24)
--4-Date and Time Data Types
/*
Data type category    SQL Server system supplied      Number of bytes           Range                         Formate                     
					  data types
---------------------------------------------------------------------------------------------------------------------------------------------
Date and time        datetime						   8                        from January 1, 1753          YYYY-MM-DD hh:mm:ss[.nnn]
														                        to December 31, 9999
					
					datetime2                          6-8                      0001-01-01                    YYYY-MM-DD hh:mm:ss[.nnnnnnn]
					                                                            00:00:00.0000000 
					                                                            through 9999-12-31 
					                                                            23:59:59.9999999
									 
					
					 smalldatetime					   4                        from January 1, 1900          YYYY-MM-DD hh:mm:ss
														                        to June 6, 2079 
														 

					 Time							   3-5	                    00:00:00.0000000              hh:mm:ss[.nnnnnnn]
					                                                            through 23:59:59.9999999
	                      
                     date                              3                        0001-01-01 through 9999-12-31 YYYY-MM-DD
                     
                     datetimeoffset                    8-10                     0001-01-01 00:00:00.0000000   YYYY-MM-DD hh:mm:ss[.nnnnnnn] 
                                                                                through 9999-12-31            [+|-]hh:mm    
                                                                                23:59:59.9999999 (in UTC)
*/
--------------------------------------------------------------------------------------------------
--5-Binary Data Types
--Binary String Data Types
/*   
Data type category    SQL Server system supplied   Range                       Number of bytes
					  data types
------------------------------------------------------------------------------------------------------
Binary Strings		  binary[(n)]                   1-8000                         n bytes
				      varbinary[(n)]				1-8000                         n bytes + 2
					  varbinary(max)				1-2.1 billion (approx) bytes   actual length + 2
-------------------------------------------------------------------------------------------------------
Image				  image                         0ñ2(GB)                        
-------------------------------------------------------------------------------------------------------
--6-Other Data Types
Data type category    SQL Server system supplied   Range                       Number of bytes
					  data types
---------------------------------------------------------------------------------------------------------
                     uniqueidentifier               Auto-generated     				    16
 					 xml							0ñ2(GB)                             0-2 GB 
           			 SQl_variant					0-8000 bytes                        Depends on content
					 rowversion                     Auto-generated                      8					
                     table                          N/A                                 N/A
-----------------------------------------------------------------------------------------------------------	

*/
Select NewId()
 -- Lesson 1) Introducing SQL Server 2016 Data Types :-
 -------------------------------------------------------
      -- SQL Server Data Types :-	
	  ---------------------------
	   - Data types specify the type, length, precision, and scale of data. 
	   - SQL Server associates columns, expressions, variables, and parameters with data types.
	   - Data types determine what kind of data can be held:-
                                       Integers, characters, dates, money, binary strings, etc.
	   - SQL Server supplies :- 
	   1) Built-in data types.  
	   2) User defined custom data types.

	   - SQL Server Data types Categories :-  -- Please See Images 
	   -------------------------------------

	                                   - Exact Numeric.
									   - Approximate Numeric.
									   - Data & Time.
									   - Character Strings.
									   - Unicode Characters.
									   - Binary Strings.
									   - Others
---------------------------------------------------------------------------------------------------
		 Numeric Data Types :-
		--------------------------
           1) Exact Numeric:-
		   -------------------
			  - Integers :-    TinyInt , SmallInt , Int , BigInt .

			  - Decimal Or Numeric :-  Decimal Is ANSI Standard ,
			                           Numeric is kept for compatibility with earlier versions of SQL Server.

			  - Money & SmallMoney :- Money(8byte) Smallmoney(4byte) are also exact and map to Decimal and have 4 decimal points.

			  - Bit :-  1 , 0 OR NULL . 
		  2) Approximate Numeric :-
		   -------------------------
			  - Float :-  Like DECIMAL but only 6 right point of the decimal ,
			              Will Approximate values .
			         FLOAT(24) :- range 1 to 24 = 4bytes
			         FLOAT(53) :- range 25 to 53 = 8bytes

			  - Real :-  ISO synonym for float(24) = 4bytes
*/
--Examples For Numeric Data Types :-
---------------------------------------
--TinyInt -- (0) TO (255) 1byte
DECLARE @TinyInt TINYINT = 300   --erro if try 300
SELECT @TinyInt 
GO
--SmallInt -- (-32,768) TO (+32,768) 2bytes
DECLARE @SMALLINT SMALLINT = -32769   -- error if try 33000
SELECT @SMALLINT
GO
--Int  -- (-2,147,483,648) TO (+2,147,483,647) 4bytes
DECLARE @INT INT = 200000000000000  -- error if try 3000000000
SELECT @INT
GO
--BigInt  -- (-9,223,372,036,854,775,808) TO (+9,223,372,036,854,775,807) 8bytes
DECLARE @BIGINT BIGINT = 9000000000000000  --error if try 10000000000000000000
SELECT @BIGINT
GO

-- SmallMoney -- (-213,748.3648) TO (+213,748.3647) 4bytes
DECLARE @SMALLMONEY SMALLMONEY = 200123.3212     --error if try 300,2000.2134
SELECT @SMALLMONEY 
GO
-- Money -- (-922,337,203,685,477.5808) TO (-922,337,203,685,477.5807) 8bytes
DECLARE @MONEY MONEY = 900400300200100.1234    --error if try 950400300200100.1234
SELECT @MONEY 
GO
--Bit -- (0) Or (1) Or (NULL) 1byte
DECLARE @BIT BIT = NULL     --if try any other number will show 1
SELECT @BIT 
GO
/*
 DECIMAL (P,S) & NUMERIC (P,S) 
--P (Precision) :- The maximum total number of decimal digits that can be stored(38).
--S (Scale) :- The maximum number of decimal digits that can be stored to the right of the decimal point.
--Both have (18, 0) as default (precision,scale) parameters in SQL server.
Storage :-
-----------
Precision           Storage bytes
1 - 9               5
10-19               9
20-28               13
29-38               17
*/

--Example DECIMAL 1)
DECLARE @DECIMAL DECIMAL(4,2) = 42.12  --error if try 321.21
SELECT @DECIMAL
GO
--Example DECIMAL 2)
DECLARE @DECIMAL DECIMAL(6,1) = 23.231  --error if try 1234221.22
SELECT @DECIMAL
GO
--Example DECIMAL 3)
DECLARE @DECIMAL DECIMAL = 23.231  -- no (0) so default will be (18.0)
SELECT @DECIMAL
GO
--Example DECIMAL 4)
DECLARE @DECIMAL DECIMAL(30,10) = 3123123.123123  --error if try more than 30 digits.
SELECT @DECIMAL
GO
-- DECIMAL = NUMERIC 
-- Example NUMERIC 
DECLARE @NUMERIC NUMERIC(5,4) = 2.121133 --error if try 22.22
SELECT @NUMERIC
GO
-- Example FLOAT 
DECLARE @FLOAT FLOAT(24) = 2.1211367
SELECT @FLOAT
GO
-- Example REAL 
DECLARE @REAL REAL = 2.1211367 -- REAL not using (n) because it always (24) 
SELECT @REAL
GO
/*
-- 3) Binary String Data Types :-
---------------------------------
         - Binary string data types allow a developer to store binary information,
		   Such as serialized files, images, bytestreams, and other specialized data.

              - BINARY(n)       :- Fixed-width   = n bytes
              - VARBINARY(n)    :- Varying-width = n bytes + 2bytes
			  - VARBINARY(MAX)  :- MAX-Width 1-2.1 billion bytes = Actual length + 2bytes
*/
-- Example Binary
DECLARE @BINARY BINARY(4) = 123
SELECT @BINARY
GO
-- Example VarBinary
DECLARE @VARBINARY VARBINARY(5) = 12321
SELECT @VARBINARY
GO
-- Example VarBinary(max)
DECLARE @VARBINARY VARBINARY(MAX) = 12312111
SELECT @VARBINARY
GO
/*
-- 4) Other Data Types :-  -- Rarely Used
---------------------------
   - In addition to numeric and binary types, SQL Server also supplies some other data types,
     allowing you to store and process XML, generate globally unique identifiers (GUIDs),
	 represent hierarchies, and more. Some of these have limited use, others are more generally useful.

         - Rowversion       :-  Binary value, auto-incrementing when a row in a table is inserted or updated.

		 - Uniqueidentifier :-  Provides a mechanism for an automatically generated value that is unique across multiple systems.
		                        It is stored as a 16 byte value. by using the NEWID() system function.

		 - XML              :-  Allows the storage and manipulation of eXtensible Markup Language data. 
		                        This data type stores up to 2 GB of data per instance of the type. 
							    
		 - Cursors          :-  listed here for completeness. A SQL Server cursor is not a data type for storing data,
		                        But rather for use in variables or stored procedures .

		 - Hierarchyid      :-  Used to store hierarchical position data, such as levels of an organizational chart or bill of materials.
		                        SQL Server stores hierarchy data as binary data and exposes it through builtin functions. 
 
		 - SQL_variant      :-  Column data type that can store other common data types.
		                        Its use is not a best practice for typical data storage and may indicate design problems. 

		 - Table            :-  You will learn more about table types later in this course. 
		                        Note that table types cannot be used as a data type for a column (such as to store nested tables). 

*/

--XML
Declare @x xml =
 '<authors>
    <au_id>409-56-7008</au_id>
    <au_lname>Bennet</au_lname>
    <au_fname>Abraham</au_fname>
  </authors>
'
Select @x

-- Example RowVersion 
CREATE TABLE ExampleTable1 (PKey int PRIMARY KEY, VersionCol rowversion) 
GO
INSERT ExampleTable1(PKey)VALUES(1),(2)
SELECT * FROM  ExampleTable1;
GO

-- Example Uniqueidentifier
DECLARE @GUID Uniqueidentifier = NEWID()   -- Run this again , result will change random
SELECT @GUID
GO

-- Example SQL_Variant      -- Accept all types of data , no recommended
DECLARE @SQL_V1 SQL_Variant = 0 ,
        @SQL_V2 SQL_Variant = '4/4/2000' ,
		@SQL_V3 SQL_Variant = $123.112 ,
		@SQL_V4 SQL_Variant = 32

SELECT @SQL_V1 AS BIT ,
       @SQL_V2 AS DATE,
	   @SQL_V3 AS MONEY,
	   @SQL_V4 AS INT
GO 
/*
  -- Data Type Precedence :- 
  --------------------------
      - Which data type will be chosen when expressions of different types are combined.
      - Data type with the lower precedence will implicitly converted to the data type with the higher precedence.
      - Conversion to  lower precedence must be made explicitly Using (CAST OR CONVERT functions)
      - 1. XML 2. Datetime2 3. Date 4. Time 5. Decimal 6. Int 7. Tinyint 8. Nvarchar 9. Char 
*/
-- Example 
DECLARE @TINYINT  TINYINT = 100
DECLARE @SMALLINT  SMALLINT = 1000
SELECT  @TINYINT + @SMALLINT
DECLARE @RESULT sql_variant = @TINYINT + @SMALLINT
SELECT  @RESULT
SELECT	sql_variant_property(@RESULT, 'BaseType')  -- To Show The Result data type will be SMALLINT
GO
/*
-- Convert Data Type To another :- 
------------------------------------
    - Data type conversion scenarios :- 
                 A) When data is moved, compared, or combined with other data.
                 B) During variable assignment.
                 C) When using any operator that involves two operands of different types.
                 D) When T-SQL code explicitly converts one type to another, using a CAST or CONVERT function.
	- Conversion Types :-
	             A) Implicit conversion :- When comparing data of one type to another, Transparent to user.
				 B) Explicit conversion :- Uses CAST or CONVERT functions
    - Not all conversions allowed by SQL Server.
*/
-- Example for Implicit Conversion Working 
DECLARE @myTinyInt TINYINT = 25,
        @myInt INT = 1000
SELECT @myTinyInt + @myInt
GO
-- Example for Implicit Conversion Failed 
DECLARE @char CHAR(3) = 'One',
        @int INT = 1 
SELECT @char + @int
GO
-- Example for Explicit Conversion Using CAST 
-- Syntax :- CAST('OldDataType' AS 'NewDataType') 
DECLARE @char CHAR(3) = 'One',
        @int INT = 1 
SELECT @char + CAST(@int AS CHAR(1))
GO
-- Example for Explicit Conversion Using CONVERT
-- Syntax :- CONVERT ('NewDataType','OldDataType')
DECLARE @char CHAR(3) = 'One',
        @int INT = 1 
SELECT @char + CONVERT(CHAR(1),@int)
GO
-- Another Examples 
SELECT CONVERT(CHAR(4),1000) + 'k' AS 'Explicit Conversion'
GO
SELECT CAST(1000 AS CHAR(4)) + 'k' AS 'Explicit Conversion'
GO
--Conversion to type of lower precedence must be made explicitly (with CAST function)
--Example (low to high):
--CHAR -> VARCHAR -> NVARCHAR -> TINYINT -> INT -> DECIMAL -> TIME -> DATE -> DATETIME2 -> XML
-----------------------------------------------------------------------------------------------------------------------------------
/*
 -- Lesson 2) Working with Character Data :-
 --------------------------------------------
 
     -- Character Data Types :-
	 ---------------------------
	               - Store 1 byte per character.
				   - 265 Possible character Only - Limits language support
				   - Inserting data with single quotes, such as 'SQL'
				   
				   Types :- 
                           Char(n)      :-  1-8000 character . Take (n) as fixed storage.
						   Varchar(n)   :-  1-8000 character.  Take the actual character as storage.
						   Varchar(max) :-  2GB per instance.
						   Text         :-  Use Varchar(Max) instead of Text .
*/
-- Example Char(n)
DECLARE @Char CHAR(6) = 'Ahmed'  -- error if try 'AhmedAliMohamed'
SELECT @Char

-- Example Varchar(n)
DECLARE @VARChar VarChar(6) = 'Ahmed'  -- error if try 'AhmedAliMohamed'
SELECT @VARChar

-- Example Varchar(max)
DECLARE @VARCharMAX VARCHAR(Max) = 'One initial choice is character types based on a simple ASCII set versus Unicode'  
SELECT @VARCharMAX
/*
     -- Unicode Character Data Types :-
	 -----------------------------------
	               - Store 2 byte per character.
				   - 65000 Possible characters including special characters from many languages.
				   - Inserting data using this type have an N prefix (for National), such as N'SQL'. 
				   
				   Types :- 
                           NChar(n)      :-  1-8000 character . Take (n) as fixed storage.
						   NVarchar(n)   :-  1-8000 character.  Take the actual character as storage.
						   NVarchar(max) :-  2GB per instance.
						   NText         :-  Use NVarchar(Max) instead of NText 
*/
-- Example Nchar(n)
DECLARE @NCHAR NCHAR(10) = N'?hmed'
SELECT @NCHAR
-- Example NVARCHAR(n)
DECLARE @NVARCHAR NVARCHAR(10) = N'?hmed'
SELECT @NVARCHAR
-- Example NVARCHAR(max)
DECLARE @NVARCHARMAX NVARCHAR(MAX) = N'?hmed Íaaaaaa'
SELECT @NVARCHARMAX
GO
/* 
   -- String Concatenation :-
   ---------------------------
          - Using + (Plus) Or CONCAT() Function.
		  - When using + Concatenating a value with a NULL returns a NULL. 
		  - CONCATE() Converts NULL to empty string before concatenation.
*/
-- Example Concate Nulls using + (Plus) :-
USE Northwind
SELECT EmployeeID,City,Region,
       Country,( City + ', ' + region + ', ' + country ) AS Location
FROM Employees
GO
-- Example Concate Nulls using CONCATE() :-
USE Northwind
SELECT EmployeeID,City,Region,
	   Country,CONCAT( City , ', ' , region , ', ' , country ) AS Location
FROM Employees
GO
/*
       -- Character String Functions :-
	   --------------------------------
	   - In addition to retrieving character data as-is from SQL Server,
	      you may also need to extract portions of text or determine the location of characters within a larger string. 
		  SQL Server provides a number of builtin functions to accomplish these tasks. Some of these functions include:-
*/
-- FORMAT() :- new to SQL Server 2012 - allows you to format an input value to a character string  
USE Northwind
SELECT TOP (3) orderid,
       OrderDate,
       FORMAT(orderdate,'d','en-us') AS US,
	   FORMAT(orderdate,'d','de-DE') AS DE 
FROM Orders
GO
----------------------------------------------------------------------
--Collation
-------------
/*
- In addition to size and character set, SQL Server character data types are assigned a collation.
- This assignment may be at one of several levels: the server instance,
   the database (default), or a collation assigned to a column in a table or in an expression.
- Collations are collections of properties that govern several aspects of character data:-
    ï Supported languages 
	ï Sort order 
	ï Case sensitivity 
	ï Accent sensitivity  

- Note A default collation is established during the installation of SQL Server but can be overridden on a per-database or per-column basis.
-  As you will see, you may also override the current collation for some character data by explicitly setting a different collation in your query.
*/


-- All SQL SERVER Collations
--Query MetaData
SELECT * FROM   fn_helpcollations()
GO

-- COLLATE Option to Force collation.
USE Northwind
SELECT EmployeeID,FirstName,lastname  
FROM   Employees 
WHERE FirstName = 'nancy'


SELECT EmployeeID,FirstName,lastname
FROM   Employees 
WHERE FirstName COLLATE Latin1_General_CS_AS = N'nancy'



SELECT EmployeeID,FirstName,lastname
FROM   Employees 
WHERE FirstName COLLATE Latin1_General_CS_AS = N'Nancy'
GO

-- Example For Collation Case InSensitive (CI) & Case Sensitive CS
USE tempdb
CREATE TABLE Table1
(
    CI VARCHAR(15) COLLATE Latin1_General_CI_AS,
    CS VARCHAR(14) COLLATE Latin1_General_CS_AS
) 
GO
INSERT Table1
VALUES ('Ahmed','Ali'),
       ('ahmed','ali'),
       ('mohamed','mohamed'),
       ('Mohamed','Mohamed');
GO

-- Retrieve Data
SELECT *FROM Table1
GO

-- Order By CI
SELECT * FROM Table1
ORDER BY CI
GO
-- Order By CS
SELECT * FROM Table1
ORDER BY CS
GO


-- Example of Width Sensitive (WS) and Width Insensitive (WI)
USE TempDB
GO
CREATE TABLE Table2
(IDWI NVARCHAR(100) COLLATE Latin1_General_CI_AI,
 IDWS NVARCHAR(100) COLLATE Latin1_General_CI_AI_WS)
GO
INSERT INTO Table2
VALUES ('E=mc≤ Albert Einstein',
        'E=mc≤ Albert Einstein')
GO
SELECT * FROM Table2
WHERE IDWI LIKE 'E=mc2%'
GO
SELECT *
FROM Table2
WHERE IDWS LIKE 'E=mc2%'


SELECT *
FROM Table2
WHERE IDWS LIKE 'E=mc≤%'


SELECT lastname
FROM employees
WHERE firstname = '√Õ„œ';

SELECT lastname
FROM employees
WHERE firstname  COLLATE Latin1_General_CS_AS = N'√Õ„œ';

SELECT lastname
FROM employees
WHERE firstname = N'√Õ„œ';


GO
--===================================================================================
--Character String Functions
---------------------------
-- SUBSTRING() :- for returning part of a character string given a starting point and a number of characters to return
SELECT SUBSTRING('Microsoft SQL Server',11,3) AS Result
-- LEFT() :- for returning the leftmost or rightmost characters, respectively, up to a provided point in a string 
SELECT LEFT('Microsoft SQL Server',9) AS Result
-- RIGHT() :- for returning the leftmost or rightmost characters, respectively, up to a provided point in a string
SELECT RIGHT('Microsoft SQL Server',10) AS Result
-- LEN() and DATALENGTH()  :-
-- Providing metadata about the number of characters or number of bytes stored in a string. Given a string padded with spaces
SELECT LEN('Microsoft SQL Server     ')   AS [LEN],
       DATALENGTH('Microsoft SQL Server     ')  AS [DATALEN]
-- CHARINDEX() :- for returning a number representing the position of a string within another string
SELECT CHARINDEX('SQL','Microsoft SQL Server') AS Result
-- REPLACE() for substituting one set of characters with another set within a string
SELECT REPLACE('Microsoft SQL Server Denali','Denali','2012') AS Result
--  UPPER() and LOWER() :- for performing case conversions 
SELECT UPPER('Microsoft SQL Server') AS 'Upper',
       LOWER('Microsoft SQL Server') AS 'Lower' 
GO
-----------------------------------------------------------------------------------------------------------------------------------
/*
The LIKE predicate can be used to check a character string for a match with a pattern
Patterns are expressed with symbols:-

    % (Percent) represents a string of any length
    _ (Underscore) represents a single character
   [<List of characters>] represents a single character within the supplied list
   [<Character> - <character>] represents a single character within the specified range
   [^<Character list or range>] represents a single character not in the specified list or range
   ESCAPE Character allows you to search for characters that would otherwise be treated as part of a pattern  - %, _, [, and ])
*/
-----------------------------------------------------------------------------------------------------------------------------------
/*
 -- Lesson 3) Working with Date and Time Data :-
 -----------------------------------------------
    -- Date and Time Data Types :-
	-------------------------------
	   - Older versions of SQL Server supported only DATETIME and SMALLDATETIME.
	   - DATE, TIME, DATETIME2, and DATETIMEOFFSET introduced in SQL Server 2008.
*/
-- DATETIME :- 'YYYYMMDD hh:mm:ss.nnn' 
DECLARE @DATETIME DATETIME ='20120212 12:30:15.123' 
SELECT @DATETIME

-- SMALLDATETIME 'YYYYMMDD hh:mm'  
DECLARE @SMALLDATETIME SMALLDATETIME ='20120212 12:30' 
SELECT @SMALLDATETIME

-- DATETIME2 'YYYY-MM-DD' 
DECLARE @DATETIME2 DATETIME2 ='2012-02-12'
SELECT @DATETIME2

-- DATE 'YYYYMMDD' 'YYYY-MM-DD' 
DECLARE @DATE DATE ='20120212' 
SELECT @DATE

-- TIME 'hh:mm:ss.nnnnnnn' 
DECLARE @TIME TIME ='12:30:15.1234567' 
SELECT @TIME

-- DATETIMEOFFSET 'YYYYMMDD hh:mm:ss.nnnnnnn [+|-]hh:mm'  
DECLARE @DATETIMEOFFSET DATETIMEOFFSET = '20120212 12:30:15.1234567 +02:00'  
SELECT @DATETIMEOFFSET


-- Datetime Column :
-- ------------------
 SELECT 
     Convert(time(7),'2007-05-08 12:35:29. 1234567' )  AS '( Time ) new in 2008' 
    ,Convert(date,'2007-05-08 12:35:29. 1234567'    )  AS '( Date ) new in 2008' 
    ,Convert(smalldatetime,'2007-05-08 12:35:29.123')  AS 'Smalldatetime' 
    ,Convert(datetime,'2007-05-08 12:35:29.123'     )  AS 'Datetime' 
    ,Convert(datetime2(7),'2007-05-08 12:35:29. 1234567 +12:15') AS 
        '( Datetime2 ) new in 2008'
    ,Convert(datetimeoffset(7),'2007-05-08 12:35:29.1234567 +12:15' ) AS 
        '( Datetimeoffset ) new in 2008'

 --======================================================================================================================
declare @id uniqueidentifier
set @id = NEWID()
select @id
--=====================
--Conversion 
 ------------

 --Step 2: Use implicit conversion in a query
--Demonstrate implicit conversion from the lower type (varchar)
-- to the higher (int)
SELECT 1 + '2' AS result;

--Step 3: Use implicit conversion in a query
--Demonstrate implicit conversion from the lower type (varchar) 
-- to the higher (int)
--NOTE: THIS WILL FAIL

SELECT 1 + 'abc' AS result;

--Step 4: Use explicit conversion in a query

SELECT CAST(1 AS VARCHAR(10)) + 'abc' AS result;

SELECT CAST('09/15/2000' AS datetime2) AS [Using CAST Function]
SELECT CONVERT(datetime2, '09/15/2000') AS [Using CONVERT Function]

--------------------------------------------------
--Conversion
--Implicit
DECLARE @myTinyInt  TINYINT = 25;
DECLARE @myInt  INT = 9999;
SELECT @myTinyInt + @myInt;

--check this?
DECLARE @somechar CHAR(5) = '6';
DECLARE @someint INT = 1
SELECT @somechar + @someint;

--what about this??
DECLARE @somechar CHAR(3) = 'six';
DECLARE @someint INT = 1
SELECT @somechar + @someint;

--Explicit
DECLARE @somechar CHAR(3) = 'six';
DECLARE @someint INT = 1
SELECT @somechar + cast( @someint as char(1)) ;

declare @date date = getdate();
select @somechar + cast ( @date AS nvarchar);
----------------------------------------------------------------------

