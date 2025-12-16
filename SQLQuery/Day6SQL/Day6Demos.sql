--HOL 
USE Northwind
GO
Select * from Employees

Create Database Day6DB
GO
USE Day6DB
--================================================================				    
					--Module 11
					--Using Table Expressions
USE Northwind

GO
Alter View VW_ShowOrderForEmployee
AS 
  Select * from Orders Where EmployeeID = 2
GO

Drop View VW_ShowOrderForEmployee
GO
Select * from VW_ShowOrderForEmployee
/*
					Using Views
					Using Inline TVFs
					Using Derived Tables
					Using CTEs


--Lesson 1: Using Views
		Writing Queries That Return Results from Views
		Creating Simple Views
		Demonstration: Using Views

Views may be referenced in a SELECT statement just like a table
Views are named table expressions with definitions stored in a database
Like derived tables and CTEs, queries that use views can provide encapsulation and simplification
From an administrative perspective, views can provide a security layer to a database


*/
--=================================================================
--Creating Simple Views
-------------------------
--Views are saved queries created in a database by administrators and developers
--Views are defined with a single SELECT statement
--ORDER BY is not permitted in a view definition without the use of TOP, OFFSET/FETCH, or FOR XML
--To sort the output, use ORDER BY in the outer query
--View creation supports additional options beyond the scope of this class

go
Create view VW_ShowEmployees
as
select EmployeeId , Firstname , Lastname ,Country  
from employees
where EmployeeId >5
go

--Now You Can call view 
select * from VW_ShowEmployees
--With Where 
select * from VW_ShowEmployees where country='UK'
--With Order By
select * from VW_ShowEmployees where country='UK' order by Firstname
--============================================================================
--Lesson 2: Using Inline TVFs
--------------------------------
--Writing Queries That Use Inline TVFs
--Creating Simple Inline TVFs
--Retrieving from Inline TVFs
--Demonstration: Inline TVFs

--Writing Queries That Use Inline TVFs
---------------------------------------
--TVFs are named table expressions with definitions stored in a database
--TVFs return a virtual table to the calling query
--SQL Server provides two types of TVFs:
--Inline, based on a single SELECT statement
--Multi-statement, which creates and loads a table variable
--Unlike views, TVFs support input parameters
--Inline TVFs may be thought of as parameterized views


--Creating Simple Inline TVFs:-
--------------------------------
--TVFs are created by administrators and developers
--Create and name function and optional parameters with CREATE FUNCTION
--Declare return type as TABLE
--Define inline SELECT statement following RETURN



GO
Create function Fn_ShowEmployeeOrder (@employeeId int)
returns table 
as 
return Select * from Orders Where EmployeeID =@employeeId
GO
Select * from Fn_ShowEmployeeOrder(1)
Select * from Fn_ShowEmployeeOrder(3)




go
Create function Fn_test(@OID int)
returns table 
as 
return select orderId ,Quantity ,UnitPrice,cast(quantity * unitprice as decimal(9,2)) as Total
       from [Order Details]
	   where OrderID = @OID;
go
select * from fn_test(10248) 


-----------------  ----Demo on Function ----------------------------------
-- string Function
  go 
  create function Fun_MyStringFun(@x nvarchar(100))
  returns nvarchar(100)
  begin 
   return (Concat(Upper( substring(ltrim(@x),1,1)) ,lower(substring (ltrim(@x),2,len(@x)))))
  end 
go
Select firstname ,[dbo].[Fun_MyStringFun](firstname + lastname)from Employees 
--=================================================================================================
--Lesson 3: Using Derived Tables
---------------------------------
--Writing Queries with Derived Tables
--Guidelines for Derived Tables
--Using Aliases for Column Names in Derived Tables
--Passing Arguments to Derived Tables
--Nesting and Reusing Derived Tables
--Demonstration: Using Derived Tables

--Writing Queries with Derived Tables
--------------------------------------
--Derived tables are named query expressions created within an outer SELECT statement
--Not stored in databaseórepresents a virtual relational table
--When processed, unpacked into query against underlying referenced objects
--Allow you to write more modular queries

--SELECT <column_list>
--FROM	(
--	<derived_table_definition>
--	) AS <derived_table_alias>;

--Scope of a derived table is the query in which it is defined
/*
--Notes 
-------
--Derived Tables Must:-
------------------------
1-Have an alias
2-Have names for all columns
3-Have unique names for all columns
4-Not use an ORDER BY clause (without TOP or OFFSET/FETCH)
5-Not be referred to multiple times in the same query

Derived Tables May:-
---------------------
1-Use internal or external aliases for columns
2-Refer to parameters and/or variables
3-Be nested within other derived tables

*/
--Column aliases may be defined inline:
SELECT orderyear, COUNT(DISTINCT customerID) AS cust_count
FROM (SELECT YEAR(orderdate) AS orderyear, CustomerID FROM Orders) AS derived_year
GROUP BY orderyear;

--Column aliases may be defined externally:
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM (SELECT YEAR(orderdate), CustomerID FROM Orders) AS derived_year(orderyear, custid)
GROUP BY orderyear;
----------------------------------------------------------------------------------------------
--Passing Arguments to Derived Tables
--Derived tables may refer to arguments
--Arguments might be:
--Variables declared in the same batch as the SELECT statement
--Parameters passed into a table-valued function or stored procedure

DECLARE @empid INT = 9;
SELECT orderyear, COUNT(DISTINCT CustomerID) AS cust_count
FROM (SELECT YEAR(orderdate) AS orderyear, customerID FROM Orders WHERE EmployeeID=@empid) AS derived_year
GROUP BY orderyear;
--==============================================================================================================
--Lesson 4: Using CTEs :-
--=========================
							/*
							Writing Queries with CTEs
							Creating Queries with Common Table Expressions
							*/
--
/*
CTE Common Table Exprssion 
Writing Queries with CTEs
CTEs are named table expressions defined in a query
CTEs are similar to derived tables in scope and naming requirements
Unlike derived tables, CTEs support multiple definitions, multiple references, and recursion

Syntax-
-------------------------------------
WITH <CTE_name> 
AS (
	<CTE_definition>
)
<outer query referencing CTE>;
--------------------------------------
To create a CTE:-
-----------------
Define the table expression in a WITH clause
Assign column aliases (inline or external)
Pass arguments if desired
Reference the CTE in the outer query

*/
select * from orders
go 
with Ctp_year
as
(
select year(orderDate) as OrderYear ,customerID from orders
)
select orderyear,count(distinct customerid)as CustCount
from Ctp_year 
Group By orderyear


--#table
  Select * into T1  from Employees 
  Select * into #T1  from Employees 
--##table 

  Select * into ##T1  from Employees 
  Select * from ##t1

--=======================================================================
--Module 12
--Using Set Operators 
-----------------------------
-- Combining Result Sets by Using the UNION Operator
-- --------------------------------------------------
/*
Each Query Must Have:
--------------------
* Similar data types
* Same number of columns 
* Same column order in select list
* By default, the UNION operator removes duplicate rows 
  from the result set. 
  If you use ALL, all rows are included in the results and 
  duplicates are not removed.
* Any number of UNION operators can appear in a Transact-SQL statement
*/

Create table TBL1(id  int);
Create table TBL2(id2 int);

Insert into TBL1 values(1),(2),(10),(20),(NULL);
Insert into TBL2 values(10),(10),(20),(30),(NULL);



Select * From tbl1
UNION                    -- All
Select * From tbl2;
--=======================================================================================================
-- Limiting Result Sets by Using the EXCEPT and INTERSECT Operators
-- ---------------------------------------------------------------- 
/*
-- EXCEPT returns any distinct values from the left query that are not 
   also found on the right query
-- INTERSECT returns any distinct values that are returned by both 
   the query on the left and right sides of the INTERSECT operand
   -- Conditions :
     --1.The number and the order of the columns must be the same in all queries.
     --2.The data types must be compatible.
     --3.The column names of the result set that are returned by EXCEPT or 
         INTERSECT are the same names as those returned by the 
         query on the left side of the operand.
 */
Select * From tbl1
EXCEPT
Select * From tbl2;

Select * From tbl1
INTERSECT 
Select * From tbl2;
--------------------------------------------------------------------------------
--union Like AND
-- only ---  = distinct
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;
---------------------------------------
--- only ---- all 
SELECT City FROM Customers
UNION all 
SELECT City FROM Suppliers
ORDER BY City;
---------------------------------------
select firstname+' '+lastname as [Full Name]
from employees
where title='Sales Representative'
union all
select contactname 
from customers
where contacttitle='Sales Representative'
------------------------------------------------------------
select firstname+' '+lastname as [Full Name]
from employees
union all
select contactname 
from customers
---------------------------------------------------------------------------------------------------
/* Lesson 2) Using EXCEPT and INTERSECT :-
------------------------------------- 
    - INTERSECT :- 
	              - Returns only distinct rows that appear in both result sets.
				  - Order in which sets are not matters.
	- EXCEPT  :-
	              - Returns only distinct rows that appear in the left set but not the right.
				  - Order in which sets are specified matters.
-- INTERSECT Syntax :-
-- <query_1> INTERSECT <query_2>
----------------------------------
-- EXCEPT Syntax :-
-- <query_1> EXCEPT <query_2>
----------------------------------
*/
-- INTERSECT Example :- 
-- Get Distinct Country in both Employees & Customers
SELECT Country FROM Employees 
INTERSECT
SELECT Country FROM Customers  
GO   


