-- Phase(1) Création de la Base données HorizonBank_DB .
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
GO [HorizonBank_DB];

--Phase (2) Insertion des données "salesé dans les tables avec INSERT
USE [HorizonBank_DB];

INSERT INTO Branches VALUES (1, 'Main Branch', 'Montreal', 'Quebec');

INSERT INTO Employees VALUES (10, 1, 'ALICE BOIVIN', 'Conseiller Senior', '2020-05-12');

INSERT INTO Customers VALUES 
(100, 10, 'jean dupont', 'j.dupont@email.com', '514-123-4567', '1985-03-10', 'Canada', 720),
(101, 10, 'MARC lefebvre', NULL, '438-999-0000', '1990-11-25', 'canada', 650), -- Pays en minuscule, Email NULL
(102, 10, 'SOPHIE MARTIN', 's.martin@work.com', 'non-renseigné', '1978-07-04', 'France', 400); -- Téléphone invalide

INSERT INTO Accounts VALUES 
(500, 100, 'Courant', 1500.50, '2023-01-01', 'Actif'),
(501, 101, 'Epargne', -50.00, '2023-05-15', 'Actif'), -- Solde négatif étrange pour de l'épargne
(502, 102, 'COURANT', 0.00, '2024-02-10', 'Inactif');

INSERT INTO Transactions (TransactionID, AccountID, DateTransaction, Amount, Type_Transaction) VALUES 
(1, 500, '2024-04-01', 200.00, 'DEPOT'),
(2, 500, '2024-04-02', -50.00, 'Retrait'), -- Montant négatif
(3, 501, '2024-04-05', 0.00, 'Virement'); -- Transaction à 0€ (inutile)

--Insertion des données pour compléter les colonnes 
USE HorizonBank_DB;
GO

-- 1. Complément Branches (Total 4)
INSERT INTO Branches VALUES 
(2, 'Downtown Toronto', 'Toronto', 'Ontario'),
(3, 'Vancouver West', 'Vancouver', 'British Columbia'),
(4, 'Paris Étoile', 'Paris', 'Île-de-France');

-- 2. Complément Employees (Total 5)
INSERT INTO Employees VALUES 
(11, 2, 'Robert Miller', 'Senior Manager', '2015-10-20'),
(12, 2, 'SARA CONNOR', 'Financial Advisor', '2022-01-05'),
(13, 3, 'David Zhang', 'Loan Officer', '2021-06-15'),
(14, 4, 'Amélie Poulain', 'Conseiller Client', '2023-09-12');

-- 3. Complément Customers (Total 10)
INSERT INTO Customers VALUES 
(103, 11, 'George Clooney', 'g.clooney@hollywood.com', '1-800-ACTOR', '1961-05-06', 'USA', 850),
(104, 12, 'LARA CROFT', 'contact@tombraider.uk', '0044-789-123', '1992-02-14', 'UK', 780),
(105, 13, 'bruce wayne', 'bruce@wayne-ent.com', '911-BAT-CALL', '1975-04-17', 'USA', 820),
(106, 14, 'Emma Watson', NULL, '06 12 34 56 78', '1990-04-15', 'france', 740), -- 'france' en minuscule
(107, 10, 'Jean Dupont', 'j.dupont@email.com', '514-123-4567', '1985-03-10', 'Canada', 720), -- DOUBLON (ID différent mais même personne)
(108, 12, 'Elon Musk', 'elon@mars.x', '001-444-555', '1971-06-28', 'USA', 800),
(109, 13, 'Marta Vieira', 'marta@football.br', 'non-renseigné', '1986-02-19', 'Brazil', 710);

-- 4. Complément Accounts (Total 10)
INSERT INTO Accounts VALUES 
(503, 103, 'Courant', 1250000.00, '2023-11-20', 'Actif'),
(504, 104, 'Epargne', 45000.00, '2024-01-10', 'Actif'),
(505, 105, 'Entreprise', 9800000.00, '2022-05-05', 'Actif'),
(506, 106, 'Courant', -120.50, '2024-03-01', 'Actif'), -- Découvert
(507, 108, 'Crypto-Linked', 500000.00, '2021-02-12', 'Actif'),
(508, 109, 'Epargne', 1200.00, '2023-12-25', 'Inactif'),
(509, 100, 'Investissement', 25000.00, '2024-01-15', 'Actif');

