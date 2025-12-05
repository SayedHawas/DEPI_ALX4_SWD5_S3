-- Day 3 

--Writing SELECT Queries

	--1- Writing Simple SELECT Statements.       Done 
	--2- Eliminating Duplicates with DISTINCT.   Done   
	--3- Using Column and Table Aliases.         Done 
	--4- Writing Simple CASE Expressions.        Done       
	--5- Filter                                  Done
	--6- Sorting                                 Done
	--7- Join 
---------------------------------------
--HOL Hand On Lab 
--1) Create DB
--2) Create tables  - Relation  (Create ,Alter , Drop )
--3) ERD UML
--4) Insert  , Update , delete  (DDL Truncte)
---------------------------------------------------------
--================================================
--        Types of Relationships
--a. One-One Relationship    (1-1 Relationship)   Done
--b. One-Many Relationship   (1-M Relationship)   Done
--c. Many-Many Relationship  (M-M Relationship)   Done
--================================================
--HOL Hand On Lab 
--Create Database     Done 
--Create table        Done
--Alter               Done
--Drop                Done
--Insert              Done
--Update              Done

--Delete              Done
--Truncate            Done
--Drop                Done

Create Database CompanyDB
GO
Use CompanyDB
GO
--DDL
-- Table Create , Alter , Drop 
-- Column Create , Alter , Drop 
Create table Departments (DepartmentId int Primary Key Identity(1,1), 
                          Name nvarchar(150) Not null,
						  ManagerName nvarchar(100) );
GO
--Columns 
Alter table Departments Add  Description nvarchar(50) Not Null; --Add Column 
Alter table Departments alter column Description nvarchar(350)  --Modify Column 
Alter table Departments Drop Column Description  --Drop 
Drop table Departments
USE master
GO
Drop Database CompanyDB
----------------------------------------------
--DML
--Insert 
USE MyCompanyDB
GO
Select * from Departments

Insert into Departments ( Name) Values ('Sales')
Insert Into Departments Values ('HR')
Select * from Departments
Insert Into Departments Values ('Accounting'),('IT'),('CS')
Select * from Departments

Select * from Employees
Insert Into Employees (JobTitle , Name,departmentId) Values ('Eng','Ahmed',4)
Insert Into Employees Values ('Eng','Ahmed',4)
Insert Into Employees Values ('yasser','Admin',4),('tamer','Account',3)

--Update
Update Employees Set Name = 'Mohammed' , JobTitle = 'Developer' Where EmployeeId = 2

--Delete 
Delete  Employees where EmployeeId = 3

Select * from Employees

Delete from Employees

Insert Into Employees Values ('yasser','Admin',4),('tamer','Account',3)

Select * from Employees

