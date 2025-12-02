--Notes 
/*
Notes 
Notes 
*/
--use <Database>  Change Context
use Northwind
GO
print 100
print 'Hello World in SQL Server '

SELECT 100
SELECT 'Hello World in SQL Server'

--Writing basic single-table SELECT statements
--Understanding the fundamentals of data retrieval and filtering
--1989  - 1990
--SQL --> T-SQL 
--DDL (Create , Alter , Drop)
--DML (Insert , Update , Delete) ,SELECT
--DQL Select 
--DCL
------------------------------------------
--Select * (List Of Columns) From <Table>
Select * from Categories

Select CategoryName , CategoryId from Categories
Select CategoryID,CategoryName from Categories


--Module 3:  
--Writing SELECT Queries

	--1- Writing Simple SELECT Statements.
	--2- Eliminating Duplicates with DISTINCT. 
	--3- Using Column and Table Aliases.
	--4- Writing Simple CASE Expressions. 
--===================================================================================
--Expressions :- 
------------------ 
 -- Combination of identifiers, values, and operators evaluated to obtain a single result.
 -- Can be used in SELECT statements , WHERE clause. */

-- Example For Expressions
--identifiers
--============
/*       1- -- OR /* */
         2- [ ]
         3- ""
         4- #
         5- @
*/
--EX:-
------
--Using Calculations in the SELECT Clause

Select 10 -- Select 10 = Print 10
 
select 10+4 

select 10%3 

select 'Ahmed '+'Ali' as [Full Name]

Select * from Employees

Select EmployeeID , FirstName , LastName , FirstName +' '+ LastName as [Full Name]
From Employees

Select 1+ '5'
Select 1+'5b'
-- Basic Select statement
-- ----------------------
-- A basic SELECT statement only requires two parts: 
-- A select list of columns to show  
-- A FROM clause indicating the table that holds the data.

--Display all columns
use northwind 
select * from Employees
GO

use northwind 
select * from Employees
GO

Select EmployeeID,FirstName,Title, BirthDate  From Employees

--Ex:-
use northwind
select FirstName ,LastName
from Employees
Go;

select  FirstName + ' ' +LastName  as [Full Name] from Employees

select  FirstName + ' ' + LastName   [Full Name] from Employees 

select  [Full Name] = FirstName + ' ' + LastName from Employees



--OR
-- Before Expressions FirstName and LastName not in the same Column
USE northwind
SELECT  EmployeeID,FirstName,LastName,City 
FROM Employees
GO

-- After Expressions FirstName and LastName in the same Column using Alias FullName
USE northwind
SELECT EmployeeID,FirstName + ' ' + LastName AS FullName,City 
FROM Employees
GO

use northwind
select Products.ProductID , Products.ProductName ,Products.UnitPrice , products.UnitsInStock
from Products
Go
--Full Path 
Select * from MyDatabase..Employees --Default Schema  <Database.Schema.Employees> 

Select [LastName],[LastName] ,[Title]from Employees

Select Categories.CategoryID,Categories.CategoryName
From Categories

--To use a built-in T-SQL function on a column in the SELECT list, you pass the name of the column to the
--function as an input:
--Ex:-
select FirstName,* from employees 

select employeeId , lastname , Hiredate 
from employees 

Select GETDATE()
Select Year(GETDATE())

Select EmployeeID , FirstName , LastName , year(BirthDate) BirthYear from Employees

SELECT EmployeeID, lastname, hiredate, YEAR(hiredate) as [Hire Year]
FROM Employees
Go;

Select GetDate()
Select Year('1-1-2029')
Select Year(GetDate())-- Nested 
-----------------------------------------------------------------------------
/*Remember :-
----------
-- Logical Query Processing :- 
-------------------------------

5 SELECT    <select list>       Defines which columns to return
1 FROM      <table source>      Defines table(s) to query
2 WHERE     <search condition>  Filters rows using a predicate or Operators
3 GROUP BY  <group by list>     Arranges rows by groups
4 HAVING    <search condition>  Filters groups using a predicate or Operators
6 ORDER BY  <order by list>     Sorts the Result Set

Writing Simple SELECT Statements:-
-----------------------------------------------
    - The SELECT and FROM clauses are the primary focus of this module.
	- You Should End all statements with a semicolon (;) character.
	   A) In the current version of SQL Server 2012, semicolons are an optional terminator for most statements.
	   B) Future versions will require semicolon (;) character.
	- If the table name contains irregular characters such as spaces,  you will need to delimit, or enclose, the name.
	   A) T-SQL supports the use of the ANSI standard double quotes "Sales Order Details".
	   B) SQL Server-specific square brackets [Sales Order Details].
*/
-----------------------------------------------------------------------------
--Example for using brackets :-
USE    Northwind
SELECT * FROM  [Sales by Category]
GO
--Example for using double quotes :-
USE    Northwind
SELECT * FROM   "Sales by Category"     -- ANSI Standard
GO


