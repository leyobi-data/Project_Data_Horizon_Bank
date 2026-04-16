# HorizonBank_Project
<b><h2>🏦 Projet : "Horizon Banking Data Integrity & Insights"</h2></b><br>
<b><h3>📝 Présentation du projet</h3></b><br>
Ce projet simule le cycle complet de travail d'un Analyste de Données au sein d'une institution financière internationale. L'objectif était de transformer des données bancaires brutes et fragmentées en un outil de pilotage interactif permettant de surveiller la santé financière de la banque et le profil de risque des clients.<br>

<b><h3>🛠️ Stack Technique</h4></b>
Base de données : SQL Server (MS SQL)<br>

Langages : T-SQL (DDL, DML, DQL)<br>

Visualisation : Microsoft Excel (Tableaux Croisés Dynamiques, Power Pivot, Segments)<br>
<br>
<b><h3>⚙️ Étapes de réalisation</h4></b><br>
<b><h4>1. Architecture & Ingestion (SQL)</h4></b><br>
Conception d'un schéma relationnel complet comprenant 6 tables interconnectées :<br>

Agences & Employés : Gestion de la structure organisationnelle.<br>

Clients & Comptes : Suivi des profils et des soldes bancaires.<br>

Transactions & Prêts : Analyse des flux monétaires et des engagements financiers.<br>

Compétences : Clés primaires/étrangères, contraintes d'intégrité, types de données monétaires précis.<br>
<br>
<b><h4>2. Nettoyage & Standardisation (Data Cleaning)</h4></b><br>
Traitement des anomalies critiques pour garantir la fiabilité des analyses :<br>

Normalisation des noms et des pays (gestion de la casse et des formats).<br>

Traitement des valeurs nulles (Emails, coordonnées).<br>

Standardisation des flux financiers (Conversion des montants négatifs en valeurs absolues via ABS()).<br>

Compétences : Manipulation de chaînes de caractères, Transactions SQL (COMMIT/ROLLBACK).<br>

<b></h4>3. Analyse & Intelligence d'Affaires</h4></b><br>
Extraction d'indicateurs clés de performance (KPIs) via des requêtes avancées :<br>

Segmentation Clients : Utilisation de clauses CASE WHEN pour classer les clients selon leur score de crédit.<br>

Top Transactions : Mise en œuvre de CTE (Common Table Expressions) et de fonctions de fenêtrage (RANK) pour isoler les plus gros mouvements par compte.<br>

Performance Régionale : Agrégation des soldes par zone géographique.<br>

<b><h4>4. Visualisation (Dashboard Excel)</h4></b><br>
Création d'un tableau de bord interactif comprenant :<br>

Indicateurs Flash : Solde total, Score de crédit moyen, Taux de clients à risque.<br>

Analyse de Répartition : Segmentation des scores de crédit via un graphique en anneau (Donut Chart).<br>

Analyse Comparative : Volume des soldes par région et top transactions clients.<br>

Interactivité : Intégration de segments (Slicers) pour un filtrage dynamique par région et par nom.<br>
<br>
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
<b><h3>📋 ÉTAPE 1 (Ingestion)</h3></b><br>
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
Le script SQL complet (DDL) de création de ces tables. On va s'assurer que leses choix de types de données sont optimaux pour une banque internationale (notamment pour les montants financiers et la précision).<br>
  <p align='center'>
    <img src="Figure_SQL_INSERT.png" alt="CAPTURE SSMS pour l'insertion des données" width="700">
  </p>
<br>
<b><h3> 1-📋 Diagnostic Expert (Phase 2) </h3></b><br>
Maintenant que nous avons de la donnée, le Board veut un "Data Quality Report". Cette partie est juste une découverte des données . Savoir quel sont les valeurs des colonnes qu'on peut nettoyer pour rendre les fichiers exploitables .Nous allons utiliser les connaissances (SELECT, JOIN, WHERE) pour sortir les listes suivantes:
<br>
Le test de la casse (Case Sensitivity) : Trouvez tous les clients dont le FullName comporte des minuscules <br>
  <p align='center'>
    <img src="Erreur_Noms_Minuscule.png" alt="CAPTURE DES ERREURS SUR LES NOMS" Width="700>
  </p>