-- EXCEPT Example :- 
-- Get Distinct Country in Customers and Not in Employees
SELECT Country FROM Customers
EXCEPT 
SELECT Country FROM Employees  
GO   






Select country from Customers
union  ALL
Select Country From Employees
/*
 -- The Difference Between Set Operators and Joins:-
 -----------------------------------------------------
  UNION combines rows. In comparison, JOIN combines columns from different sources. 

        -------------------------------------------------------------------
		|		  ( Joins )              |        ( Set operators )       |
		|		 ===========             |       ===================      |
		-------------------------------------------------------------------
	    | A) Combine multiple tables     |  A) Combine multiple SELECTs   |
		-------------------------------------------------------------------
		| B) Performs a horizontal join  |  B) Performs avertical  join   |                       
		-------------------------------------------------------------------
*/
--================================================================================================================
/*
Lesson 3: Using APPLY
-----------------------
								Using the APPLY Operator
								The CROSS APPLY Operator
								The OUTER APPLY Operator
								CROSS APPLY and OUTER APPLY Features

APPLY is a table operator used in the FROM clause
Two formsóCROSS APPLY and OUTER APPLY
Operates on two input tables, referred to as left and right
Right table may be any table expression including 
a derived table or a table-valued function


											1-CROSS APPLY
											2-OUTER APPLY


SELECT <column_list>
FROM <left_table_source> AS <alias>
[CROSS]|[OUTER] APPLY 
    <right_table_source> AS <alias>;
*/
-----------------------------------------------------------------------
--Lab
Create DataBase CrossApplyDB
go 
use CrossApplyDB
go
Create table Departments (
Id int Primary key identity ,
Name nvarchar(50))
go
insert into Departments values ('IT' ),('Sales'),('HR');
go

Create table Employees (ID int Primary Key identity,
                        Name nvarchar(50),
						Gender Nvarchar(10),
						Salary decimal(9,2),
						DepartementID int Constraint FK_Depart foreign key References Departments (ID));  
go
insert into Employees values ('Ahmed','Male',3000,1),
                             ('retaj','Female',5000,3),
							 ('Mariam','Female',6000,1);
go
select * from Departments
select * from Employees
		  
select e.Name ,e.Salary ,e.Gender ,d.Name
from Departments as d inner join employees as e  
on d.Id = e.DepartementID;

select e.Name ,e.Salary ,e.Gender ,d.Name
from Departments as d left outer join employees as e  
on d.Id = e.DepartementID;

--Cross Apply , Outer Apply 
go
-- TVF 
Create function Fn_show (@id int) 
returns Table
as 
return (select * from employees where DepartementID = @id) 
go
select * from fn_show (1)
go
-------------------------
--Join between Function And table 
--Join
select e.Name ,e.Salary ,e.Gender ,d.Name
from Departments as d inner join fn_show(d.ID) as e  
on d.Id = e.DepartementID;

--Cross Apply  = Inner Join
select e.Name ,e.Salary ,e.Gender ,d.Name
from Departments as d Cross apply fn_show(d.ID) as e 
--on d.Id = e.DepartementID; 

--Outer Apply = Left outer join 
select e.Name ,e.Salary ,e.Gender ,d.Name
from Departments as d left outer join employees as e  
on d.Id = e.DepartementID;


select e.Name ,e.Salary ,e.Gender ,d.Name
from Departments as d outer apply fn_show(d.ID) as e 
-------------------------------------------------------------------------
--The CROSS APPLY Operator
SELECT o.orderid, o.orderdate,od.productid, od.unitprice, od.Quantity 
FROM  Orders AS o CROSS APPLY (SELECT ProductID, unitprice, Quantity 
FROM [Order Details] AS so 
WHERE so.orderid = o.orderid) AS od;


go
Create function funtest(@ID int)
returns table 
as 
return (SELECT ProductID, unitprice, Quantity 
FROM [Order Details] AS so 
WHERE so.orderid = @ID)
go


SELECT o.orderid, o.orderdate,od.productid, od.unitprice, od.Quantity 
FROM  Orders AS o Outer APPLY (select * from funtest(10284)) AS od;


--OUTER APPLY applies the right table source to each row in the left table source
--All rows from the left table source are returnedóvalues from the right table source are returned where they exist, 
   -- otherwise NULL is returned
--Most LEFT OUTER JOIN statements can be rewritten as OUTER APPLY statements

SELECT DISTINCT s.country AS supplier_country, c.country as customer_country
FROM Suppliers AS s OUTER APPLY (SELECT country FROM Customers AS cu WHERE cu.country = s.country) AS c
ORDER BY supplier_country;
--===============================================================================================================================
/*
 Module 13
 Using Window Ranking, Offset, and Aggregate Functions
--------------------------------------------------------
 Lessons :-
--------------
               1) Creating Windows with OVER.
			   2) Exploring Window Functions.
---------------------------------------------------------------------------------------------------
-- Lesson 1) Creating Windows with OVER :-
------------------------------------------
A) SQL Windowing
-----------------
	            - Windows extend T-SQL's set-based approach.
				- Windows allow you to specify an order as part of a calculation, 
				          without regard to order of input or final output order
			    - Windows allow partitioning and framing of rows to support functions.
				- Window functions can simplify queries that need to find running totals, moving averages, or gaps in data.
--------------------------------------------------------------------------------------
B) Using OVER () 
-----------------
	           - OVER defines a window, or set, of rows to be used by a window function, including any ordering.
			   - With a partition clause, OVER clause restricts the set of rows to those with the same values in the partitioning elements
			   - By itself, OVER() is unrestricted and includes all rows.
			   - Multiple OVER clauses can be used in a single query, each with its own partitioning and ordering, if needed.
	Syntax :-
	----------
	OVER ( [ <PARTITION BY clause> ] 
	       [ <ORDER BY clause> ] 
	       [ <ROWS or RANGE clause> ] 
	     ) 
------------------------------------------------------------------------------------
C) Partitioning Windows
-------------------------
		       - Partitioning limits a set to rows with same value in the partitioning column.
			   - Use PARTITION BY in the OVER() clause
               - Without a PARTITION BY clause defined, OVER() creates a single partition of all rows
*/
-- PARTITION BY Example :-
SELECT ProductID,OrderID ,Quantity, SUM(Quantity) OVER ( PARTITION BY ProductID ) AS Total_Quantity_For_Product
FROM  [Order Details]
GO
Use Northwind
GO
Select * from [Order Details]
/*----------------------------------------------------------------------------------
D) Ordering and Framing :-
-----------------------------
    - Window framing allows you to set start and end boundaries within a window partition.
	- UNBOUNDED means go all the way to boundary in direction specified by PRECEDING or FOLLOWING (start or end).
	- CURRENT ROW indicates start or end at current row in partition.
	- ROWS BETWEEN allows you to define a range of rows between two points.
	- Window ordering provides a context to the frame :- 
	        A) Sorting by an attribute enables meaningful position of a boundary
            B) Without ordering, "start at first row" is not useful because a set has no order
*/
Select * , Sum(Quantity) over(Partition By ProductID Order By Quantity ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) from [Order Details]


