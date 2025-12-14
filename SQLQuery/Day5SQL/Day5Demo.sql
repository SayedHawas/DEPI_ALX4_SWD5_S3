--Day 5
Create Table Employees (id int , [FirstName] nvarchar(50)) 
USE Northwind
GO
Select * from [Order Details] 
GO
--------------------
/*
Module 7
Using DML to Modify Data
---------------------------------------------------------------------
						-Adding Data to Tables
						-Modifying and Removing Data
						-Generating Automatic Column Value
---------------------------------------------------------------------
*) Adding Data to Tables
-----------------------------
		Using INSERT to Add Data
		Using INSERT with Data Providers
		Using SELECT INTO
		using Output
*/
--Using INSERT to Add Data
Create database TestDB
go 
use TestDB
go
Create table Students(ID int Primary Key Identity,
                      Name nvarchar(50) Not Null,
					  Course nvarchar(30),
					  [Level] int)
go


Select * from Students

Insert into Students(Name,Course,level)values ('Retaj','SQL Query',1);
 
Insert into Students values ('Mariam','SQL Query',1);

Insert into Students values ('Osama'); --Error

Insert into Students (Name) values ('Osama')

Insert into Students (Level) values (1)


Insert into Students(Name , Level) values ('Osama',1); 
select * from students 
--Add multi Rows 
Insert into Students values ('Tammer','SQL Query',1),
                            ('Ahmed','SQL Query',1),
							('Ramy','SQL Query',1)

-- test 
Select * from Students
select @@ROWCOUNT
-- Insert Partial Data
-- -------------------

select * from Students 
---------------------------------------------------------------------------------------------
--INSERT ... SELECT to insert rows from another table:
use Northwind
 Select * from Employees
go
Create table EmployeesShortTable (ID int primary key identity,
                                  Fname nvarchar(50) ,
								  Lastname nvarchar(50) ,
								  Country nvarchar(50))
go
insert into EmployeesShortTable 
select firstname ,lastname ,Country from Employees where EmployeeID >3

Select * from EmployeesShortTable
select * from Employees
select * from EmployeesShortTable

--------------------------------------------------
--TVF table Value Function
------------
Select getdate()
GO
Create function TVF_Fun()
returns table 
as 
return Select * from Employees Where EmployeeID >5

GO

Select * from dbo.TVF_Fun()




truncate table EmployeesShortTable

select * from EmployeesShortTable
go
Create function Fn_selectEmployees()
returns table
as
return select firstname ,lastname ,Country from Employees
go
insert into EmployeesShortTable select * from Fn_selectEmployees() 

select * from EmployeesShortTable
--------------------------------------------------
--INSERT ... EXEC
------------------ 
truncate table EmployeesShortTable
select * from EmployeesShortTable


--SP Insert , Update , delete , select  
go
Create proc SP_ToSelectData
AS
BEGIN 
   select firstname ,lastname ,Country from Employees
END
go

Execute SP_ToSelectData
Truncate table EmployeesShortTable

insert into EmployeesShortTable exec SP_ToSelectData

select * from EmployeesShortTable

-----------------------------------------------------------------
Select * from Employees

Select EmployeeID , FirstName , LastName , Country into EmplyeeTest from Employees 

--Using SELECT INTO
/*
*)The new table is based on query column structure
     - Uses column names, data types, and null settings
     - Does not copy constraints or indexes
*/
select * from Employees Where EmployeeID >5

select EmployeeID ,FirstName ,LastName ,BirthDate into emps
from Employees Where EmployeeID >5
-------------------------------------------------------------------
--Use the OUTPUT keyword with INSERT Or Delete with Select 

--1
SELECT * INTO NewOrderDetails 
FROM [Order Details] WHERE ProductID = 70		
--2
select * from NewOrderDetails

truncate table NewOrderDetails


--Insert into Table1 Values (...) 
--Insert into Table1 Select * from table
--Insert into Table1 Select * From TVF
--Insert into Table1  Exec SP
---------------------
--Select Into  Table from table  (Create ....)
-----------------------------------------------
--Insert Into output Select * from table    (Row Number)

--Just one 
--Insert
INSERT into NewOrderDetails 
OUTPUT INSERTED.*
SELECT * FROM [Order Details] where ProductID =50

select * from NewOrderDetails

DELETE FROM NewOrderDetails 		
WHERE UnitPrice >15 

-- Delete 
DELETE FROM NewOrderDetails 		
OUTPUT DELETED.*
WHERE UnitPrice >15 

