--Création de la Base données HorizonBank_DB .
CREATE DATABASE HorizonBank_DB ;
GO

USE HorizonBank_DB ;
GO

-- Création des Tables de la base de données HorizonBank_DB ;
CREATE TABLE Branches ( BranchID Int Primary Key , Agency_Name nvarchar(50) , City nvarchar(30),Region nvarchar(30));

CREATE TABLE Employees ( EmployeeID INT Primary Key, BranchID INT FOREIGN KEY REFERENCES dbo.Branches([BranchID]), FullName varchar(30), JobTitle nvarchar(30) , HireDate DATE );

CREATE TABLE Customers ( CustomerID INT PRIMARY KEY , EmployeeID INT FOREIGN KEY REFERENCES dbo.Employees([EmployeeID]) , FullName varchar(30) , Email nvarchar(50) , PhoneNumber nvarchar(20) , DateOfBirth DATE , Country nvarchar(30) , CreditScore int);

CREATE TABLE Accounts ( AccountID INT PRIMARY KEY, CustomerID INT FOREIGN KEY REFERENCES dbo.Customers([CustomerID]) , AccountType nvarchar(50) , Balance decimal(18,2) , OpeningDate DATE , StatusAccounts nvarchar(20));

CREATE TABLE Transactions ( TransactionID INT PRIMARY KEY , AccountID INT FOREIGN KEY REFERENCES dbo.Accounts([AccountID]) , DateTransaction DATE , Amount decimal(18,2) , Type_Transaction nvarchar(50));

CREATE TABLE Loans ( LoanID INT PRIMARY KEY , CustomerID INT FOREIGN KEY REFERENCES dbo.Customers([CustomerID]) , LoanAmount decimal(18,2) , InterestRate decimal(5,2) , LoanTermMonth Int , StartDate DATE , LoanStatus nvarchar(50));
GO