SELECT ProductID,OrderID,Quantity,
       SUM(Quantity) OVER (PARTITION BY ProductID ORDER BY Quantity ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningQty 
FROM [Order Details]
GO
---------------------------------------------------------------------------------------------------
/*
-- Lesson 2) Exploring Window Functions :-
-------------------------------------------
           - A window function is a function applied to a window, or set, of rows.
		   - Window functions include aggregate, ranking, distribution, and offset functions
		   - Window functions depend on set created by OVER()
*/

-- Window Aggregate Functions
SELECT   ProductID,Quantity,
		 SUM(Quantity) OVER (PARTITION BY ProductID) AS "Total Quantity For Product",
         AVG(Quantity) OVER (PARTITION BY ProductID) AS "Average Quantity For Product"   
FROM   [Order Details]

-- Window Ranking Function
1
-- With Over 
SELECT   ProductID,UnitPrice,
         ROW_NUMBER() OVER (ORDER BY UnitPrice) AS "Row Number",
	     RANK() OVER (ORDER BY UnitPrice) AS Rank,
	     DENSE_RANK() OVER (ORDER BY UnitPrice) AS "Dense Rank"
FROM   Products

-- Window Ranking Functions
-- With OVER AND Partition BY
SELECT   ProductID, UnitPrice,
		 ROW_NUMBER() OVER (ORDER BY ProductID) AS "Row Number",
         ROW_NUMBER() OVER (PARTITION BY ProductID ORDER BY ProductID) AS "Row Number Partition"   
FROM   [Order Details]

--==================================================================================================
/*
*) Window offset functions allow comparisons between rows in a set without the need for a self-join
*) Offset functions operate on a position relative to the current row, or to the start or end of the window frame

LAG:-
-----
Returns an expression from a previous row that is a defined offset from the current row. 
Returns NULL if no row at specified position.


LEAD:-
------
Returns an expression from a later row that is a defined offset from the current row. 
Returns NULL if no row at specified position.



FIRST_VALUE:-
-------------
Returns the first value in the current window frame. 
Requires window ordering to be meaningful.
Introduced in SQL Server 2012 
Order By         Required
Partition By     Optional

LAST_VALUE:-
------------
Returns the last value in the current window frame. 
Requires window ordering to be meaningful.


*/
--First_Value 
select * from Products
select ProductId , ProductName , Unitprice from Products  

select ProductId , ProductName , Unitprice,
FIRST_VALUE(unitprice) over(order by unitprice) as FValue 
from Products  

--using Script SmartDay13DB
--using Script SmartDay13DB
----------------------------------------------------

Create database WindowOffsetFunctionsDB
go
USE WindowOffsetFunctionsDB
GO


CREATE TABLE SmartOrders(
	OrderID  int primary Key  identity,
	OrderDate Date NOT NULL,
	productId int NOT NULL,
	UnitPrice decimal(9,2) NOT NULL
	
) 
INSERT SmartOrders (OrderDate , productId, UnitPrice) VALUES ('1-1-2018',1,100),
                                                             ('1-2-2018',1,100),
															 ('1-3-2018',1,100),
															 ('1-4-2018',1,100),
															 ('1-5-2018',1,100),
															 ('1-6-2018',1,110),
															 ('1-7-2018',1,110),
															 ('1-8-2018',1,110),
															 ('1-9-2018',1,110),
															 ('1-10-2018',1,110),
															 ('1-11-2018',1,115),
															 ('1-12-2018',1,115),
															 ('1-13-2018',1,115),
															 ('1-14-2018',1,115),
															 ('1-15-2018',1,115),
															 ('1-16-2018',2,200),
															 ('1-16-2018',2,200),
															 ('1-17-2018',2,200),
															 ('1-18-2018',2,220),
															 ('1-19-2018',2,220),
															 ('1-20-2018',2,230),
															 ('1-21-2018',2,230)

select * from smartOrders

select * from smartOrders where productId = 1

 
select OrderID ,orderdate, ProductID , Unitprice,
FIRST_VALUE(unitprice) over(order by unitprice) as FValue 
from smartOrders
where productID =1



select OrderID ,orderdate, ProductID , Unitprice,
last_value(unitprice) over(order by unitprice) as LValue 
from smartOrders
where productID =1

--Rate Unitprice in INCR
select count (OrderID), ProductID , Unitprice,
last_value(unitprice) over( order by unitprice ) as LValue 
from smartOrders
where productID =1
group by  ProductID , Unitprice

--previous 
SELECT OrderID ,orderdate, ProductID , Unitprice,
   LAG (Unitprice, 1,0) OVER (PARTITION BY productID  ORDER BY orderID) AS ProviousPrice
from smartOrders
where productID=1;



---Next 
SELECT OrderID ,orderdate, ProductID , Unitprice,
   LEAD (Unitprice, 1,0) OVER (PARTITION BY productID ORDER BY orderID) AS nextPrice
from smartOrders
where productID=1;



SELECT  orderdate,Nxt_Price, Prv_Price 
FROM
(
SELECT OrderID ,orderdate, ProductID , Unitprice,
   LAG (Unitprice, 1,0) OVER (PARTITION BY productID  ORDER BY orderID) as Prv_Price,
   LEAD (Unitprice, 1,0) OVER (PARTITION BY productID ORDER BY orderID) as Nxt_Price
 from smartOrders where productID=1)as src
 where Nxt_Price <> Unitprice

--========================
/*
Module 14 
Pivoting and Grouping Sets
---------------------------
-- lessons :-
--------------
	      -1 Writing Queries with PIVOT and UNPIVOT. 
          -2 Working with Grouping Sets.
---------------------------------------------------------------------------------------------
-- Lesson 1) PIVOT & UNPIVOT :- 
---------------------------------
  -- PIVOT :-
  ------------
           - Pivoting data is rotating data from a rows-based orientation to a columns-based orientation.
		   - Pivoting includes three phases :-
                       1) Grouping    :- Determines from FROM clause which element gets a row in the result set 
                       2) Spreading   :- Provides the distinct values to be pivoted across
                       3) Aggregation :- Performs an aggregation function (such as SUM,Count,etc..)
  -- UNPIVOT :-
  -------------
			- Unpivoting data is the logical reverse of pivoting data
			- Instead of turning rows into columns, unpivot turns columns into rows.
			- This is a technique useful in taking data that has already been pivoted.
			- Unpivoting includes three elements :-
                          1) Source columns to be unpivoted
                          2) Name to be assigned to new values column
                          3) Name to be assigned to names columns
			- Unpivoting does not restore the original data. 
			- Detail-level data was lost during the aggregation process in the original pivot.
			- UNPIVOT has no ability to allocate values to return to original detail values. 
*/
-- Example1 
-------------
use tempdb

create table t1 (CustomerName Nvarchar(10),
                 ProductName nvarchar(10),
				 Price decimal(9,2));

insert into t1 values ('Ahmed','TShirt',200),
('yasser','TShirt',100),('Ahmed','Shoes',300),
('yasser','Latop',4000),('Ahmed','PC',3200),
('aya','TShirt',300),('aya','latop',5200)

select * from t1

select customerName ,Tshirt , Latop
from (select customerName,ProductName,price from t1) as d
pivot
(
sum(price) for productname in(Tshirt , Latop) 
)as piv

-----------------------------------------------------------------------------------
-- Example2
---------------
Use Northwind 
select * from orders
select c.CategoryName,od.Quantity,year(o.OrderDate) as OrderYear into p1
from [Order Details] as od inner join Products as p 
on od.ProductID = p.ProductID inner join Categories as c 
on p.CategoryID = c.CategoryID inner join Orders as o 
on od.OrderID =o.OrderID

select * from p1

select Categoryname ,[1996],[1997],[1998] into p2
from (select Categoryname,quantity ,orderYear from p1)as d
pivot (sum(quantity) for orderYear in ([1996],[1997],[1998]) ) as pvt
order by Categoryname

select * from p2

select Categoryname,qty,orderyear
from p2
unpivot (qty for orderyear in ([1996],[1997],[1998])) as u

--------------------------------------------------------------------------------------------------------
-- Example 2) Pivot
-- For Each Employee ( Count Orders For Each Year )
WITH CTE
AS (SELECT EmployeeID,OrderID,YEAR(OrderDate) AS OrderYear FROM Orders) 
SELECT EmployeeID , [1996], [1997],[1998]
FROM   CTE
PIVOT(Count(OrderID) FOR OrderYear IN ([1996], [1997],[1998]) )AS PIVOTT
ORDER BY EmployeeID
GO

-- Example 2) Pivot
-- For Each Year ( Count Orders For Each Employee)
WITH CTE
AS 
(SELECT OrderID,EmployeeID,YEAR(OrderDate) AS OrderYear FROM  Orders)
SELECT OrderYear ,[1],[2],[3],[4],[5],[6],[7],[8],[9] FROM CTE
PIVOT ( COUNT(OrderID) FOR EmployeeID IN ([1],[2],[3],[4],[5],[6],[7],[8],[9]) ) AS PIV
GO

-- Example 3) UNPIVOT
-- Lets Make Result From Example 1 Physical Table
-- Using SELECT xx xx xx Into 
WITH CTE
AS (SELECT EmployeeID,OrderID,YEAR(OrderDate) AS OrderYear FROM Orders) 
SELECT EmployeeID , [1996], [1997],[1998] INTO TBL1001
FROM   CTE
PIVOT(Count(OrderID) FOR OrderYear IN ([1996], [1997],[1998]) )AS PIVOTT
ORDER BY EmployeeID
GO

-- Show New TABLE
SELECT * FROM TBL1001

-- Using UNPIVOT
SELECT EmployeeID,OrderYear,TotalOrders
FROM   TBL1001
UNPIVOT ( TotalOrders FOR OrderYear IN ([1996], [1997],[1998])) AS UP
Order BY OrderYear,EmployeeID
GO
---------------------------------------------------------------------------------------------
/*
-- Lesson 2) Grouping Sets :-
------------------------------
   - Grouping Sets :-
   -------------------
     - GROUPING SETS subclause builds on T-SQL GROUP BY clause.
	 - Allows multiple groupings to be defined in same query.
	 - Alternative to use of UNION ALL to combine multiple outputs (each with different GROUP BY) into one result set.
-- Syntax
----------
SELECT <column list with aggregate(s)>
FROM <source>
GROUP BY 
GROUPING SETS(
	(<column_name>),--one or more columns
	(<column_name>),--one or more columns
	() -- empty parentheses if aggregating all rows
)
*/-- Examples
---------------
use tempdb
go
-- Creating Sample Table
CREATE TABLE A101(ID INT,Name  VARCHAR(50),Country VARCHAR(50),Gender VARCHAR(50),Salary SmallMoney)
GO
-- Inserting Data
INSERT A101 VALUES (1,'Ali','Egypt','Male','1200'),
                   (2,'Jon','USA','Male','4500'),
	               (3,'Sara','Egypt','Female','1200'),
	               (4,'Lara','USA','Female','4000'),
	               (5,'Mohamed','UK','Male','5000'),
	               (6,'Katy','UK','Female','2000'),
	               (7,'Samy','Egypt','Male','80000')