select * from NewOrderDetails
--------------------------------------------------------------------------------------------------------
-- Truncate Table
-- --------------
--TRUNCATE TABLE is functionally the same to the DELETE statement without a WHERE clause
--TRUNCATE TABLE Statement Deletes All Rows in a Table
--TRUNCATE TABLE has the following advantages:-
------------------------------------------------
/*
1-Faster than delete Statement

2-Removes all rows from a table without logging the individual row deletions,
  (nonlogged method of deleting all rows in a table)

3-can not put a where clause 

4-The DELETE statement removes rows one at a time and records an entry in the transaction log
  for each deleted row.TRUNCATE TABLE removes the data by deallocating the data pages used to 
  store the table

5-after a DELETE statement is executed, the table can still contain empty pages
  with TRUNCATE zero pages are left in the table

6-TRUNCATE TABLE removes all rows from a table, 
  but the table structure and its columns, constraints, indexes, and so on remain(Use Drop table)

7- You cannot use TRUNCATE TABLE on tables that are referenced by a FOREIGN KEY constraint
*/
Truncate Table table2
--================================================================================================================================
--=================================================
--Lesson 2: Modifying and Removing Data
--=================================================		
					--Using UPDATE to Modify Data
					--Using MERGE to Modify Data
/*
--Using UPDATE to Modify Data
------------------------------
UPDATE changes all rows in a table or view
Unless rows are filtered with a WHERE clause or constrained with a JOIN clause
Column values are changed with the SET clause 
*/

--One Row 
UPDATE Products
   SET   unitprice = (unitprice * 1.04)
WHERE   Productid =  1

--More than One Row 
UPDATE Products
   SET   unitprice = (unitprice * 1.04)
WHERE   categoryid =  1 AND discontinued = 0

--Using 
-- assignment operators *=
UPDATE Products
   SET     unitprice *= 1.04 
			 -- Using compound
			 -- assignment operators 
WHERE   categoryid =  1 AND discontinued = 0;



Select * from Products

Update  Products set ProductName = 'Toto'  Where ProductID = 1

Update Products set UnitPrice *= .1 where ProductID = 1
------------------------------------------------

--join
select count(OrderID),e.employeeId
FROM   Orders AS o INNER JOIN Employees AS e
ON 	e.employeeID = O.employeeID 
group by e.employeeId
having count(orderId)> 100;
--------------------------------------------------------------------------------------------------
--Updating Data in One Table Based on a Join to Another
 --Join 
select p.ProductName ,od.Quantity
FROM Products AS P INNER JOIN  [Order Details] AS od
ON 	p .ProductID =  od.ProductID AND od.Quantity > 100;

UPDATE Products  -- Notice use of Alias to make reading better 
	   SET ProductName += ' ?' 
FROM Products AS P INNER JOIN  [Order Details] AS od
ON 	p .ProductID =  od.ProductID AND od.Quantity > 100;
-------------------------------------------------------------------------------------------------- 
--Using Join & SubQuery 
UPDATE employees   -- Notice use of Alias to make reading better 
	SET FirstName += 'p' 
FROM   Orders AS o INNER JOIN Employees AS e
ON 	e.employeeID = O.employeeID 
where e.employeeID in (select employeeID from orders group by employeeId having count(orderid )>150)

select * from employees
----------------------------------------------------------------------------------------
--Using MERGE to Modify Data
--==============================
/*
MERGE modifies data based on a condition
When the source matches the target
When the source has no match in the target
When the target has no match in the source


MERGE TOP (10) 
INTO	Store 		AS Destination
USING	StoreBackup 	AS StagingTable
	ON(Destination.Key = StagingTable.Key)

WHEN NOT MATCHED THEN
	INSERT (C1,..)
	VALUES (Source.C1,..)
WHEN MATCHED THEN 
	UPDATE SET Destination.C1 = StagingTable.C1,..;
*/

Create table MonthTrans
(
 id int , Name nvarchar(50),total decimal(9,2), Gtotal decimal(9,2)
)
go
Create table DayTrans
(
 id int , Name nvarchar(50),total decimal(9,2)
)

insert into MonthTrans values (1,'retaj',2000 ,5000),
(2,'Osama',1000 ,4000),(3,'Mariam',200 ,1000)
select *from MonthTrans 


insert into DayTrans values (1,'retaj',250),
(2,'Osama',100),(4,'sayed',100),(5,'ahemd',500)

select * from monthtrans
select * from Daytrans

merge into monthtrans as MT
Using daytrans as DT
ON MT.ID = DT.ID
when matched then 
	update set Mt.total +=dt.total
when not matched by target then 
	insert (id,Name,total)values (dt.ID,dt.Name,dt.total);

GO

merge into monthtrans as Mt --Target
using daytrans as Dt --Source

on Mt.Id=Dt.ID

when matched then 
	update set Mt.total = Mt.total + dt.total 
when  not Matched by target then 
	insert (id,Name,total)values (dt.ID,dt.Name,dt.total);