--DDL
Truncate table Employees  --Delete All Rows + Reset Identity 
------------------------------------------------------------------
--Create table T1 (Id int , Name nvarchar(50) default'NoName',
--------------------------------------------------------------------
--session Part 2
	--4- Writing Simple CASE Expressions.         
	--5- Filter  
	--6- Sorting 
	--7- Join 
Use Northwind
GO
select * from employees 

select employeeId , lastname , Hiredate 
from employees 

SELECT EmployeeID, lastname, hiredate, YEAR(hiredate) as [Hire Year]
FROM Employees
Go;

--3 SELECT    <select list>       Defines which columns to return
--1 FROM      <table source>      Defines table(s) to query
--2 WHERE     <search condition>  Filters rows using a predicate or Operators
/*
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
-------------------------------------------------------------------------------
--  - The rows retrieved by a query are not guaranteed to be unique, or in order .
--  - DISTINCT   to eliminate duplicates. 
--  - ORDER BY  to Order the result set.

-- Example for Duplicated values 
USE    Northwind
go
SELECT Country FROM   Customers
GO
-- Using SELECT ALL "The same Result" :-
USE    Northwind
SELECT ALL Country    -- ALL values in Country 
FROM   Customers
GO

select distinct title
from Employees

select  distinct city 
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

--table 

Select FirstName  From Employees

Select employees.FirstName , Employees.LastName From Employees

Select emp.FirstName , emp.LastName from Employees AS Emp
--------------------------------------------------------------
--Case After Selete Expression (Simple , Searched) 

-------------------------------------
/* Writing Simple CASE Expressions :- 
-----------------------------------------------
  - The CASE expression has two formats:-
     A) "The simple" CASE expression compares an expression to a set of simple expressions to determine the result.
     B) "The searched" CASE expression evaluates a set of Boolean expressions to determine the result.

  - Both formats support an optional ELSE argument.
  - In T-SQL CASE expressions return a single, or scalar, value. Unlike in some other programming languages.
  - In T-SQL CASE expressions are not statements, nor do they specify the control of programmatic flow.
  - CASE expressions can be used include in the SELECT, WHERE, HAVING, IN, DELETE, UPDATE, and inside of built-in functions.
---------------------------------------------------------------------------------------------------------------------
 1) Simple CASE expressions 
 --------------------------
    - A simple CASE expression checks one expression against multiple values.
	- Within a SELECT statement, a simple CASE expression allows only an equality check; no other comparisons are made.
	- Working by comparing the first expression to the expression in each WHEN clause for equivalency.
	- If these expressions are equivalent, the expression in the THEN clause will be returned.

-- Simple Case Syntax :- 
-------------------------
     CASE expression
     WHEN expression1 THEN expression1
    [[WHEN expression2 THEN expression2] [...]]
    [ELSE expressionN]
	  END
*/
use Northwind



Select * from Employees 

Select EmployeeID, FirstName , LastName , Country From Employees


Select EmployeeID, FirstName , LastName , Country , 
Case Country
When 'USA' Then 'Amrican'
when 'UK' Then 'British'
Else 'Anthor Language'
End AS [Languages]
From Employees

select firstname, lastname ,city,country ,
CASE country 
when 'usa'  then 'America' 
when 'UK'   then  'British'
else  ' anthor language'
end as language
from employees
go

SELECT productid, productname, categoryid,
CASE categoryid
WHEN 1 THEN 'Beverages'
WHEN 2 THEN 'Condiments'
WHEN 2 THEN 'Confections'
ELSE 'Unknown Category'
END AS categoryname
FROM Products

--Lab 
use Northwind 
go 
Create table EmployeesCase
(
ID int identity Primary Key ,
Name nvarchar(50),
Salary decimal(9,2),
Attend bit 
)
go 
insert into EmployeesCase values 
('Ahmed',2000,Null),
('Ali',3000,0),
('Retaj',4000,1),
('Mariam',5000,1),
('sayed',6000,0)

select * from EmployeesCase
-----------------------------


Select ID  ,Name ,Salary ,
Case Attend 
When 0 then 'No attend' 
when 1 then 'Attend'
Else 'Not state'
End As [Status Attend]
from EmployeesCase 



Select * , 
Case Attend
When 0 then 'Not Attand'
When 1 then 'Attend'
Else 'Pending' END AS [New Attend],
"NEW SALARY" = Case Salary 
When 4000 Then 'Good'
When 6000 Then  'Very Good'
Else 'Bad' End
from EmployeesCase

--Two Forms of CASE Expressions:
--1-Simple CASE
--EX:

select ID, Name , attend , salary
from EmployeesCase

select ID, Name , case  attend 
when 1 then 'attend'
when 0 then 'No attend'
else 'Not Yet'
end as [status Attend]
from EmployeesCase

---------------------------------------------------------------------------
/*
 2) Searched CASE expressions :-
 -------------------------------
 - Allows comparison operators, and the use of AND and/or OR between each Boolean expression. 
-- Searched Case Syntax :- 
-------------------------
     CASE
	 WHEN Boolean_expression1 THEN expression1
     [[WHEN Boolean_expression2 THEN expression2] [...]] 
     [ELSE expressionN] 
	 END
*/
--2-Searched CASE (with conditions or predicates)
--EX:
select ID , Name ,Salary from EmployeesCase 








select ID , Name ,Salary , 
Case
When Salary >=1 AND Salary <=2000  then'Low'
When Salary >=2001 AND Salary <=4000 then 'Normal'
When Salary > 4001 then  'High'
Else 'InValid' END  AS SalaryRange
from EmployeesCase 



select ID , Name , Salary , 
"salary range" = case 
when salary >1 and salary <=2000 then 'Low'
when salary >2000 and salary <=3000 then 'medium'
else 'high'
end 
from EmployeesCase

--2-Searched CASE (with conditions or predicates)
--EX:


SELECT   Productid, ProductName, "Price Range" = 
      CASE 
         WHEN unitPrice =  0 THEN 'item - not for resale'
         WHEN unitPrice < 50 THEN 'Under $50'
         WHEN unitPrice >= 50 and unitPrice < 250 THEN 'Under $250'
         WHEN unitPrice >= 250 and unitPrice < 1000 THEN 'Under $1000'
         ELSE 'Over $1000'
      END
FROM Products
---------------------------------------------------------------------------
--Module 5 
--Sorting and Filtering Data
------------------------------
/*
 -- Operators & Predicates :- 
 -----------------------------
1) Comparison :  
----------------  
=  (equals)
>  (Greater Than)
<  (Less Than)
>= (Greater Than or Equal To)
<= (Less Than or Equal To)
<> (Not Equal)
!= (Not Equal To)       -- Not ANSI
!< (Not Less Than)      -- Not ANSI
!> (Not Greater Than)   -- Not ANSI		
------------------------------------------------------------------------------------
2) Arithmetic :
----------------
+  Addition
-  Subtraction
*  Multiplication
/  Division
%  Modulo
-------------------------------------------------------------------------------------
3) Concatenation :
------------------
+  Combines two strings or more into one string 
------------------------------------------------------------------------------------
4) String Comparison :
-----------------------
=    operator :-  tests to see if both strings are exact matches.
LIKE operator :-  uses wildcards to search for near matches.

LIKE WildCards :- 
------------------ 
%           A substitute for zero or more characters.
_           A substitute for a single character.
[charlist]	Sets and ranges of characters to match.
[^charlist] Matches only a character NOT specified within the brackets.

WildCards Examples :-
----------------------
-- 'sm%'    = word beginning with the letters sm .
-- '%sm'    = word ending with the letters sm .
-- 'sm_'    = word beginning with the letters sm and one more letter .
-- '%sm%'   = word containing the letters sm .
-- '[gs]%'  = word beginning with the letters g  or  s .
-- '[g-s]%' = word beginning with the letters in the range between g to s .
-- 's[^m]%' = word beginning with the letter s but the second letter is not m .

Using Wildcard Characters As Literals
---------------------------------------
-You can use the wildcard pattern matching characters as literal characters. 
-To use a wildcard character as a literal character, enclose the wildcard character in brackets. 
-The following table shows several examples of using the LIKE keyword and the [ ] wildcard characters.

Wildcard Characters As Literals Examples
----------------------------------------
--LIKE '5[%]'   --->  5%
--LIKE '[_]n'   --->  _n
--LIKE '[a-cdf]' ---> a, b, c, d, or f
--LIKE '[-acdf]' ---> -, a, c, d, or f
--LIKE '[ [ ]'   ---> [
--LIKE ']'       ---> ]
--LIKE 'abc[_]d%' ---> abc_d and abc_de
--LIKE 'abc[def]' ---> abcd, abce, and abcf
-------------------------------------------------------------------------------------------------------------------------
5) Logical Operator :-
----------------------
- used to combine condition arguments or to reverse the TRUE/FALSE result of an argument.
AND  ) combines arguments so that results are only returned if both arguments are TRUE.
OR   ) returns TRUE if either of the conditions met.
NOT  ) negates or reverses the result of the expression.
ALL, ANY, EXISTS, and SOME ) are other logical operators that are not as common.

- When combining logical operators be aware of the order that they are processed.
All NOT  expressions are processed first,
AND      is processed next  
OR       being the last operator evaluated. 

Note :-
-------
- In a very large table why would do you think the NOT operator might be the least efficient one to use?
- The NOT operator must first determine if the comparison is TRUE or FALSE and then perform 
  additional processing to change the result to the opposite one. On queries with large row sets 
  this can extra processing can affect performance.
- The logical operators are only evaluated after all arithmetic operators have been evaluated.
Retrieving a Range of values
----------------------------
- BETWEEN is used to test a range of expressions in the same way that >= AND <= does. 
- It takes a low and a high value and tests to see if the expression falls within the range.
- Note : Using BETWEEN assumes that the low and high values are included in the range.
--------------------------------------------------------------------------------------------------------------------
*/

Select * from Employees where EmployeeID <>3

Select * from Employees Where HireDate between '1-1-1992' and '1-1-1993'

Select * from Employees Where FirstName = 'Nancy'

Select * from Employees Where FirstName like 'N%'

Select * from Employees Where FirstName like '%N'

Select * from Employees Where FirstName like '%N%'

Select * from Employees Where FirstName like '_N%'

Select * from Employees Where FirstName like '_'

use Northwind;
go
select EmployeeID as ID , FirstName as [First Name], Employees.LastName as [Last Name],HireDate
from Employees
where EmployeeID=3
--------------------------------------------------------------
select EmployeeID as ID , FirstName as [First Name], Employees.LastName as [Last Name],HireDate
from Employees
where HireDate>'5/3/1993'
--------------------------------------------------------------
select EmployeeID as ID , FirstName as [First Name], Employees.LastName as [Last Name],HireDate
from Employees
where HireDate<'5/3/1993'
--------------------------------------------------------------
select EmployeeID as ID , FirstName as [First Name], Employees.LastName as [Last Name],HireDate
from Employees
where HireDate='5/3/1993'
--------------------------------------------------------------
select EmployeeID as ID , FirstName as [First Name], Employees.LastName as [Last Name],HireDate
from Employees
where HireDate!='5/3/1993'
--------------------------------------------------------------
select OrderID as [Order ID],ProductID as [Product ID],(UnitPrice*Quantity)as [Total Price]
from [order details]
where (UnitPrice*Quantity)>500
--------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title
from Employees
where Title='Sales Representative'
--------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title,Country
from Employees
where Country='USA'
----------------------------------------------------------------
select customerid as[Customer Id],companyname,contacttitle,phone
from customers
where CustomerID='PICCO'
----------------------------------------------------------------
select customerid as[Customer Id],companyname,contacttitle,phone
from customers
where CustomerID like  'P%'
---------------------------------------------------------------
select customerid as[Customer Id],companyname,contacttitle,phone
from customers
where CustomerID like  '%s'
--------------------------------------------------------------
select customerid as[Customer Id],companyname,contacttitle,phone
from customers
where CustomerID like  'P_ri_'
----------------------------------------------------------------
select customerid as[Customer Id],companyname,contacttitle,phone
from customers
where CustomerID like  '__r%'
----------------------------------------------------------------
select *
from Employees
where FirstName like 's%n'
----------------------------------------------------------------
select *
from Employees
where FirstName Not like '_____'
----------------------------------------------------------------
select *
from Employees
where FirstName like '______%'
----------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title
from Employees
where FirstName='nancy' or LastName='king'
---------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title
from Employees
where FirstName='andrew' and LastName='king'
-----------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title
from Employees
where   LastName='king' and Not FirstName='andrew'
-----------------------------------------------------------------
select *
from Employees
where Title='Sales Representative' and HireDate>'5/3/1993'
----------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title,HireDate
from Employees
where HireDate between '5/3/1993' and '12/31/1993'
----------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title,HireDate
from Employees
where HireDate Not between '5/3/1993' and '12/31/1993'
-----------------------------------------------------------------
select categoryid as [Category ID],categoryname as[Category Name]
from Categories
where CategoryID in (3,4,5,6)
-----------------------------------------------------------------
select categoryid as [Category ID],categoryname as[Category Name]
from Categories
where CategoryID not in (3,4,5,6)
-------------------------------------------------------------------
select customerid,companyname,contactname,region
from customers
where Region is null 
------------------------------------------------------------------
select customerid,companyname,contactname,region
from customers
where Region is not null 
------------------------------------------------------------------
select customerid,companyname,contactname,ISNULL(region,'') as region
from customers
-------------------------------------------------------------------
--Reg Expression 
select * from employees where firstname like 'a[d,n]%'    -- , and  [Range]
select * from employees where firstname like 'an[d-n]%'   -- - to 
select * from employees where firstname like 'an[^d]%'
select * from employees where firstname like 'a[^d-n]%'
Select * from Employees where LastName like 'd%o'             
select CompanyName from customers where CompanyName Not like 'A_[f,a,t]%'
--==================================================================================
--Advanced 
-- CompanyName have no spaces
SELECT * FROM   Customers
where  CompanyName NOT like '% %'
GO
SELECT * FROM   Customers
where  CompanyName  like '% %'

-- CompanyName have ( ' )
SELECT * FROM   Customers
WHERE CompanyName Like '%['']%'

-- Where Collate
SELECT * FROM   Customers
WHERE CompanyName COLLATE Latin1_General_CS_AI Like '%A%'


-- Where not Collate
SELECT * FROM   Customers
WHERE CompanyName COLLATE Latin1_General_CS_AI Like '%A%'

-- Like With INT 
SELECT * FROM   [Order Details]
WHERE OrderID LIKE '105%'

--==================================================================================
-- Sorting 
--======================
------------------------------------------
--Sorting Data   -- Order By    Asc | Desc 
------------------------------------------


Select * from Employees Order By firstName  --A-Z

Select * from Employees Order By firstName desc ---Z-a



Select * from [Order Details] Order By Quantity , UnitPrice

Select * from [Order Details] Order By 2

Select * from Employees
Select * from Employees Order By FirstName Asc  -- A-Z

Select * from Employees Order By FirstName Desc  --Z-A



Select *                 --3
From Employees           --1
Where EmployeeID >5      --2
Order By FirstName Asc   --4  




-- with order By 
select * from employees order By HireDate
select * from employees where Region is null order by FirstName 
select * from employees where Region is not null  order by LastName

select firstname as [First Name],lastname as [LastName],title,HireDate
from Employees
order by LastName
--------------------------------------------------------------------
select firstname as [First Name],lastname as [LastName],title,HireDate
from Employees
order by LastName,[First Name]
--------------------------------------------------------------------
select employeeid, firstname as [First Name],lastname as [LastName],title,HireDate
from Employees
order by firstname , LastName
---------------------------------------------------------------------
select FirstName,LastName
from Employees
order by 1 , 2
----------------------------------------------------------------
select employeeid, firstname as [First Name],lastname as [LastName],title,HireDate
from Employees
order by EmployeeID desc



Select Top(3) * from Employees  -- First 3 Rows 

Select Top(3)* from Employees Order by EmployeeID Desc






Select Top (3) * from Employees

Select Top 3 * from Employees


Select                    --3
Top (3)*                  --5
from Employees            --1
Where EmployeeID > 7      --2
Order by EmployeeID Desc  --4


--------------------------------------------------------------------------------------
--Filtering in the ORDER BY Clause Using Top(N)
-- --------------------------------------------
/*
PERCENT 
Indicates that the query returns only the first expression percent of rows from the result set.
 Fractional values are rounded up to the next integer value. 

WITH TIES 
Specifies that the query result set includes any additional rows that match the values in 
the ORDER BY column or columns in the last row returned. This may cause more rows to be returned than 
the value specified in expression. For example, if expression is set to 5 but 2 additional rows match the 
values of the ORDER BY columns in row 5, the result set will contain 7 rows. 

TOP...WITH TIES can be specified only in SELECT statements, and only if an ORDER BY clause is specified. 
The returned order of tying records is arbitrary. ORDER BY does not affect this rule.
*/
---------------------------------------------------------------------
-- top (N)
select top(4)* from employees 

-- top With Order By 
select top(4)* from employees 
order by EmployeeID  desc

select top (10)OrderID,CustomerID,OrderDate 
from orders
order by OrderDate desc

--top(n)
Select Top 5 with Ties * from [Order Details] ORDER BY quantity desc
USE northwind
SELECT TOP 5 orderid,productid ,quantity
FROM [order details]
ORDER BY quantity desc
GO

-- TOP(n) with ties
USE northwind
SELECT TOP 5 WITH TIES orderid, productid, quantity
FROM [order details]
ORDER BY quantity DESC
GO

--PERCENT
Select Top(10) Percent* from Orders

SELECT TOP (10) PERCENT orderid, CustomerID, orderdate
FROM Orders
ORDER BY orderdate DESC;



Select Top(10) PERCENT * from Orders


Select * 
from Employees
Order by EmployeeID
Offset 4 rows Fetch first 4 Rows Only

-----------------------------------------------------------------------------------------------------
--Filtering in the ORDER BY Clause Using OFFSET-FETCH [New SQL 2012]
/*
-OFFSET { integer_constant | offset_row_count_expression } { ROW | ROWS } 
Specifies the number of rows to skip before it starts to return rows from the query expression. 
The value can be an integer constant or expression that is greater than or equal to zero. 

ROW and ROWS are synonyms and are provided for ANSI compatibility.

-FETCH { FIRST | NEXT } { integer_constant | fetch_row_count_expression } { ROW | ROWS } ONLY 
Specifies the number of rows to return after the OFFSET clause has been processed. 
The value can be an integer constant or expression that is greater than or equal to one. 

FIRST and NEXT are synonyms and are provided for ANSI compatibility.
-------------------------------------------------------------------
Notes :-
--------
Natural Language approach to code:
*) ROW and ROWS interchangeable
*) FIRST and NEXT interchangeable
ONLY optional—makes meaning clearer to human reader
OFFSET value and FETCH value may be constants or expressions, including variables and parameters
*/
Select Employees.EmployeeID , Employees.FirstName , Employees.LastName
from Employees
Order by Employees.EmployeeID
OFFSET 0 ROWS;   --Skip 0 rows

Select Employees.EmployeeID , Employees.FirstName , Employees.LastName
from Employees
Order by Employees.EmployeeID
OFFSET 6 ROWS;    --Skip 6 rows

Select Employees.EmployeeID , Employees.FirstName , Employees.LastName
from Employees
Order by Employees.EmployeeID
OFFSET 0 ROWS FETCH first 2 ROWS only;   

SELECT orderid, CustomerID, orderdate
FROM Orders
ORDER BY orderdate, orderid 
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
---------------------------------------------------

Select Top(9)* from Products Order by ProductID desc

--Page (Page-1) * 9    PageSize 9
-- 1-1 *9 =0                     9
-- 2-1 *9 = 9                    9

Select * from Products 
Order by ProductID 
Offset 27 rows Fetch first 9 Rows Only
--------------------------------------------------
/*
-- Logical Query Processing :- 
-------------------------------
5 SELECT    <select list>       Defines which columns to return
1 FROM      <table source>      Defines table(s) to query
2 WHERE     <search condition>  Filters rows using a predicate or Operators

6 ORDER BY  <order by list>     Sorts the Result Set

 --1-From
 --2-On
 --3-Where 
 --4-Group by 
 --5-having 
 --6- select 
 --7-Order by 
 --8-Top

 ----------------------------------------------------
-- What is SQL statemts Processing ?
--1- parsing        Syntax 
--2- Resolving      Object 
--3- Optmizing      assing and select the Algorism 
--4- compiling      T_SQL
--5- Executing      Show result 
*/

Select * From Employees

Select * FROM Employees WHERE EmployeeID = 5  -- 0, 1 NativeCode  
--------------------------------------
--Types of Relationships
--a. One-One Relationship    (1-1 Relationship)
--b. One-Many Relationship   (1-M Relationship)
--c. Many-Many Relationship  (M-M Relationship)

Select EmployeeID, FirstName , ReportsTo from Employees

--OnHand Lab
Create Database Day3DB
GO
USE Day3DB


--------------------------------------------------------
--Module 4
--Querying Multiple Tables
---------------------------

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
 Inner Join 
 Outer Join
   - Left Out Join
   - Right Out Join 
   - Full Out Join  
Cross Join 
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


--Lab
USE Day3DB
Go
Select * from Departments
Select * from Employees

Select * from Employees

GO
Select e.EmployeeId,e.Name ,e.Job,d.Name as [Department Name]
From Departments as d Inner Join Employees as e 
ON d.DepartmentId = e.DepartmentId

Select Top(1) e.EmployeeId,e.Name ,e.Job,d.Name as [Department Name]
From Departments as d  Join Employees as e 
ON d.DepartmentId = e.DepartmentId
Where e.Name Like'%a%'
Order by 1 Desc

--ANSI 89
--Select e.EmployeeId,e.Name ,e.Job,d.Name as [Department Name]
--From Departments as d , Employees as e 
--where d.DepartmentId = e.DepartmentId

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

Select * 
from Departments as d   left Outer Join  Employees as e 
ON d.departmentId = e.DepartmentId 


Select * 
from Departments as d   left  Join  Employees as e 
ON d.departmentId = e.DepartmentId 


Select * 
from Departments as d   Right  Join  Employees as e 
ON d.departmentId = e.DepartmentId 



Select * 
from Departments as d    left Join  Employees as e 
ON d.departmentId = e.DepartmentId 

-------------------------------------------------------------------------