GO
-- Display Table
SELECT * FROM A101
GO
-- 1) Grouping by Country & Gender
SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country , Gender
GO
-- 2) Grouping by Country 
SELECT Country,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country 
GO
-- 3) Grouping by Gender
SELECT Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY  Gender
GO
-- 4)  Total Salary
SELECT SUM(Salary) AS TotalSalary 
FROM A101
GO
---------------------------------------
-- All 4 Result in 1 Report
-- Using UNION ALL
SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country , Gender
UNION ALL
SELECT Country,NULL,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country
UNION ALL
SELECT NULL,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Gender
UNION ALL
SELECT NULL,NULL,SUM(Salary) AS TotalSalary 
FROM A101
GO

-- Same Result With GROUPING SETS
-- better Performance and Readability
SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY GROUPING SETS ((Country,Gender),  (Country),(Gender),())
GO

SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY cube(Country,Gender)
GO

--Grouping_ID

select Grouping_ID(Country) as C_Group,Grouping_ID(Gender) as G_Group,SUM(Salary) AS TotalSalary ,Country ,Gender
from A101
group by cube(Country,Gender)


select Grouping_ID(Country) as C_Group,Grouping_ID(Gender) as G_Group,SUM(Salary) AS TotalSalary ,Country ,Gender
from A101
group by cube(Country,Gender)
--having Grouping_ID(Gender) =1 
--having Grouping_ID(Country) =1
having Grouping_ID(Gender) =1  and Grouping_ID(Country) =1
--====================================================================================================================================================================================
/*
Module 14 
Pivoting and Grouping Sets
---------------------------
-- lessons :-
--------------
	      -1 Writing Queries with PIVOT and UNPIVOT. 
          -2 Working with Grouping Sets.
---------------------------------------------------------------------------------------------
-- Lesson 1) PIVOT & UNPIVOT :- 
---------------------------------
  -- PIVOT :-
  ------------
           - Pivoting data is rotating data from a rows-based orientation to a columns-based orientation.
		   - Pivoting includes three phases :-
                       1) Grouping    :- Determines from FROM clause which element gets a row in the result set 
                       2) Spreading   :- Provides the distinct values to be pivoted across
                       3) Aggregation :- Performs an aggregation function (such as SUM,Count,etc..)
  -- UNPIVOT :-
  -------------
			- Unpivoting data is the logical reverse of pivoting data
			- Instead of turning rows into columns, unpivot turns columns into rows.
			- This is a technique useful in taking data that has already been pivoted.
			- Unpivoting includes three elements :-
                          1) Source columns to be unpivoted
                          2) Name to be assigned to new values column
                          3) Name to be assigned to names columns
			- Unpivoting does not restore the original data. 
			- Detail-level data was lost during the aggregation process in the original pivot.
			- UNPIVOT has no ability to allocate values to return to original detail values. 
*/
-- Example1 
-------------
use tempdb

create table t1 (CustomerName Nvarchar(10),
                 ProductName nvarchar(10),
				 Price decimal(9,2));

insert into t1 values ('Ahmed','TShirt',200),
('yasser','TShirt',100),('Ahmed','Shoes',300),
('yasser','Latop',4000),('Ahmed','PC',3200),
('aya','TShirt',300),('aya','latop',5200)

select * from t1

select customerName ,Tshirt , Latop
from (select customerName,ProductName,price from t1) as d
pivot
(
sum(price) for productname in(Tshirt , Latop) 
)as piv

-----------------------------------------------------------------------------------
-- Example2
---------------
Use Northwind 
select * from orders
select c.CategoryName,od.Quantity,year(o.OrderDate) as OrderYear into p1
from [Order Details] as od inner join Products as p 
on od.ProductID = p.ProductID inner join Categories as c 
on p.CategoryID = c.CategoryID inner join Orders as o 
on od.OrderID =o.OrderID

select * from p1

select Categoryname ,[1996],[1997],[1998] into p2
from (select Categoryname,quantity ,orderYear from p1)as d
pivot (sum(quantity) for orderYear in ([1996],[1997],[1998]) ) as pvt
order by Categoryname

select * from p2

select Categoryname,qty,orderyear
from p2
unpivot (qty for orderyear in ([1996],[1997],[1998])) as u

--------------------------------------------------------------------------------------------------------
-- Example 2) Pivot
-- For Each Employee ( Count Orders For Each Year )
WITH CTE
AS (SELECT EmployeeID,OrderID,YEAR(OrderDate) AS OrderYear FROM Orders) 
SELECT EmployeeID , [1996], [1997],[1998]
FROM   CTE
PIVOT(Count(OrderID) FOR OrderYear IN ([1996], [1997],[1998]) )AS PIVOTT
ORDER BY EmployeeID
GO

-- Example 2) Pivot
-- For Each Year ( Count Orders For Each Employee)
WITH CTE
AS 
(SELECT OrderID,EmployeeID,YEAR(OrderDate) AS OrderYear FROM  Orders)
SELECT OrderYear ,[1],[2],[3],[4],[5],[6],[7],[8],[9] FROM CTE
PIVOT ( COUNT(OrderID) FOR EmployeeID IN ([1],[2],[3],[4],[5],[6],[7],[8],[9]) ) AS PIV
GO

-- Example 3) UNPIVOT
-- Lets Make Result From Example 1 Physical Table
-- Using SELECT xx xx xx Into 
WITH CTE
AS (SELECT EmployeeID,OrderID,YEAR(OrderDate) AS OrderYear FROM Orders) 
SELECT EmployeeID , [1996], [1997],[1998] INTO TBL1001
FROM   CTE
PIVOT(Count(OrderID) FOR OrderYear IN ([1996], [1997],[1998]) )AS PIVOTT
ORDER BY EmployeeID
GO

-- Show New TABLE
SELECT * FROM TBL1001

-- Using UNPIVOT
SELECT EmployeeID,OrderYear,TotalOrders
FROM   TBL1001
UNPIVOT ( TotalOrders FOR OrderYear IN ([1996], [1997],[1998])) AS UP
Order BY OrderYear,EmployeeID
GO
---------------------------------------------------------------------------------------------
/*
-- Lesson 2) Grouping Sets :-
------------------------------
   - Grouping Sets :-
   -------------------
     - GROUPING SETS subclause builds on T-SQL GROUP BY clause.
	 - Allows multiple groupings to be defined in same query.
	 - Alternative to use of UNION ALL to combine multiple outputs (each with different GROUP BY) into one result set.
-- Syntax
----------
SELECT <column list with aggregate(s)>
FROM <source>
GROUP BY 
GROUPING SETS(
	(<column_name>),--one or more columns
	(<column_name>),--one or more columns
	() -- empty parentheses if aggregating all rows
)
*/-- Examples
---------------
use tempdb
go
-- Creating Sample Table
CREATE TABLE A101(ID INT,Name  VARCHAR(50),Country VARCHAR(50),Gender VARCHAR(50),Salary SmallMoney)
GO
-- Inserting Data
INSERT A101 VALUES (1,'Ali','Egypt','Male','1200'),
                   (2,'Jon','USA','Male','4500'),
	               (3,'Sara','Egypt','Female','1200'),
	               (4,'Lara','USA','Female','4000'),
	               (5,'Mohamed','UK','Male','5000'),
	               (6,'Katy','UK','Female','2000'),
	               (7,'Samy','Egypt','Male','80000')
GO
-- Display Table
SELECT * FROM A101
GO
-- 1) Grouping by Country & Gender
SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country , Gender
GO
-- 2) Grouping by Country 
SELECT Country,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country 
GO
-- 3) Grouping by Gender
SELECT Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY  Gender
GO
-- 4)  Total Salary
SELECT SUM(Salary) AS TotalSalary 
FROM A101
GO
---------------------------------------
-- All 4 Result in 1 Report
-- Using UNION ALL
SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country , Gender
UNION ALL
SELECT Country,NULL,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Country
UNION ALL
SELECT NULL,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY Gender
UNION ALL
SELECT NULL,NULL,SUM(Salary) AS TotalSalary 
FROM A101
GO

-- Same Result With GROUPING SETS
-- better Performance and Readability
SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY GROUPING SETS ((Country,Gender),  (Country),(Gender),())
GO

SELECT Country,Gender,SUM(Salary) AS TotalSalary 
FROM A101
GROUP BY cube(Country,Gender)
GO

--Grouping_ID