delete from daytrans
----------------------------------------------------------------------------------------
--==================================================
--Lesson 3: Generating Automatic Column Values
--==================================================
--1)Using IDENTITY
-------------------
/*
--The IDENTITY property generates column values automatically
*)Optional seed and increment values can be provided
*)Only one column in a table may have IDENTITY defined 
*)IDENTITY column must be omitted in a normal INSERT statement
*)Functions are provided to return last generated values
    SELECT @@IDENTITY: default scope is session
    SELECT SCOPE_IDENTITY(): scope is object containing the call in function and procedure 
    SELECT IDENT_CURRENT(' tablename'): in this case, scope is defined by tablename
There is a setting to allow identity columns to be changed manually ON or automatic OFF
SET IDENTITY_INSERT <Tablename> [ON|OFF]
*/
CREATE TABLE Books(PID int IDENTITY(1,1) NOT NULL, Name VARCHAR(15))
go
INSERT INTO Books (Name) VALUES ('MOC 2072 Manual')  
select * from Books

set identity_insert books on;
INSERT INTO Books(PID,Name)  VALUES (100,'MOC SQL ')
set identity_insert books off;

select * from books

INSERT INTO Books(Name)  VALUES ('MOC SQL Query ')
select * from Books
SELECT IDENT_CURRENT('Books');
select ident_seed('Books');
select IDENT_INCR('Books');
-----------------------------------------------------------

SELECT IDENT_CURRENT('Employees');
select ident_seed('Employees');
select IDENT_INCR('Employees');

SELECT @@IDENTITY
SELECT SCOPE_IDENTITY()
SELECT IDENT_CURRENT(' Employees')

select max (employeeID) , min(employeeID) from Employees
----------------------------------------------------------------------------------------
--2)Using Sequences
--------------------
/*
Sequence objects were first added in SQL Server 2012
Independent objects in database

More flexible than the IDENTITY property
Can be used as default value for a column
Manage with CREATE/ALTER/DROP statements
Retrieve value with the NEXT VALUE FOR clause
*/
-- Define a sequence
CREATE SEQUENCE dbo.InvoiceSeq AS INT START WITH 1 INCREMENT BY 1;
-- Retrieve next available value from sequence
SELECT NEXT VALUE FOR dbo.InvoiceSeq;
------------------------------------------------------------------
 Drop sequence dbo.InvoiceSeq 

 --Best
if object_Id('dbo.InvoiceSeq') is Not Null
begin
 Drop sequence dbo.InvoiceSeq 
end
   
go
CREATE SEQUENCE dbo.InvoiceSeq AS INT START WITH 1 INCREMENT BY 1;
go
Create table subjects (ID int primary key , SuubjectName nvarchar(50))
go 
insert into subjects values (NEXT VALUE FOR dbo.InvoiceSeq,'SQl Query ') 
select * from subjects 


insert into subjects values (100,'SQl Query ')
insert into subjects values (NEXT VALUE FOR dbo.InvoiceSeq,'SQl Query ')
select * from subjects 
---------------------------------------------------------------------------------------
--Advanced 
/* GUIDS
---------
- Data Integrity Rule Number 1 is All rows must be unique.
- Real Life Have Multiple rows are identical and correct.
- GUID Randomly generated values.
- Use GUID to switch Identical data to uniquely values.
- Use GUID by :- 1) Column Datatype Uniqueidentifier.
                 2) Functions NEWID(), NEWSEQUENTIALID().
-----------------------------------------------------------
* NEWID(), NEWSEQUENTIALID()
-------------------------------
- Generate a values based on :- CPU clock, NetworkCard
- NEWID() un order random GUID.
- NEWSEQUENTIALID() generate sequentialy values.
- NEWID() make issues for Indexing.
- NEWSEQUENTIALID() good for Indexing bad for security.
------------------------------------------------------------- */
-- Select NEW() 
SELECT NEWID()

-- CREATE NEWID() COLUMN
CREATE TABLE NEWID_TABLE
(
       ID UNIQUEIDENTIFIER DEFAULT NEWID() ,
	   NAME NVARCHAR(100) ,
	   TITLE  NVARCHAR(100)
)
GO
-- PUT DATA 
INSERT INTO NEWID_TABLE(NAME,TITLE)
VALUES ( 'Osama', 'Maneger'),
       ( 'Sayed', 'Employee'),
	   ( 'Retaj','Developer')
GO
-- SEE RESULT
SELECT * FROM NEWID_TABLE
GO
--Clean
DROP TABLE NEWID_TABLE
GO
----------------------------------------------------

-- Create Column With SequentialID()
CREATE TABLE SEQUENTIALEDID_TABLE
(
       ID UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),
	   NAME NVARCHAR(100) ,
	   TITLE  NVARCHAR(100)
)
GO
-- PUT DATA 
INSERT INTO SEQUENTIALEDID_TABLE(NAME,TITLE)
VALUES ( 'Osama', 'Maneger'),
       ( 'Sayed', 'Employee'),
	   ( 'Retaj','Developer')
