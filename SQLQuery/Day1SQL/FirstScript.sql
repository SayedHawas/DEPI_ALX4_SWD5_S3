--Start SQL Server 
USE Northwind
GO
Select * from Categories
-------------------
--DDL  Create , alter , Drop

--How To Create Database 
Create database MyDatabase2
GO
--USE MyDatabase2
GO
USE Master
GO
--Drop database MyDatabase2 --
GO
-------------------------------------
--Create Datatype 
-------------------
--text nvarchar(Length)
--Number    Integer int
--          Decimal decimal(9,2)   11111111.22
--Date      DateTime
--Boolean   bit

--Create table <Table Name> ( Name column-Type -Length - attribute)

USE MyDatabase
GO
Create table Employees (Id int Primary Key Identity,
                        Name nvarchar(50),
						DateOfBirth datetime,
						Salary   decimal(9,2),
						Attend   bit)

-- Query 
Select * From Employees
--Insert 
Insert into Employees values('Ahmed','1-1-2010',25000,1)

Select * from Employees

Insert into Employees values('Tamer','1-1-2005',30000,0)