select Grouping_ID(Country) as C_Group,Grouping_ID(Gender) as G_Group,SUM(Salary) AS TotalSalary ,Country ,Gender
from A101
group by cube(Country,Gender)


select Grouping_ID(Country) as C_Group,Grouping_ID(Gender) as G_Group,SUM(Salary) AS TotalSalary ,Country ,Gender
from A101
group by cube(Country,Gender)
--having Grouping_ID(Gender) =1 
--having Grouping_ID(Country) =1
having Grouping_ID(Gender) =1  and Grouping_ID(Country) =1
--===========================================================================================================
/*
Module 15 
Executing Stored Procedures
------------------------------

				Querying Data with Stored Procedures
				Passing Parameters to Stored Procedures
				Creating Simple Stored Procedures
				Working with Dynamic SQL


Lesson 1: Querying Data with Stored Procedures
-----------------------------------------------
			Examining Stored Procedures
			Executing Stored Procedures


Examining Stored Procedures
	- Stored procedures are collections of T-SQL statements stored in a database
	- Procedures can return results, manipulate data, and perform administrative actions on the server
	- With other objects, procedures can provide a trusted application programming interface to a database, insulating applications from database structure changes
			* Use views, functions, and procedures to return data
			* Use procedures to modify and add new data
			* Alter procedure definition in one place, rather than update application code

Executing Stored Procedures
      -Invoke a stored procedure using EXECUTE or EXEC
      -Call procedure with two-part name
      -Pass parameters in @name=value form, using appropriate data type
*/
use Northwind
go
--Create Procedure
Create Proc sp_ShowEmployees
as 
begin 
   select employeeId , FirstName,Lastname,Country from employees
end

--call Procedure 
exec sp_ShowEmployees
------------------------------------------------------------------------------------------------
--Lesson 2: Passing Parameters to Stored Procedures
-------------------------------------------------------
			--Passing Input Parameters to Stored Procedures

/*
Parameters are defined in the header of the procedure code, including name, data type and direction (input is default)
Parameters are discoverable using SQL Server Management Studio and the sys.parameters view
To pass parameters in an EXEC statement, use names defined in procedure

*/
go
Create  Proc sp_ShowEmployeesByCountry @Country nvarchar(50) 
as 
begin 
   select employeeId , FirstName,Lastname,Country 
   from employees
   where Country = @Country
end
go

exec sp_ShowEmployeesByCountry 'usa'

-------------------------------------------------------------------------------
/*
Writing Queries with Dynamic SQL

 - Using sp_executesql
			- Accepts string as code to be run
			- Supports input, output parameters for query
			- Allows parameterized code while minimizing risk of SQL injection
			- Can perform better than EXEC due to query plan reuse

Syntax:-
--------
DECLARE @sqlcode AS NVARCHAR(256) = 	N'<code_to_run>';
EXEC sys.sp_executesql @statement = @sqlcode;

DECLARE @sqlcode AS NVARCHAR(256) = N'SELECT GETDATE() AS dt';
EXEC sys.sp_executesql @statement = @sqlcode;



*/
DECLARE @sqlcode AS NVARCHAR(256) = N'SELECT GETDATE() AS dt';
EXEC sys.sp_executesql @statement = @sqlcode;

declare @Database nvarchar(100) = 'Northwind';
declare @Table nvarchar(100) = 'Employees';
declare @Columns nvarchar(200) = 'EmployeeId , FirstName,LastName , Country ';
declare @Condition nvarchar(100) = 'country = ''usa''';

declare @Command  nvarchar(max) = 'use '+ @database +';'+' select '+ @Columns + ' From ' + @table + ' Where ' + @condition;  
EXEC sys.sp_executesql  @command

--========================
--Module 16
--Programming with T-SQL
--======================== 
/*
T-SQL Programming Elements
Controlling Program Flow

Lesson 1: T-SQL Programming Elements :-
---------------------------------------
				Introducing T-SQL Batches
				Working with Batches
				Introducing T-SQL Variables
				Working with Variables
				Working with Synonyms

--Introducing T-SQL Batches
---------------------------
 1) T-SQL batches are collections of one or more T-SQL statements 
     sent to SQL Server as a unit for parsing, optimization, and execution
 2) Batches are terminated with GO by default
 3) Batches are boundaries for variable scope
 4) Some statements (for example, CREATE FUNCTION, CREATE PROCEDURE, CREATE VIEW) 
	may not be combined with others in the same batch


CREATE VIEW <view_name>
AS ...;
GO
CREATE PROCEDURE <procedure_name>
AS ...;
GO

-----------------------
--Working with Batches

     *) Batches are parsed for syntax as a unit
     *) Syntax errors cause the entire batch to be rejected
     *) Runtime errors may allow the batch to continue after failure, by default
Batches can contain error-handling code
*/
-- in SQL server 2012 Code Error

use Northwind
go
Create table t1(Id int , code int , name nvarchar(50))
go
insert into t1 VALUES(1,2,N'abc');

--InValid batch
INSERT INTO dbo.t1 VALUES(1,2,N'abc');
INSERT INTO dbo.t1 VALUES(2,3,N'def');
INSERT INTO dbo.t1 VALUE(1,2,N'abc');
INSERT INTO dbo.t1 VALUES(2,3,N'def');
GO


--Valid batch
INSERT INTO dbo.t1 VALUES(1,2,N'abc');
INSERT INTO dbo.t1 VALUES(2,3,N'def');
GO
--invalid batch
INSERT INTO dbo.t1 VALUE(1,2,N'abc');
INSERT INTO dbo.t1 VALUES(2,3,N'def');
GO
--Batches can contain error-handling code
--------------------------------------------------------------------------------------
--Introducing T-SQL Variables
------------------------------
/*
       - Variables are objects that allow storage of a value for use later in the same batch
       - Variables are defined with the DECLARE keyword
	        - In SQL Server 2008 and later, variables can be declared and initialized in the same statement
       - Variables are always local to the batch in which they're declared and go out of scope when the batch ends
*/
go
Create proc Sp_getAllProduct  @ID int
as 
begin 
   select * from Products where categoryID = @ID; 
end 
go
--Declare and initialize variables
DECLARE @catid INT = 2;
--Use variables to pass parameters to procedure
EXEC Sp_getAllProduct @catid
GO

------------------------------------------------------------
-- Working with Variables
--------------------------

--Initialize a variable using the DECLARE statement
DECLARE @i INT = 0;
--Assign a single (scalar) value using the SET statement
SET @i = 1;
--Assign a value to a variable using a SELECT statement
--Be sure that the SELECT statement returns exactly one row
SELECT @i = COUNT(*) FROM Orders;
select @i
----------------------------------------------------------------
-- Working with Synonyms
-------------------------
/*
 - A synonym is an alias or link to an object stored either on the same SQL Server instance or on a linked server
           *) Synonyms can point to tables, views, procedures, and functions
 - Synonyms can be used for referencing remote objects as though they were located locally,
    or for providing alternative names to other local objects
 - Use the CREATE and DROP commands to manage synonyms
*/

USE Northwind 
Go
Create Function Fn_ShowAllEmployeeInTheOrders()
returns table 
as 
return select EmployeeID from orders
GO

select * from Fn_ShowAllEmployeeInTheOrders()

GO
CREATE SYNONYM MyFun FOR 	Northwind.dbo.Fn_ShowAllEmployeeInTheOrders;
GO
select * from MyFun();

 --=======================================================================================================
 --Lesson 2: Controlling Program Flow
 --=================================

								--Understanding T-SQL Control-of-Flow Language
								--Working with IFÖELSE
								--Working with WHILE
/*
--Understanding T-SQL Control-of-Flow Language
-----------------------------------------------
   SQL Server provides additional language elements that control the flow of execution of T-SQL statements
        - Used in batches, stored procedures, and multistatement functions

   Control-of-flow elements allow statements to be performed in a specified order or not at all
       - The default is for statements to execute sequentially

   Includes IFÖELSE, BEGINÖEND, WHILE, RETURN, and others
*/
--=====
-- IF
--===== 
--True
--------
if 1=1
begin 
    print 'welcome in SQL'
end 
--False 
--------
if 1=2
begin 
    print 'Hello in SQL'
end 
else
begin 
    print 'Finish  SQL Course'
end 
--------------------------------------------
 if 1=1
 begin 
    select * from Employees
 end
 --------------------------------
 Declare @x int = 2;
 if @x = 1
 begin 
   select * from Employees
 end 
 ----------------------------------------------------------------
 declare @ID int ;
 select @ID=orderID from Orders where orderID = 10248
 
 if 1=1 
 begin 
 select * from [Order Details] 
 where OrderID = @ID
 end
 -----------------------------------------------------------------
IF OBJECT_ID('dbo.t1') IS NOT NULL
	select * from t1;
GO
-------------------------------------------------------------------
/*
IFÖELSE uses a predicate to determine the flow of the code
The code in the IF block is executed if the predicate evaluates to TRUE 
The code in the ELSE block is executed if the predicate evaluates to FALSE or UNKNOWN
Very useful when combined with the EXISTS operator
*/
--IF ... Else
if 1=2
begin 
    print 'Hello in SQL'