GO
-- SEE RESULT
SELECT * FROM SEQUENTIALEDID_TABLE
GO
--Clean
DROP TABLE SEQUENTIALEDID_TABLE
----------------------------------
-- NEWID Tricks
---------------
-- 1) Generate A random decimal number
SELECT RAND( CHECKSUM( NEWID()));
GO
--OR 
SELECT RAND() 
GO

-- 2) Random Float Number between 
SELECT 20*RAND()                     -- Float From 0-20
SELECT 10 + (30-10)*RAND()           -- Float FROM 10-30
SELECT round(10 + (30-10)*RAND(),0)  -- int FROM 10-30

-- 3) Generate A random number
SELECT ABS(CHECKSUM(NEWID()))
GO

-- 4) Generate Random Numbers between Rang
SELECT CONVERT(INT, (100+1)*RAND()) -- FROM 0-100
GO

--OR 
DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT
---- This will create a random number between 1 and 999
SET @Lower = 1 ---- The lowest random number
SET @Upper = 999 ---- The highest random number
SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
SELECT @Random


-- 5) Retrieving Random Rows from Table 
select * from employees order by (NewID())
select top(3)* from employees order by (NewID())


--ID int  big int 
--identity Securty Id String GUID 
--URL  / 0265425A-7BD7-F011-8B6A-F875A4154FAB
--90% ID INT 
--10% GUID 


/*
-- Module 9) Grouping and Aggregating Data :-
---------------------------------------------
   -- Lessons :-
      ----------         1)- Aggregation Functions. 
	                     2)- Group By Clause.
						 3)- Having Clause.
----------------------------------------------------------------------------------------------------------------------
-- Lesson 1) Aggregation Functions :-
--------------------------------------
		       - Take one or more input To return a single summarizing value.
			   - Examples :- AVG(), MAX(), MIN(), SUM(), COUNT().
		       - Can be used in ( SELECT, HAVING, and ORDER BY ) clauses .
			   - Frequently  used with GROUP BY clause. 
*/
-- AVG :- Averages all non-NULL numeric values in a column.
-- AVG(<Expression>)


Select count(*) from Employees

Select Max(UnitPrice) from Products 

Select Min(UnitPrice) from Products 

Select SUM(UnitPrice) from Products 

Select AVG(UnitPrice) from Products

SELECT AVG(Quantity) AS Quantity_Average
FROM   [Order Details]
GO

-- SUM :- Totals all the non-NULL numeric values in a column.
-- SUM(<Expression>)
SELECT SUM(Quantity) AS Quantity_Total_Sum
FROM   [Order Details]
GO	   

-- COUNT(<Expression>) 
-- COUNT(*)  "Include NULLS"
SELECT COUNT(*) AS Count_All_Rows_With_NULL,
       COUNT(region) AS Count_Region_No_NULL
FROM   Customers
GO

-- MIN :-Returns the smallest number.
-- MIN(<Expression>)
SELECT MIN(Quantity) AS Quantity_Minimum
FROM   [Order Details]
GO

-- MAX :- Returns the largest number.
-- MAX(<Expression>)
SELECT MAX(Quantity) AS Quantity_Maximum
FROM   [Order Details]
GO	   

-- Note :-
-- MAX() & MIN() Works with Date & String
SELECT MIN(CustomerID) AS First_Customer_A_Z,
       MAX(CustomerID) AS Last_Customer_Z_A,
	   MIN(YEAR(OrderDate)) AS earliest_Date,
	   MAX(YEAR(OrderDate)) AS Latest_Date
FROM   Orders
GO
/*			   
			   - Use DISTINCT with aggregate functions to summarize only unique values.
			   - DISTINCT aggregates eliminate duplicate values, not rows (unlike SELECT DISTINCT).
*/

SELECT COUNT(ProductID) AS ProductID_Rows,
       COUNT(DISTINCT ProductID) AS Unique_ProductID_Rows
FROM   [Order Details]

/*
			   - Ignore NULLs except in COUNT(*).
			   - NULL may produce incorrect results
			   - Use ISNULL or COALESCE to replace NULLs before aggregating.
*/
-- Create table for example
CREATE TABLE Temp1
(
  ID INT, Score INT
)
-- Insert Data
INSERT Temp1
VALUES (1,20),(2,40),(3,60),(4,NULL)
GO
-- Show table
SELECT *
FROM Temp1

-- See Null not count
SELECT Min(Score) AS Score_Min
FROM   Temp1

-- Using isnull or coalesce To make it count
SELECT Min(ISNULL(Score,0)) AS Score_Min
FROM   Temp1
GO


Select * from Employees