<br>
Le test des doublons : Identification des noms de clients qui apparaissent plus d'une fois dans la table (même s'ils ont un CustomerID différent).<br>
      <p align='center'>
        <img src="Apparition_client.png" width="600">
      </p>
<br>
Le test de cohérence géographique :
Affichez les clients dont le pays n'est pas écrit avec la première lettre en Majuscule seulement (ex: 'france').<br>
  <p align='center'>
      <img scr="erreur_nom_ville.png" alt="CAPTURE DES ERREURS SUR LE NOM DES VILLES" width="600">
  </p>
<br>
Le test de rentabilité (Accounts) :
Liste les comptes qui ont un solde (Balance) négatif.<br>
  <p align='center'>
    <img src="solde_negatif.png" alt="CAPTURE DES CLIENT AYANT UN SOLDE NEGATIF" width="600">
  </p>
  <br>
 <b><h3>2 📋 PHASE 2.2 : Le Nettoyage (Data Remediation)</h3></b><br>
 Dans cete partie on va faire la mise jours des nouvelles modification pour corriger les erreurs de saisies qu'on a constaté plus haut . Cella nous permettre de mieux manipuler les données données lors de nos calculs et de nos transformations .<br>
 <br>
 --Normalisation des Noms des clients .On va opter de mettre tout les noms des client en MAJUSCULE.<br>
 --On constate que certains noms de pays n'ont pas le mème standart que les autre , on va mettre les 2 colonnes dont les la prière lettre des noms des pays sont en MINUSCULE  en MAJUSCULE de la table CLIENT .<br>
 En faisant un "SELECT" on observe bien le changement <br>
   <p align='center'>
     <img src="Update_Name_Country.png" width="600">
   </p>
  <br>
--Pour nos opérations de calculs , filtres et recherches il est important de donner aux valeur "NULL" une valeur utilisable pour que les fonctions puisse exécuter les commandes . Dans ce cas précis aux cellules des mails ayant des valeurs on va leur donner la valeur "non-renseigner@horizon.com" pour indiquer aux employés que ce n'est pas une valeur utilisable . En faisant un 3SELECT" le redu de notre script donne ceci:<br>
  <p align='center'>
    <img src="Email.png" width="600">
  </p>
  <br>
-- Les valeurs negatives présentes dans la balance des transaction veulent surement un retrait mais on a déjà une collone qui nous donne le type de transactions il ne sert à rien de garder les (-) car cela peut nous faucher dans nos calculs . L'excution du code et SELECT nous donne cette image:<br>
  <p align='center'>
    <img src="Valeur_negative.png" width="600">
  </p>
