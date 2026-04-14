# HorizonBank_Project
<b><h2>🏦 Projet : "Horizon Banking Data Integrity & Insights"</h2></b><br>
Phase 1 : Ingestion et Schéma (Le socle)<br>
Avant d'analyser, il faut construire. On vas devoir créer l'architecture capable de recevoir nos données clients, comptes et transactions.<br>
<br>
Compétences visées : DDL (Data Definition Language), Types de données, Contraintes d'intégrité.<br>
<br>
Phase 2 : Data Cleaning & Standardisation (Le nettoyage)<br>
C'est ici que 80% du travail d'un analyste se passe. Les données brutes contiennent des doublons, des formats de dates incohérents et des valeurs nulles critiques.
<br>
Compétences visées : DML (UPDATE, DELETE), Fonctions de chaînes, Gestion des NULLs.
<br>
Phase 3 : Business Intelligence & Analyse (L'extraction)<br>
Le board de la banque veut des réponses : Qui sont nos clients les plus rentables ? Quel est le volume de risque ?
<br>
Compétences visées : Agrégations complexes (GROUP BY), Jointures (JOIN), CTE (Common Table Expressions).
<br>
Phase 4 : Optimisation & Sécurité (La déontologie)<br>
Un analyste assermenté doit garantir que les requêtes sont rapides et que les données sensibles sont protégées.
<br>
Compétences visées : Indexation, Vues (Views).
<br>
<b><h3>📋 LA MISSION : ÉTAPE 1 (Ingestion)</h3></b><br>
Pour commencer, nous devons monter l'infrastructure de test sur SSMS. Nous allons créer une base de données nommée HorizonBank_DB et d'y intégrer six tables spécifiques.
<br>
Attention : C'est à nous de définir les types de colonnes appropriés (INT, VARCHAR, DECIMAL, DATE, etc.) et les Clés Primaires (PK) et les clés secondaires (FK)
<br>
1. Table Branches (Les Agences)<br>
BranchID (PK)<br>

Nom_Agence, Ville, Region<br>

2. Table Employees (Les Conseillers)<br>
EmployeeID (PK)<br>

BranchID (FK vers Branches)<br>

Nom_Complet, Poste, Date_Embauche<br>

3. Table Customers (Les Clients)<br>
CustomerID (PK)<br>

EmployeeID (FK vers Employees - Chaque client a un conseiller attitré)<br>

Nom_Complet, Email, Telephone, Date_Naissance, Pays, Score_Credit<br>

4. Table Accounts (Les Comptes)<br>
AccountID (PK)<br>

CustomerID (FK vers Customers)<br>

Type_Compte (Courant, Épargne, etc.)<br>

Solde (Attention au type de donnée pour la monnaie !),

Date_Ouverture, Statut<br>

5. Table Transactions (Les Flux)<br>
TransactionID (PK)<br>

AccountID (FK vers Accounts)<br>

Date_Transaction, Montant, Type_Transaction

6. Table Loans (Les Prêts - Nouvelle table cruciale)<br>
LoanID (PK)<br>

CustomerID (FK vers Customers)<br>

Montant_Pret, Taux_Interet, Duree_Mois, Date_Debut, Statut_Pret
<br>
Livrable attendu pour cette tâche :<br>
Le script SQL complet (DDL) de création de ces tables. On va s'assurer que leses choix de types de données sont optimaux pour une banque internationale (notamment pour les montants financiers et la précision).