Select Count(*) ,Country ,city
From Employees 
Group by Country ,city
----------------------------------------------------------------------------------------------------------------------
/*
-- Lesson 2) Group By Clause :-
--------------------------------------
       - GROUP BY creates groups for output rows, according to unique combination of values specified in the GROUP BY clause.
	   - GROUP BY calculates a summary value for aggregate functions in subsequent phases.
	   - All columns in SELECT, HAVING, and ORDER BY must appear in GROUP BY clause or be inputs to aggregate expressions.
	   - Aggregate functions are commonly used in SELECT clause, summarize per group.
	   - Aggregate functions may refer to any columns, not just those in GROUP BY clause.
*/
-- GROUP BY Example 1)
-- Show every Employee with how many rows he have.
Select count(*) AS Counter ,o.EmployeeID ,e.FirstName  --6
from Orders  AS O Join Employees As E                  --1
ON E.EmployeeID = O.EmployeeID                         --2
where o.EmployeeID >5 --Data                           --3
Group by o.EmployeeID ,e.FirstName                     --4
Having Count(*) >70             --aggregate            --5
Order By  Counter desc                                 --7



SELECT EmployeeID, COUNT(*) AS Rows_For_Employee
FROM   Orders
GROUP BY EmployeeID
GO

-- GROUP BY Example 2)
-- Error Will Show Because :-
-- All columns in SELECT, HAVING, and ORDER BY must appear in GROUP BY clause or be inputs to aggregate expressions.
SELECT EmployeeID,YEAR(OrderDate) AS OrderYear, COUNT(*) AS Rows_For_Employee
FROM   Orders
GROUP BY EmployeeID
GO

-- To make it work add date to group by
SELECT EmployeeID,YEAR(OrderDate) AS OrderYear, COUNT(*) AS Rows_For_Employee
FROM   Orders
GROUP BY EmployeeID , YEAR(OrderDate)
GO

-- Group By Example 3)
SELECT ProductID, MAX(Quantity) AS largest_order 
FROM   [Order Details]
GROUP BY productid
ORDER BY largest_order DESC
GO
----------------------------------------------------------------------------------------------------------------------
/*
-- Lesson 3) Having Clause :-
-------------------------------------
      - HAVING clause provides a search condition that each group must satisfy.
	  - HAVING clause is processed after GROUP BY.
	  - WHERE  :- filters rows before groups created
      - HAVING :- filters groups Controls which groups are passed to next logical phase.
*/
-- Having Example 1)
-- Customers make more than 10 orders
SELECT CustomerID,COUNT(*) AS Count_Orders 
FROM   Orders 
GROUP BY CustomerID
HAVING COUNT(*) > 10
GO

-- Having Example 2)
-- Employees done more than 50 order 
-- and employeeID > 4
SELECT EmployeeID, COUNT(*) AS OrderCount
FROM   Orders
WHERE  EmployeeID > 4
GROUP BY EmployeeID
HAVING COUNT(*) > 50
GO
-------------------------------------------------------------------------------------------
--Lab (HOL)
------------
select COUNT(*)
from Employees
----------------------------------------------------------------
select COUNT(FirstName)
from Employees
----------------------------------------------------------------
--Testing Nulls
select count( Country)
from Employees
----------------------------------------------------------------
select count(ISNULL( Country,' '))
from Employees
----------------------------------------------------------------
select SUM(quantity) as [Product Qty],ProductID
from [Order Details]
where ProductID!=23
group by ProductID
order by ProductID
----------------------------------------------------------------
select SUM(quantity) as total ,max(quantity) as MAX ,min(quantity) as MIN ,avg(quantity) as AVG ,ProductID
from [Order Details]
where ProductID!=23
group by ProductID
order by ProductID
----------------------------------------------------------------
select SUM(quantity) as total ,ProductID
from [Order Details]
where ProductID!=23
group by ProductID
having SUM(quantity)>1000
order by ProductID
-----------------------------------------------------------------
--test this 
select quantity 
from [Order Details]
having Quantity >100 
-------------------------------------------------------------
select SUM(quantity)
from [Order Details]
having SUM(quantity)>1000

select SUM(quantity) ,ProductID
from [Order Details]
where ProductID in (1,2,5)
Group by ProductID
having SUM(quantity)>1000


--Select *
--From Employees
--Group by employeeId , LastName ,


--================================================================================================
 --************************************************************************************************
 --                                 Using Aggregate Functions
 --************************************************************************************************
-------------------------------------------------------------------------------------------------------------
-- The CUBE and ROLLUP operators are useful in generating reports that contain subtotals and totals. 
-- There are extensions of the GROUP BY clause.
-------------------------------------------------------------------------------------------------------------
--– CUBE generates a result set that shows aggregates for all combinations of values in the selected columns.
--– ROLLUP generates a result set that shows aggregates for a hierarchy of values in the selected columns.
-------------------------------------------------------------------------------------------------------------
--Rollup
select SUM(quantity),ProductID,OrderID
from [Order Details]
group by ProductID,OrderID

select SUM(quantity),ProductID,OrderID
from [Order Details]
Where ProductID = 1
group by rollup( ProductID,OrderID)



-- test this 
select SUM(quantity),ProductID,OrderID
from [Order Details]
group by rollup( ProductID,OrderID)
having OrderID is null 
-------------------------------------------------------------
--Cube
select SUM(quantity),ProductID,OrderID
from [Order Details]
group by cube( ProductID,OrderID)
 