<br>
<b><h2>📊 PHASE 3 : Business Intelligence & Analyse (L'Extraction)</h2></b><br>
Danc cette partie nous allons procéder à la l'analyse des données à disposition pour mettre en évidence les KPI. Cette partie se fera en 3 RAPPORTS :<br>
<br>
<b><h3>Rapport 1 : Performance des Agences</h3></b><br>
La direction veut savoir la region qui rapporte le plus d'argent . L'objectif de cette partie sera de donner le <b>CHIFFRE D'AFFAIRE (CA)</b> de toutes les Agences de la banque HORIZON_BANK afin d'en deceler les plus rentables .<br>
La Performance des Agence se calcule en fonction des soldes client appartenant à ces Agences et ainsi la vu de SSMS nous donne le classement de celle ci<br>
  <p align='center'>
    <img src="Performance_Agences.png" width="700">
  </p>
  <br>
  ON va tranformer ce tableau en données exploitable a fin de mieux visualiser ces chiffres pour que le BOARD puisse mieux comprendre et pour cela on aura besoin d'un outil de visualisation comme EXCEL . <br>
Dans sun environement bancaire ou les données changent constament, ON va faire une laison EXCEL --> SQL SERVER pour que celle ci se mettent à jours de façon dynamique pour permettre une visualisation en temps réel.Cette figure montre d'ailleur le chargement <br>
  <p align='center'>
    <img src="LiaisonSQL_EXCEL.png" width="600">
  </p>
  <br>
On va juste renommer les champs avec <b>POWER QUERY</b> avant de sles charger sur la feuille calcul <br>
  <p align='center'>
    <img src="PowerQuery_rename.png" alt="600">
  </p>
  <br>
ON obtient le tableau croisé dynamique accompagné de son graphique <br>
  <p align='center'>
    <img src="Solde_T_Region.png" width="600">
  </p>
  <br>
Cette analyse met en lumière une repartition géographique très inégale des fonds. La <b>Colombie-Britanique</b> domine largement le porte feuille avec près de 9,8 Millions $,réprésentant la vaste majorité des actifs. A l'opposé, la region ile-de-france présente un solde négatif , signalant des comptes débiteurs qui pourraient nécessiter une surveillance particulière en matière d'intégrité des données ou de gestion des risques.<br>
<br>
<b><h3>Rapport 2 : Segmentation des Clients</h3></b><br>
Le BOARD veut par le biais de la direction marketing veut catégotiser les clients selon leut "CréditScore" . Pour ce faire , on va afficher les nom des client tels :<br>
* Si Score > 800 : 'Excellent'<br>
* Si Score entre 700 et 800 : 'Bon'<br>
* Si Score < 700 : 'À surveiller'<br>
Dans cette figure vous avez toutes les catégories de client en fonction des scores credits <br>
  <p align='center'>
    <img src="Credit_score.png" width="600">
  </p>
  <br>
  Par le même proceder que le précédent , on a pu ressortir un TCD représentant les catégories de score en fonction du score crédit de chaque client <br>
    <p align='center'>
      <img src="graph_categorie.png" width="600">
    </p>
    <br>
Ce graphique présente la segmention des clients par catégorie de score de crédit? On observe que 60% du portefeuille bénéficie d'un score BON , ce qui indique une base de clients majoritairement stable. Tputefois 20% de clients à "surveiller", constituant un segment à risque modéré qui nécessite une attention particulière pour prévenir d'éventuels défauts de paiement.
  <br>
  <b><h3>Rapport 3 : Top Transactions par Client</h3></b><br>
  La direction Marketing demande les plus grosses transaction de chaque client . Pour ce faire on a utiliser un des concept du code SQL pour arriver à ce rendu . Vu que l'analyse est centré sur le point de vu <b>Client</b> , cette partie sert à indentifier et catégoriser  les "gros mouvements clients" ou les client les clients avec les plus "gros mouvements" 
    <p align='center'>
      <img scr="Rang_Transaction.png" width="600">
    </p>
    <br>
Après implémention et tranformation sur l'outil EXCEL on ce graphique qui montre les transactions les plus elevées par client <br>
  <p align='center'>
    <img src="Transaction_Client.png" width="600">
  </p>
  <br>
  Ce graphique présente la transaction maximal enregistrée pour chaque client. On observe une forte disparité entre les comptes, avec un <b>50 000</b> pour le client BRUCE WAYNE, tandis que les autres clients présentent des transactions plafonnées à des niveaux nettement inférieurs, suggérant des profils d'utilisateurs differents .
<br>
<b><h2> DASHBOARD</h2></b><br>
  <p align='center'>
    <img src="Dashbord.png" width="600">
  </p>
  <br>
  
<b><h3></h3></b>📈 Résultats clés</h3></b><br>
Fiabilité des données : 100% des doublons et erreurs de saisie ont été corrigés.<br>

Aide à la décision : Identification visuelle immédiate des 20% de clients à risque nécessitant une surveillance accrue.

Optimisation : Réduction du temps de reporting via des requêtes SQL automatisées.

  





 