--Filter 

Select * from Employees

Select FirstName , LastName , EmployeeId 
From Employees
where EmployeeID >= 5 AND  EmployeeID <=8 

Select FirstName , LastName , EmployeeId 
From Employees
where EmployeeID in(5,6,7,8)

Select FirstName , LastName , EmployeeId 
From Employees
where EmployeeID between 5 AND 8

Select FirstName , LastName , EmployeeId 
From Employees
where EmployeeID >= 5 Or EmployeeID =3

Select FirstName , LastName , EmployeeId 
From Employees
where EmployeeID >= 5 and EmployeeID =3

/*

>
<
>=
<=
=
<>
!=

*/
SELECT * FROM Employees

Select FirstName, City 
from Employees
Where City = 'London' OR  City= 'Seattle'

Select FirstName, City 
from Employees
Where City = 'London' And  FirstName= 'Steven'

Select FirstName, City 
from Employees
Where City = 'London' OR  FirstName= 'Nancy 2'
--============================================================================================
/*
    - T-SQL supports the use of the asterisk, or “star” character (*) to substitute for an explicit column list. 
	   A) This will retrieve all columns from the source table.
	   B) Avoid using the * in production work, because it will retrieve all columns in the table’s, This could cause bug.
--Eliminating Duplicates with DISTINCT :- 
----------------------------------------------------
  - The rows retrieved by a query are not guaranteed to be unique, or in order .
  - DISTINCT   to eliminate duplicates. 
  - ORDER BY  to Order the result set.
*/

Select count(*) From Employees
Select count(region) From Employees
Select count(IsNull(Region,' ')) From Employees

Select count(*) From Employees
Select Count(1)From Employees


Select 8 from employees

Select Region , IsNull(Region,' ') from Employees

Select City , country , Region , Address , 
City +' ' +country +' '+ ISnull(Region,'') +''+ Address   [FullAddress] from Employees




Select * 
from Employees
Where region IS Null

Select * 
from Employees
Where region  IS Not Null

--Function ISNULL('?','Replace')
--Where     IS NULL 
--          IS Not NULL 


-- Example for Duplicated values 

Select * from Customers

Select Country From Customers


USE    Northwind
go
SELECT Country FROM   Customers
GO
-- Using SELECT ALL "The same Result" :-
USE    Northwind
SELECT ALL Country    -- ALL values in Country 
FROM   Customers
GO

--  SELECT DISTINCT Replace SELECT ALL :-
USE    Northwind
go
SELECT DISTINCT Country    -- Unique values in Country 
FROM   Customers
GO
select Distinct title from employees 

Select Distinct City , Country from Employees
--- use Distinct 
-- select Without Duplication  
select distinct title
from Employees

select  distinct city 
from employees 

-- Two columns
select distinct title,city 
from employees 

select distinct city , title
from employees

--===================================
--Using Aliases to Refer to Columns
--===================================
-- with As 
select (city +' '+ country ) as address  ,firstName 
from employees 
-- WithOut as 
select (city +' '+ country )  address  ,firstName 
from employees
 -- = 
select   address = (city +' '+ country ) ,firstName 
from employees

-- ========================================
--Using Aliases to Refer to Table 

select Products.ProductID , Products.ProductName ,Products.UnitPrice , products.UnitsInStock
from Products

select Products.ProductID , Products.ProductName ,Products.UnitPrice , products.UnitsInStock  --error Must Use Alias
from Products as p 

select p.ProductID , p.ProductName ,p.UnitPrice , p.UnitsInStock
from Products as p



Select e.EmployeeID , e.FirstName    
from Employees as e



Select e.FirstName as [????? ?????] From Employees as e


Select * from employees where EmployeeID = 1 

Select * from employees Where FirstName = 'Nancy'


--Session 3