select SUM(quantity),ProductID,OrderID
from [Order Details]
group by cube( ProductID,OrderID)
having ProductID is null 
-------------------------------------------------------------
--Window Functions


Select *,count(*) Over()
from Employees



select Categoryid ,productname,unitprice
from Products

select Max (unitprice) from products
---????
Select * , Max (unitprice) Over(Order by CategoryId) from Products
select *, Max (unitprice) from products  ---??
--select *,Max (unitprice) from products order by * --Error

select * ,rank()over(order by unitprice desc) from products 
------------------------------------------------------------------------------------------------------
select categoryid,productname,unitprice,
RANK()over(partition by categoryid order by unitprice)
from Products
------------------------------------------------------------------------------------------------------
select categoryid,productname,unitprice,dense_RANK()
over(partition by categoryid order by unitprice)
from Products
-------------------------------------------------------------------------------------------------------
select categoryid,productname,unitprice,row_number()
over(partition by categoryid order by unitprice)
from Products
-------------------------------------------------------------------------------------------------------
select categoryid,productname,unitprice,ntile(4)
over(partition by categoryid order by unitprice)
from Products
-------------------------------------------------------------------------------------------------------
---- Join with Grouping 
------------------------------------------------------------------------------------
select mgr.FirstName as manager , emp.FirstName as employee
from Employees as emp left outer join Employees as mgr
on emp.ReportsTo=mgr.EmployeeID
-------------------------------------------------------------------------------------
select mgr.FirstName as manager,COUNT(emp.firstname) [number of employees]
from Employees as emp left outer join Employees as mgr
on emp.ReportsTo=mgr.EmployeeID
group by mgr.FirstName
------------------------------------------------------------
select mgr.FirstName as manager,COUNT(emp.firstname)
from Employees as emp left outer join Employees as mgr
on emp.ReportsTo=mgr.EmployeeID
group by mgr.FirstName
-----------------------------------------------------------------------------------------
--======================================================================================
									--Module 10
									--Using Subqueries
--======================================================================================
--using Sub Query 
--simple subquery
-- 1.Writing Basic Subqueries
-- --------------------------
/*
-- each query that you have written has been a single self-contained statement. SQL Server also provides the 
ability to nest one query within another—in other words, to form subqueries. In a subquery, the results of 
the inner query (subquery) are returned to the outer query. 
-- A subquery is a query that is nested inside a SELECT, INSERT, UPDATE, 
   or DELETE statement, or inside another subquery that can be used 
   anywhere an expression is allowed.
  
-- Why to Use Subqueries?
   - To break down a complex query into a series of logical steps
   - To answer a query that relies on the results of another query

-- Why to Use Joins Rather Than Subqueries?
   - SQL Server executes joins faster than subqueries


 -- Subqueries can be self-contained or correlated
       1-Self-contained subqueries have no dependency on outer query
       2-Correlated subqueries depend on values from outer query
*/



Select * from Orders Where EmployeeID = (select EmployeeId from Employees where FirstName = 'Nancy')

Select o.* From Orders as o Join Employees as e 
ON e.EmployeeID = o.EmployeeID
where e.FirstName = 'Nancy'


-- Using Subquery as Expression
-- ----------------------------
------------------------------------------------------------
SELECT CustomerID, orderid
FROM orders
WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE country ='Mexico')
-------------- same ex; by inner join-------------------
SELECT c.CustomerID, o.orderid
FROM Customers AS c JOIN Orders AS o
ON c.CustomerID = o.CustomerID
WHERE c.country = 'Mexico'
-------------------------------------------------------------
/*
- A subquery is also called an inner query or inner select, 
  while the statement containing a subquery is also called an 
  outer query or outer select.

-- Many Transact-SQL statements that include subqueries can be  formulated as joins
-- Joins better performance than subquery but generate the same result

*/
-- Scalar & Tabular Subqueries (Single Row subQ , Multiple Row SubQ)
-- ---------------------------  ----------------------------------
-- A scalar subquery is a subquery that returns a single row of data,
-- while a tabular subquery is one that returns multiple rows
-- If inner query returns an empty set, result is converted to NULL
------------------------------------------------------------------------------
-- scalar
select top 1 * from orders order by OrderID desc

-- tabular
Use Northwind
select  c.CustomerID
from Customers c
where CustomerID IN (select CustomerID from orders)

-- SELECT statement built using a subquery:
-- ----------------------------------------
SELECT  e.EmployeeID
FROM    Employees e
WHERE   e.EmployeeID IN(SELECT o.EmployeeID FROM   Orders o)

-- SELECT statement built using a join that returns the same result set:
-- --------------------------------------------------------------------
SELECT  distinct e.EmployeeID
FROM    Employees e join Orders o
ON e.EmployeeID = o.EmployeeID