end 
else
begin 
    print 'Finish  SQL Course'
end
 
----------------------------------
 IF OBJECT_ID('dbo.t1') IS NULL
	PRINT 'Object does not exist';
ELSE
	select * from t1;
GO

--Meta Data Query 
select * from sys.dm_os_sys_info 
-- IF..Else Example :-
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES  WHERE TABLE_NAME = 'Employees')
   BEGIN 
         PRINT 'There is a Table'
		 select * from employees
   END 
ELSE
   BEGIN  
         PRINT 'Not Found' 
   END
GO
----------------------------------------------------------
--Working with WHILE
----------------------
-- WHILE enables code to execute in a loop
-- Statements in the WHILE block repeat as the predicate evaluates to TRUE
-- The loop ends when the predicate evaluates to FALSE or UNKNOWN
-- Execution can be altered by BREAK or CONTINUE
 -----------------------------
 --Loop While 
 Declare @x int = 1
 While (@X<=10)
 begin 
    Print concat('Welcome in SQL ',@x )
	set @x= @x+1 
 end 
 ----------------------------------------
 --break
 -------
 Declare @Number int = 1
 While (@Number<=10)
 begin 
    Print concat('Welcome in SQL ',@Number )
	set @Number= @Number+1 

	if(@number >5)
	  begin
	    break;
	  end
 end 
 -----------------------------------------------------
 --CONTINUE
 ------------
 Declare @Number int = 1
 While (@Number<=10)
 begin 
    Print concat('Welcome in SQL ',@Number )
	set @Number= @Number+1 

	if(@number <5)
	  begin
	    CONTINUE;
	  end
 end
 
 --------------------------------------------------------
 -- WHILE Example :-
DECLARE @empid AS INT = 1,
        @lname AS NVARCHAR(20)
WHILE  @empid <=5    
       BEGIN  
	        SELECT @lname = lastname 
			FROM Employees   
			WHERE EmployeeID = @empid  
			PRINT @lname  
			SET @empid += 1    
		END
GO 
/*
--===================================================================================================

/*
 Module 17
 Implementing Error Handling
-----------------------------------


-- lessons :-
--------------
       
	    1- Using TRY / CATCH Blocks.
		2- Working with Error Information.


---------------------------------------------------------------------------------------------

-- Lesson 1) Using TRY / CATCH Blocks :-
--------------------------------------------

   - Try...Catch paradigm it is basically two blocks of code with your stored procedures 
     that lets you execute some code, this is the Try section and if there are errors they are handled in the Catch section. 

   - Structured exception handling allows a centralized response to runtime errors :-
                          A) TRY to run a block of commands and CATCH any errors
						  B) Execution moves to the CATCH block of commands when an error occurs
						  C) No need to check every statement to see if an error occurred
						  D) You decide whether the transaction should be rolled back, errors logged, etc.

   - Not all errors can be caught by TRY / CATCH :- 
                          A) Syntax or compile errors.
						  B) Some name resolution errors.

   - TRY block defined by BEGIN TRY...END TRY statements :-
                          A) Place all code that might raise an error between them
						  B) No code may be placed between END TRY and BEGIN CATCH
						  C) TRY and CATCH blocks may be nested
						  D) CATCH block defined by BEGIN CATCH...END CATCH

   - Execution moves to the CATCH block when catchable errors occur within the TRY block
*/

-- Example
-- SQL SERVER 2000
SELECT 1 /0 --perform an operation 
IF @@ERROR<> 0   PRINT 'Error :P hahahah :P'
GO

-- SQL SERVER 2005 - 2016 
-- TRY ---- CATCH 

-- Example 
-- Create Stored Procedure
Create PROC Test1
@First int, @Second int
AS
BEGIN TRY 
SELECT @First/@Second
END TRY
BEGIN CATCH 
SELECT (@First+@Second) *2
END CATCH
GO

-- Run it , no error , 'Catch not working'
EXEC TEST1 4,2   -- No Error

-- Run it to get errro ' Catch working '
EXEC TEST1 10,0   -- Error 10/0 Can't happen

---------------------------------------------------------------------------------------------
/*
-- Lesson 2) Working with Error Information  :-
--------------------------------------------

          - SQL Server provides a set of metadata about runtime errors 
		    that may be queried (usually in a CATCH block) to return information about runtime errors.
		
		  - See Images Folder...

		  - SQL Server 2012 provides the new THROW statement.
		  - THROW enables you to include error-handling code in a CATCH block 
		    to raise the original runtime error and pass it to an upper layer,
		    such as a calling procedure or client application. 

		 - In previous versions of SQL Server, 
		   developers and administrators used the RAISERROR function to pass user-defined error messages to procedures and client applications.

		 - Use THROW instead of RAISERROR .
*/

-- Example For Error System Functions
-------------------------------------
BEGIN TRY
    SELECT 1/0
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
     ,ERROR_SEVERITY() AS ErrorSeverity
     ,ERROR_STATE() AS ErrorState
     ,ERROR_PROCEDURE() AS ErrorProcedure
     ,ERROR_LINE() AS ErrorLine
     ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH
GO

-- Example For THROW :-
-- Anywhere 
------------------------
THROW 50002,  -- this number is message number , USER range of 50000 to 2147483647. , System range 1-49999
'I Can send any message any time :P :P ',1


-- Example For THROW :-
-- With TRY....CATCH :-
------------------------
BEGIN TRY
	SELECT 100/0 AS 'Problem'
END TRY
BEGIN CATCH
	PRINT 'error :P';
	THROW 50022,'Type Anything You Want',16
END CATCH