-- 5. Complément Transactions (Total 10)
INSERT INTO Transactions (TransactionID, AccountID, DateTransaction, Amount, Type_Transaction) VALUES 
(4, 503, '2024-04-10', 15000.00, 'DEPOT'),
(5, 504, '2024-04-11', 2000.00, 'Virement'),
(6, 505, '2024-04-12', 50000.00, 'DEPOT'),
(7, 506, '2024-04-13', 0.00, 'Frais Bancaires'), -- Inutile
(8, 507, '2024-04-14', -1000.00, 'Retrait ATM'), -- Négatif
(9, 508, '2024-04-15', 50.00, 'Depot'),
(10, 509, '2024-04-16', 500.00, 'Virement');

-- 1 - Les client dont le FullName comporte des miniscule ( Test de la casse)
SELECT [FullName]
FROM [dbo].[Customers]
WHERE [FullName] LIKE '%[a-z]%' COLLATE Latin1_General_BIN;

-- 2 - Identification des clients qui apparaissent plusieurs dans la table ( Test de doublons)
SELECT [FullName] , COUNT(*) AS NbreApparitions
FROM [dbo].[Customers]
GROUP BY [FullName]
Having COUNT(*) > 1;

--3 Identification des clients dont le Nom de la ville ne commance pas par une majuscule ( Test de coherence géographique)
SELECT  [FullName] , [Country]
FROM [dbo].[Customers]
WHERE [Country] LIKE '[a-z]%' COLLATE Latin1_General_BIN; 

-- 4 - Liste des Comptes avec un Solde négatif (Test de rentabilité)
SELECT [FullName] , [Balance]
FROM [dbo].[Customers] AS c
JOIN [dbo].[Accounts]  AS a
ON c.[CustomerID] = a.[CustomerID]
WHERE [Balance] < 0;

-- 1-Passer tout les noms des client en Majuscule 
BEGIN TRANSACTION -- cette commande est utiliser pour avoir un revers en cas d'erreur dans la modification 

UPDATE [dbo].[Customers]
SET [FullName] = UPPER([FullName]);
--pour valider définitivement on fait un COMMIT; et pour annuler la modif on fait un ROLLBACK; .
COMMIT;

-- 2 - Mettre la première lettre des pays en Majuscile 
BEGIN TRANSACTION;

UPDATE [dbo].[Customers]
SET [Country] = UPPER(LEFT([Country] ,1))+LOWER(SUBSTRING([Country] , 2, 6))
WHERE [CustomerID] IN (101 , 106);

COMMIT;

-- 3 - Remplacer le valeurs NULL par des valeur utilisable( cas des mails)
BEGIN TRANSACTION;

UPDATE [dbo].[Customers]
SET [Email] = 'non-renseigné@horizon.com'
WHERE [Email] IS NULL;

COMMIT;

-- 4 - Transformer les transaction négatives en valeurs positives
BEGIN TRANSACTION;

UPDATE [dbo].[Transactions]
SET [Amount] = ABS([Amount])
WHERE [TransactionID] IN ( 2 , 8);

COMMIT;

-- PHASE3 - Rapport 1 - Les Agences les plus rentables 
SELECT b.[Agency_Name] AS NOM_DES_AGENCES , b.[Region],
		SUM ( a.[Balance]) AS TotalSoldes
FROM [dbo].[Branches] AS b
JOIN [dbo].[Employees] AS e
ON b.[BranchID] = e.[BranchID]
JOIN [dbo].[Customers] AS c
ON e.[EmployeeID] = c.[EmployeeID]
JOIN [dbo].[Accounts] AS a
ON c.[CustomerID] = a.[CustomerID]
GROUP BY b.[Agency_Name], b.[Region]
ORDER BY TotalSoldes DESC;

-- 2 - Rapport 2 : Segmentation des Clients
SELECT [FullName], [CreditScore],
	CASE 
		WHEN [CreditScore] < 700 THEN 'A SURVEILLER'
		WHEN [CreditScore] BETWEEN 700 AND 800 THEN 'BON'
		ELSE 'EXCELLENT'
	END AS Categorie_score
FROM [dbo].[Customers];

-- 3 - La plus grosse transaction par client
WITH CustomerTransactionTotal AS (
	SELECT t.[TransactionID] , 
			c.[FullName],
			t.[Amount],
			RANK() OVER ( PARTITION BY t.[AccountID]  ORDER BY t.[Amount] DESC) AS Classement
	FROM [dbo].[Transactions] AS t
	JOIN [dbo].[Accounts] AS a
	ON t.[AccountID] = a.[AccountID]
	JOIN [dbo].[Customers] AS c
	ON a.[CustomerID] = c.[CustomerID]
	)
SELECT *
FROM  CustomerTransactionTotal 
WHERE Classement = 1;

SELECT AVG([CreditScore]) AS Score_CREDIT_Moyen
FROM [dbo].[Customers];