--======================================================================================================

-- 2.Writing Correlated Subqueries
-- -------------------------------
/*
-- Many queries can be evaluated by executing the subquery once and 
   substituting the resulting value or values into the WHERE clause of 
   the outer query, turning the subquery into a correlated, or repeating, 
   subquery.
-- This means that the subquery is executed repeatedly, 
   once for each row that might be selected by the outer query.
-- correlated subquery cannot stand alone, as it depends on the outer query
-- A correlated subquery is an inner subquery whose information is referenced by the  main,outerquery
-- RETURNS A MORE THAN ONE ROW
-- use a multiple-row operator (IN,not in,ALL,ANY,between)    IN ---> =ANY
-- Behaves as if inner query is executed once per outer row

          
*/


--EX:
----
SELECT  e.FirstName 
FROM    employees AS e
WHERE   e.employeeid in(SELECT o.employeeid FROM   orders o WHERE o.employeeid =  e.employeeid)

SELECT  e.FirstName 
FROM    employees AS e
WHERE   e.employeeid Not IN(SELECT o.employeeid FROM   orders o WHERE o.employeeid =  e.employeeid)

Select c.CompanyName 
From Customers as C
Where c.CustomerID Not IN(Select CustomerID 
                          From Orders AS O 
					      Where O.CustomerID = c.CustomerID)


--EX:
-----
USE northwind
SELECT orderid, customerid 
FROM orders AS o 
WHERE 20 < (SELECT quantity
		     FROM [order details] AS od
             WHERE o.orderid = od.orderid
             AND  od.productid = 23)
GO


--test
select quantity from  [order details]
where quantity >20 and productid=23


--Key words All Any 
 -- Lets create two tables and inser values
CREATE TABLE Table1 (Id int)
GO
INSERT INTO Table1 VALUES (1), (2), (3), (4), (5)
--Drop table table2
CREATE TABLE Table2 (Id int)
GO
INSERT INTO Table2  VALUES (1), (3), (5)

Select * from Table1
Select * from Table2

SELECT Id FROM Table1 
WHERE Id =ANY (SELECT Id FROM Table2)

SELECT Id FROM Table1 
WHERE Id =ALL (SELECT Id FROM Table2)
 
 SELECT Id FROM Table1 
 WHERE Id >=ANY (SELECT Id FROM Table2) 

 SELECT Id FROM Table1 
 WHERE Id >=ALL (SELECT Id FROM Table2)

SELECT Id FROM Table1 
 WHERE Id !=ALL (SELECT Id FROM Table2)
--------------------------------------------------------------------------------
Select Id From table2 where id in(select * from table1)
select id from table2 where exists(select * from table1)


--IF OBJECT_ID('Employees', 'U') IS NOT NULL
--  DROP TABLE Employees
--GO

--=====================  exists  ===========================
select ProductName
from Products
where exists (select * from Categories where Categories.CategoryID=Products.CategoryID and CategoryName='Dairy Products')




/*
-- Notes :
-----------
- The SELECT query of a subquery is always enclosed in parentheses. 
- It cannot include a COMPUTE , and may only include an ORDER BY clause when a TOP clause is also specified.
- It can include An optional GROUP BY clause,An optional WHERE clause  
*/
--==================================================================================
-- Using the ANY, ALL, and SOME Operators
-- --------------------------------------
SELECT  c.CustomerID
FROM    Customers c
WHERE   c.CustomerID in(SELECT o.CustomerID FROM   Orders o)
/*
-- WHERE expression comparison_operator [ANY | ALL] (subquery)
  -- Using the > comparison operator, 
  --   >ALL means greater than every value (greater than the maximum value):EX: >ALL (1, 2, 3) means greater than 3.
  --   <ALL Means less than the minimum.
  --   >ANY means greater than at least one of the values in the list of values returned by the subquery :
  --   >ANY (1, 2, 3) means greater than 1 (minimum).
  --   <ANY means less than the maximum.
  --   =ANY operator is equivalent to IN.
  --   <>ANY operator means not = a, or not = b, or not = c.
  --   NOT IN means not = a, and not = b, and not = c.
  --   <>ALL means the same as NOT IN     .          
*/
-----------------------------------------------------------------------------------------------------
use Northwind
select *from [Order Details] where ProductID = 23 ;