/*
-- How to read SQL Server error messages :- 
-------------------------------------------

Here is a typical error message:-

Server: Msg 547, Level 16, State 1, Line # Message TextÖ.
---------------------------------------------------------------------

select * from sys.messages

1) Message number :- 
               - Each error message has a number. You can find most of the message numbers in the table sysmessages.
			   - (There some special numbers like 0 and 50000 that do not appear there.) 
			   - Message numbers from 50001 and up are user-defined. Lower numbers are system defined.


2) Severity level :-
               - A number from 0 to 25. If the severity level is in the range 0-10, the message is informational or a warning, and not an error.
			   - Errors resulting from programming errors in your SQL code have a severity level in the range 11-16. 
			   - Severity levels 17-25 indicate resource problems, hardware problems or internal problems in SQL Server, 
			     and a severity of 20 or higher is fatal, the connection will be terminated.

3) State :-
               - a value between 0 and 127. 
			   - The meaning of this item is specific to the error messages. 
			   - Microsoft has not documented these values.

4) Line :-
               - Line number within the procedure/function/trigger/batch the error occurred.
			   - A line number of 0 indicates that the problem occurred when the procedure was invoked.

5) Message text :-
               - The actual text of the message that tells you what went wrong.
			   - You can find this text in master..sysmessages, or rather a template for it, with placeholders for names of databases, tables etc.


-- These levels are documented in in the section :-
    Troubleshooting->Error Messages->Error Message Formats->Error Message Severity Levels in Books Online.



*/
--------------------
begin try 
 select 5/0;
 end try 
 begin catch 
    print 'Can Not Div by Zero'
	--raisError('Can Not Div by Zero',16,1);
	--throw 50000,'Can not Div By Zero ',1;
 end catch 
 
 Select message_id,severity,text from sys.messages   where language_id = 1033 ;

 exec sp_addmessage 50001,16,N'·« Ì„ﬂ‰ «·ﬁ”„Â ⁄·Ì «·’›—';
 begin try 
 select 5/0;
 end try 
 begin catch 
  raiserror(50001,16,1);
 end catch 
 -------------------------------------------------
 create table ProductsTb 
 (
    id int primary Key identity,
	Name nvarchar(50),
	unitPrice int,
	QtyProduct int 
 )
 go
 insert into ProductsTb values ('Mobile',2000,10),('Laptop',3000,20),('SmartTv',2500,25)
 go

 Create table Orders
 (
     id int primary Key identity,
	 ProductId int ,
	 QuantityOrder int 
 )
 go

 go 
 Create proc SpOrders
 @productID int ,
 @QtyOrder int 
 as 
 begin
    --check 
	declare @unitinStock int 
	select @unitinStock = QtyProduct 
	from ProductsTb 
	where id = @productID;
	 if(@unitinStock <@QtyOrder)
		 begin 
			raisError ('Not Enaugh in Stock ',16,1)
		 end 
	 else
		 begin 
		    begin tran 
			--Update 
			  update ProductsTb set QtyProduct = (QtyProduct-@QtyOrder)
			  where id =@productID;
			  --insert 
			  insert into Orders values (@productID,@QtyOrder);
		 end 
		 if(@@ERROR <> 0)
			 begin
				   rollback tran
				   print 'Fail in Insert ';
			 end 
		 else 
			 begin 
				   commit tran
				   print 'Done ... ';
			 end 
 end 
 go

 exec SpOrders 1,5
 select * from productsTb 
 select * from Orders


 exec SpOrders 3,45

 /*
Module 18
Implementing Transactions
-----------------------------
-- lessons :-
--------------
	   1- Transactions and the Database Engine.
	   2- Controlling Transactions.
--------------------------------------------------------------------------------------------
-- Lesson 1) Transactions and the Database Engine  :-
-------------------------------------------------------
       - A transaction is a group of tasks defining a unit of work.
	   - The entire unit must succeed or fail together ñ no partial completion is permitted.
       - Individual data modification statements are automatically treated as standalone transactions.
       - User transactions can be managed with T-SQL commands: BEGIN/ COMMIT/ROLLBACK TRANSACTION.
	   - SQL Server uses locking mechanisms and the transaction log to support transactions.
	   - Transaction commands identify blocks of code that must succeed or fail together,
	         and provide points where database engine can roll back, or undo, operations.
---------------------------------------------------------------------------------------------
-- Lesson 2) Controlling Transactions  :-
-------------------------------------------
    - BEGIN TRANSACTION :-
	----------------------
	        - BEGIN TRANSACTION marks the starting point of an explicit, user-defined transaction.
			- Transactions last until :-
			               A) COMMIT statement is issued.
			               B) ROLLBACK is manually issued. 
						   C) The connection is broken and the system issues a ROLLBACK.
			- In your T-SQL code: Mark the start of the transaction's work.
	- COMMIT TRANSACTION :-
	-----------------------
	        - COMMIT ensures all of the transaction's modifications are made a permanent part of the database.
			- COMMIT frees resources, such as locks, used by the transaction
			- In your T-SQL code: If a transaction is successful, commit it.
	- ROLLBACK TRANSACTION :-
	-------------------------
	        - A ROLLBACK statement undoes all modifications made in the transaction ,
			  by reverting the data to the state it was in at the beginning of the transaction .
			- ROLLBACK frees resources, such as locks, held by the transaction.
			- Before rolling back, you can test the state of the transaction with the XACT_STATE function.
			- In your T-SQL code: If an error occurs, ROLLBACK to the point of the BEGIN TRANSACTION statement.
	- Using XACT_ABORT :- 
	-----------------------
	        - SQL Server does not automatically roll back transactions when errors occur.
			- To roll back, either use ROLLBACK statements in error-handling logic or enable XACT_ABORT.
			- XACT_ABORT specifies whether SQL Server automatically rolls back the current transaction when a runtime error occurs.
			- SET XACT_ABORT OFF is the default setting.
			- Change XACT_ABORT value with the SET command :- " SET XACT_ABORT ON "
----------------------------------------------------------------------------------------------------------------------------------
-- Understanding of Transactions and Locks
-- ---------------------------------------
-- Review On Transactions:
-- ----------------------
-1- Transactions allow you to define a unit of activity that will be considered 
    atomic :all or nothing.
-2- Transactions are known as ACID (Atomicity, Consistency, Isolation, and Durability).
    * Atomicity ( One Failed All Failed )
    * Consistency ( Data must be in a good form )
    * Isolation (Transaction must be isolated from others ) 
    * Durability (Transaction must be permanent in DB )
-3- Note : Whenever you submit a change to the database, SQL Server first checks 
           whether the pages that need to be affected already reside in cache.
           If they do, the pages are modified in cache. 
           If they don't, they're first loaded from disk into the cache and modified
           there. 
     -SQL Server records the changes in the database's transaction log. 
     Once in a while, a process called checkpoint flushes changed pages 
     ("dirty pages") from cache to the data portion of the database on disk.
-- Every transaction is recorded on DB log to  later recovery (Demonstration)
   Committed   --Rollforward ,written to DB
   Uncommitted --Rollback
-- Locking is used to prevent users from reading data  
   that is in the process of being modified
-- Locking is automatic.
-- Without locking, the database may become logically  incorrect, 
   updates may be lost, and queries against the data may produce 
   unexpected results.
-- SQL server automatically manages locking on the database or its objects OR -
   You Can use locking hints, 
   you use special statements to configure the rules for setting and    
   releasing locks. However, using locking hints is not recommended. 
-- Two main types of lock:
		Read locks ñ Allow others to read but not write
		Write locks ñ Stop others from reading or writing
-- Locks prevent update conflicts
*/
-- Managing Transactions:
-- Types of transactions
-- ---------------------
-- Autocommit Transactions (Default)
-- ---------------------------------
-- Every statement is committed or rolled back 
   --when it has completed
--If it completes successfully : it is committed
--If it fails : it is rolled back
-------------------------------------------------------------------
CREATE TABLE NewTable (Id INT PRIMARY KEY, Info CHAR(3))   --fail
INSERT INTO NewTable VALUES (3, 'aaa')
INSERT INTO NewTable VALUES (1, 'bbb')
INSERT INTO NewTable VALUSE (3, 'ccc') -- Syntax Error
GO
SELECT * FROM NewTable -- Returns no rows.
GO
-------------------------------------------------------------------
--try
CREATE TABLE NewTable (Id INT PRIMARY KEY, Info CHAR(3))   --done
go
INSERT INTO NewTable VALUES (3, 'aaa')
INSERT INTO NewTable VALUES (1, 'bbb')
INSERT INTO NewTable VALUSE (3, 'ccc') -- Syntax Error
GO
SELECT * FROM NewTable -- Returns no rows.
GO
------------------------------------------------------------------- 
/*
- Committing inner transactions is ignored by the SQL Server Database Engine
- If the outer transaction is committed,the inner nested  transactions are also committed.
- If the outer transaction  is rolled back, then all inner transactions are also 
  rolled back
*/
-------------------------vip ex for Transaction ------------------------------
go
create database TranstestDB
go 
use TranstestDB
go 
create table names (ID int identity (1,1), name nvarchar(50),
                    city nvarchar(20),job nvarchar(20));
go 
create table Salary (SalaryID int identity(1,1),nameID int ,
                      Salary decimal (18,2), Bouns decimal (18,2),
					   dis decimal (18,2),net decimal (18,2))
------------------------------------------------
-- procerdue to insert into two Tables 
go
create proc SP_insert_With_Identity
--- table name
@name nvarchar (50),
@City nvarchar (20),
@job nvarchar (20),
---table salary 
@salary decimal (18,2)
as 
declare @nameID int
declare @bouns decimal (18,2) = @salary * 0.10
declare @dis decimal (18,2)   = @salary * 0.05
declare @net decimal (18,2)   = @salary +@bouns - @dis

insert into names values (@name , @city , @job)
set @nameId = (select SCOPE_IDENTITY())
insert into salary values (@nameID,@salary,@bouns,@dis,@net)

go 
exec SP_insert_With_Identity 'yasser','Cairo','Deve',2000

select * from names
select * from salary 
-----------------------------------------------------------
--With Transaction 
-- Do All Or Not All 
--error
------------------------------------------------------------
go
create proc SP_Make_Erro
--- table name
@name nvarchar (50),
@City nvarchar (20),
@job nvarchar (20),
@salary decimal (18,2)
as 
insert into names values (@name , @city , @job)
---table salary 
declare @nameID int
declare @bouns decimal (18,2) = @salary * 'yah'
declare @dis decimal (18,2)   = @salary * 0.05
declare @net decimal (18,2)   = @salary +@bouns - @dis
set @nameId = (select SCOPE_IDENTITY())
insert into salary values (@nameID,@salary,@bouns,@dis,@net)
go 

exec SP_Make_Erro 'yasser','Cairo','Deve',2000
select * from names
select * from salary 
-----------------------------------------------
-- To Soliving this problem 
go
create proc SP_Make_Tranc
--- table name
@name nvarchar (50),
@City nvarchar (20),
@job nvarchar (20),
@salary decimal (18,2)
as 
begin try 
	begin transaction --|tarnsaction
		insert into names values (@name , @city , @job)
		---table salary 
		declare @nameID int
		declare @bouns decimal (18,2) = @salary * 'yah'
		declare @dis decimal (18,2)   = @salary * 0.05
		declare @net decimal (18,2)   = @salary +@bouns - @dis
		set @nameId = (select SCOPE_IDENTITY())
		insert into salary values (@nameID,@salary,@bouns,@dis,@net)
	commit transaction
end try
begin catch 
	rollback transaction 
	print error_message()
end catch 
go 
exec SP_Make_Tranc 'Mohamed','Cairo','Deve',2000
select * from names
select * from salary 
-------------------------------------------------------------------------------------------------

-- Managing Transactions:
-- Types of transactions
-- ---------------------
/*
XACT_ABORT setting ON ensures the entire batch will rollback upon any runtime error; 
compile errors not affected by XACT_ABORT 
SET XACT_ABORT on 

*/

-- Implicit Transaction : (Auto:Begin ,Explicit:Rollback or Committ)
-- ------------------------------------------------------------------
--SET IMPLICIT_TRANSACTIONS {ON | OFF }
/*
-- When ON, SET IMPLICIT_TRANSACTIONS sets the connection into implicit transaction mode. 
-- When OFF, it returns the connection to autocommit transaction mode
-- Server Database Engine automatically starts a new transaction after the 
   current transaction is committed or rolled back. 
-- You do nothing to delineate the start of a transaction; 
   you only commit or rollback each transaction ,OR
   the transaction and all of the data changes it 
   contains are rolled back when the user disconnects
*/