select orderid,customerid from orders as or1
where 20<(select quantity from [order details] as od
where or1.OrderID=od.OrderID and od.ProductID=23)
---------------------------------------------------------
select ProductName,UnitPrice,SupplierID
from Products 
where UnitPrice > (select AVG(unitprice) from Products)
-----------------------------------------------------------
use Northwind
select ProductName,UnitPrice,SupplierID
from Products 
where SupplierID in (select SupplierID from Products where ProductID>50)
------------------------------------------------------------
select ProductName,UnitPrice
from Products 
where CategoryID in (select CategoryID from Categories where CategoryName='Dairy Products')
------------------------------------------------------------
select ProductName,UnitPrice,(select max(UnitPrice) from Products) as maximum,UnitPrice-(select min(UnitPrice) from Products) as Diff
from Products 
where productID=1
------------------------------------------------------------
select  sum(unitprice),OrderID 
from [Order Details]  
group by OrderID 
------------------------------------------------------------
select productname,UnitPrice
from Products
where UnitPrice !=all(select  sum(unitprice) from [Order Details]  group by OrderID )
------------------------------------------------------------
select productname,UnitPrice
from Products
where UnitPrice >=all(select  sum(unitprice) from [Order Details] where OrderID=10923  group by OrderID )
------------------------------------------------------------
select productname,UnitPrice
from Products
where UnitPrice <=any(select  sum(unitprice) from [Order Details] where OrderID=10923  group by OrderID )
------------------------------------------------------------





------------------------------------------------------------
-- Using Subquery as Expression
-- ----------------------------

-- tabular
Use Northwind
select  c.CustomerID
from Customers c
where CustomerID IN (select CustomerID from orders)



SELECT  e.EmployeeID
FROM    Employees e
WHERE   e.EmployeeID IN
             (SELECT o.EmployeeID
              FROM   Orders o)



SELECT  distinct e.EmployeeID
FROM    Employees e join Orders o
ON e.EmployeeID = o.EmployeeID




-- Using the ANY, ALL, and SOME Operators
-- --------------------------------------
SELECT  c.CustomerID
FROM    Customers c
WHERE   c.CustomerID in               -- the same result with =Any ,=Some
             (SELECT o.CustomerID
              FROM   Orders o)

/*
-- WHERE expression comparison_operator [ANY | ALL] (subquery)
  -- Using the > comparison operator, 
  --   >ALL means greater than every value (greater than the maximum value):
       EX: >ALL (1, 2, 3) means greater than 3.
  --   <ALL Means less than the minimum.
  
  --   >ANY means greater than at least one of the values in the list
        of values returned by the subquery :
  --   >ANY (1, 2, 3) means greater than 1 (minimum).
  --   <ANY means less than the maximum.
  
  --   =ANY operator is equivalent to IN.
  
  --   <>ANY operator means not = a, or not = b, or not = c.
  --   NOT IN means not = a, and not = b, and not = c.
  --   <>ALL means the same as NOT IN     .          

*/


SELECT  c.CustomerID
FROM    Customers c
WHERE   c.CustomerID <> ALL            -- = Not In
             (SELECT o.CustomerID
              FROM   Orders o)
                            
                
Create  Table Depts
(empid int,jobid varchar(50),salary int)

insert Depts values
                                              
        (103, 'IT_PROG',          9000),                                              
        (104, 'IT_PROG',          6000),                                              
        (105, 'IT_PROG',          4800),                                               
        (106, 'IT_PROG',          4800),                                              
        (107, 'IT_PROG',          4200),                                               
        (108, 'FI_MGR' ,         12000),                                              
        (109, 'FI_ACCOUNT',       9000),                                              
        (110, 'FI_ACCOUNT',      8200),                                                                                                                                  
        (122, 'ST_MAN'    ,       7900),                                                                                           
        (123, 'ST_MAN'    ,      6500),                                              
        (124, 'ST_MAN'    ,       5800),                                              
        (143, 'ST_CLERK'  ,      2600),                                             
        (144, 'ST_CLERK'   ,      2500),                                                                                            
        (145, 'SA_MAN'     ,     14000),                                              
        (146, 'SA_MAN'     ,    13500),                                             
        (147, 'SA_MAN'     ,     12000),                                             
        (148, 'SA_MAN'     ,     11000),                                              
        (159, 'SA_REP'      ,     8000),                                              
        (160, 'SA_REP'      ,     7500),                                              
        (161, 'SA_REP'      ,     7000),                                               
        (162, 'SA_REP'       ,   10500),                                               
        (163, 'SA_REP'      ,     9500),                                               
        (171, 'SA_REP'      ,     7400),                                               
        (187, 'SH_CLERK'    ,     3000),                                               
        (188, 'SH_CLERK'    ,     3800),                                                                                             
        (189, 'SH_CLERK'    ,     3600)                                               
       


SELECT empid, JOBID, SALARY
FROM   Depts
WHERE  SALARY < ANY
                    (SELECT SALARY
                     FROM Depts
                     WHERE JOBID = 'IT_PROG')          -- 9000, 6000,4800,4200

AND JOBID <> 'IT_PROG'                               -- 9000(IT_PROG is the max)
                     


SELECT empid, JOBID, SALARY
FROM   Depts
WHERE  SALARY < ALL
                    (SELECT SALARY
                     FROM   Depts
                     WHERE  JOBID = 'IT_PROG')    -- 9000, 6000,4800,4200

AND JOBID <> 'IT_PROG'