Use Northwind
update Employees
set firstname ='ahmed'
where lastname ='Davolio'

select * from Employees

Rollback tran Tran1


-- Count transaction( Nested Transactions)
select @@TRANCOUNT       --determine Nesting level
/*
- Committing inner transactions is ignored by the SQL Server Database Engine
- If the outer transaction is committed,the inner nested  transactions are also committed.
- If the outer transaction  is rolled back, then all inner transactions are also 
  rolled back
*/
-- Special Option
-- --------------
--XACT_ABORT ==> Determine whether sql automatic  rollback the current transaction  when an error occur  (on --off)
--When SET XACT_ABORT is ON, if a Transact-SQL statement raises a run-time error, the entire transaction is terminated and rolled back
--When SET XACT_ABORT is OFF, in some cases only the Transact-SQL statement that raised the error is rolled back and the transaction continues processing. Depending upon the severity of the error

--Compile errors, such as syntax errors, are not affected by SET XACT_ABORT.

USE AdventureWorks2012 
CREATE TABLE t1 (a INT NOT NULL PRIMARY KEY);
CREATE TABLE t2 (a INT NOT NULL REFERENCES t1(a));
GO
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (3);
INSERT INTO t1 VALUES (4);
INSERT INTO t1 VALUES (6);
GO
SET XACT_ABORT OFF;
GO

BEGIN TRANSACTION;
INSERT INTO t2 VALUES (1);
INSERT INTO t2 VALUES (2); -- Foreign key error.
INSERT INTO t2 VALUES (3);
COMMIT TRANSACTION;
GO

Select * from t1
select * from t2


SET XACT_ABORT ON;
GO
BEGIN TRANSACTION;
INSERT INTO t2 VALUES (4);
INSERT INTO t2 VALUES (5); -- Foreign key error.
INSERT INTO t2 VALUES (6);
COMMIT TRANSACTION;
GO
-- SELECT shows only keys 1 and 3 added. 
-- Key 2 insert failed and was rolled back, but
-- XACT_ABORT was OFF and rest of transaction
-- succeeded.
-- Key 5 insert error with XACT_ABORT ON caused
-- all of the second transaction to roll back.
SELECT *
    FROM t2;
GO
--===============================================================================================
-------------------------------------------------------------------------------------------------
/*
                 --Thank you Every One    ... :)   Keep Coding    Sayed Hawas
*/
-------------------------------------------------------------------------------------------------
--************************************************************************************************
-- Displaying Query Statistics
/*
In addition to execution plan internals, SQL Server can return details about the execution of T-SQL
statements by the use of the SET STATISTICS group
of commands:

? SET STATISTICS TIME ON|OFF controls the display of metrics about the time taken to
prepare and compile (pre-execution phases), as well as the totals elapsed when the query has
completed.
? SET STATISTICS IO ON|OFF controls the display
of information about the amount of disk (and data cache) activity generated by a query.
Results are displayed in units of 8kb data pages, which store table rows.

*/
-- STATISTICS TIME
SET STATISTICS TIME ON;
GO
SELECT orderid, customerID, employeeID, orderdate FROM Orders;
GO
SET STATISTICS TIME OFF;
GO

-- STATISTICS IO
SET STATISTICS IO ON;
GO
SELECT orderid, customerID, employeeID, orderdate FROM Orders;
GO
SET STATISTICS IO OFF;
GO
--=========================================================================================================================
/*
When writing queries, it is sometimes necessary 
to learn which columns are in a particular table, what their data types are, or what collation is used by a 
string column. You may not have convenient access to a graphical tool such as SQL Server Management 
Studio (SSMS); however, if you can send queries to SQL Server, you can retrieve the same information that 
SSMS displays. After all, SSMS is simply issuing metadata queries on your behalf in order to display its view 
of a server or a database. 

SQL Server provides access to structured metadata through a variety of mechanisms, such as :
1- system catalog views, 
2- system functions, 
3- dynamic management objects, 
4- system stored procedures.

*/

-- System Catalog Views (code & wizard)
-- ------------------------------------

--Pre-filtered to exclude system objects
use Northwind    -- try to change DB
SELECT  name, object_id, schema_id, type, type_desc
FROM sys.tables

USE northwind;
GO
SELECT name, object_id, principal_id, schema_id,parent_object_id, type, type_desc
FROM sys.tables;


--Includes system and user objects
SELECT name, object_id, schema_id, type, type_desc
FROM sys.objects

/*
-- some examples of system views:
[sys].[all_columns]
[sys].[all_sql_modules]
[sys].[all_views]
[sys].[check_constraints]
[sys].[column_type_usages]
[sys].[columns]
[sys].[computed_columns]
[sys].[data_spaces]
[sys].[database_files]
[sys].[databases]
[sys].[foreign_keys]
[sys].[synonyms]
[sys].[types]

Select name,column_id,is_identity,increment_value,last_value
From sys.identity_columns

*/


SELECT SCHEMA_NAME(schema_id) AS SchemaName,name AS TableName
FROM sys.tables
ORDER BY SchemaName, TableName;
GO


-- Information Schema Views
-- ------------------------
/*
-They are stored in their own schema, INFORMATION_SCHEMA. 
 SQL Server system views appear in the sys schema. 
-They typically use standard terminology instead of SQL Server terms. 
 For example, they use ìcatalogî instead of ìdatabaseî and ìdomainî instead of ìuser-defined data type.î So,
 you need to adjust your queries accordingly. 
-They may not expose all the metadata available to SQL Server's own catalog views. 
 For example, sys.columns includes attributes for the identity property and computed column property, while 
 INFORMATION_SCHEMA.columns does not. 
  
-Return system metadata per ISO standard, used by third-party tools
-information schema views may be queried to return system metadata. 
 Provided to conform with standards, information schema views are useful to third-party tools that may not be 
written specifically for use with SQL Server.
*/

SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE 
FROM INFORMATION_SCHEMA.TABLES



-- System Metadata Functions
-- -------------------------
/*
-Return information about settings, values, and objects in SQL Server
-Come in a variety of formats:
--Some marked with a @@ prefix, sometimes incorrectly referred to as global variables: @@VERSION
--Some marked with a () suffix, similar to arithmetic or string functions: ERROR_NUMBER()
--Some special functions marked with a $ prefix: $PARTITION

-Marked with an sp_ prefix
-Stored in a hidden resource database 
Best practices for execution include: 
  -Always use EXEC or EXECUTE rather than just calling by name
  -Include the sys schema name when executing
  -Name each parameter and specify its appropriate data type

*/

SELECT @@VERSION AS SQL_Version
SELECT SERVERPROPERTY('ProductVersion') AS version
SELECT SERVERPROPERTY('Collation') AS collation

select user_name(2)
select SUSER_SNAME()
select COL_LENGTH('employees','lastname') as length


select getdate()
select DB_name ( ) 'db'
select db_id('master')
select suser_sname() as 'UserName'

SELECT SERVERPROPERTY('ResourceVersion')
select HOST_NAME()    --gives server name


select * from ::fn_helpcollations()

SELECT  SERVERPROPERTY('productversion'), 
SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')


                                         


-- Executing Stored Procedures
-- ---------------------------
/*
-Use the EXECUTE or EXEC command before the name of the stored procedure
-Pass parameters by name or position, separated by commas when applicable
*/

--no parameters
EXEC sys.sp_databases;

--single parameter
EXEC sys.sp_help 'Sales.Customers'

--multiple named parameters
EXEC sys.sp_tables 
	@table_name = '%', 	  -- c%
	@table_owner = 'Sales'


EXEC sys.sp_databases

-- sp_help objectName
Exec sp_help employees
     sp_help Invoices

exec sp_columns MyTable
exec sp_columns employees, @column_name = 'employeeid'
exec sp_columns MyTable, @column_name = 'a%'

-- sp_helpdb dbName
sp_helpdb Northwind
sp_dbcmptlevel



-- DMV (Dynamic Managment Views)  
-- ------------------------------

/*
-Dynamic management views and functions (DMVs) return server state information
-Nearly 200 DMVs in SQL Server 2012
-DMVs include catalog information as well as administrative status information, such as object dependencies
-DMVs are server-scoped (instance-level) or database-scoped
-Schema name required to invoke
-Requires VIEW SERVER STATE or VIEW DATABASE STATE permission to query DMVs
-Underlying structures change over time, so avoid writing SELECT * queries against DMVs
 
*/

Select * From sys.sysdatabases

SELECT SCHEMA_NAME(schema_id) AS SchemaName,name AS TableName
FROM sys.tables
ORDER BY SchemaName, TableName;
GO

SELECT name, type_desc FROM sys.tables

SELECT name,id,xtype,crdate FROM sys.sysobjects
--where xtype= 'u'     -- u:user table

SELECT session_id, login_time,
program_name
FROM sys.dm_exec_sessions
WHERE is_user_process =1;
--===================================================================================================================













