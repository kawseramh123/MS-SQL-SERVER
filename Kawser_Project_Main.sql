USE master;
GO
IF DB_ID ('CricketTrunamentDB') IS NOT NULL
DROP DATABASE CricketTrunamentDB;
GO
CREATE DATABASE CricketTrunamentDB
ON (
  NAME = CricketTrunamentDB_data,
  FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CricketTrunamentDB_data.mdf',
  SIZE = 10,
  MAXSIZE = 50,
  FILEGROWTH = 5
)
LOG ON (
   NAME = CricketTrunamentDB_log,
   FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CricketTrunamentDB_log.ldf',
   SIZE = 5MB,
   MAXSIZE = 25MB,
   FILEGROWTH = 5MB
);
GO
USE CricketTrunamentDB;
GO

CREATE TABLE Country(
      CountryID  INT IDENTITY PRIMARY KEY,
	  CountryName VARCHAR(50));
GO

CREATE TABLE Team1 (
       Team1ID  INT IDENTITY PRIMARY KEY,
	   TeamName  VARCHAR(50));
GO

CREATE TABLE Team2 (
       Team2ID  INT IDENTITY PRIMARY KEY,
	   TeamName  VARCHAR(50));
GO
CREATE TABLE Vanue(
     VanueID  INT IDENTITY PRIMARY KEY,
	 VanueName VARCHAR(200),
	 Capacity INT,
	 VanueLocation VARCHAR(80),
	 CountryID INT REFERENCES Country(CountryID));
GO
CREATE TABLE Matches(
     MatchID INT IDENTITY PRIMARY KEY,
	 Team1ID INT REFERENCES Team1(Team1ID),
	 Team2ID  INT REFERENCES Team2(Team2ID),
	 VanueID INT REFERENCES Vanue(VanueID),
	 TimeOfMatch DATETIME2
	 );
GO
SET DATEFORMAT dmy; 

GO
INSERT INTO Country VALUES ('Bangladesh'),('India'),('Srilanka'),('Pakistan');
GO
INSERT INTO Team1 VALUES ('Bangladesh'),('India'),('Srilanka'),('Pakistan'),
                         ('Afganistan'),('Austrelia'),('England'),('RSA'),
						 ('Newzeland'),('Westindies');
GO
INSERT INTO Team2 VALUES ('Bangladesh'),('India'),('Srilanka'),('Pakistan'),
                         ('Afganistan'),('Austrelia'),('England'),('RSA'),
						 ('Newzeland'),('Westindies');
GO
INSERT INTO Vanue VALUES ('Sher-e-Bangla National Cricket Stadium', 25000, 'Dhaka', 1),
                         ('Zahur Ahmed Chowdhury Stadium', 22000, 'Chittagong', 1),
						 ('Shaheed Chandu Stadium', 15000, 'Bogra', 1),
						 ('Feroz Shah Kotla', 35000, 'New Delhi', 2),
						 ('Eden Gardens', 39000, 'Kolkata', 2),
						 ('Nehru Stadium', 25000, 'Kochi', 2),
						 ('Colombo Cricket Club Ground', 30000, 'Colombo', 3),
						 ('Galle International Stadium', 37000, 'Galle', 3),
						 ('Mahinda Rajapaksa International Cricket Stadium', 35000, 'Hambantota', 3),
						 ('	Jinnah Sport Stadium', 48000, 'Islamabad', 4),
						 ('Karachi National Stadium', 34000, 'Karachi', 4),
						 ('Multan Cricket Stadium', 30000, 'Multan', 4);
GO
INSERT INTO Matches VALUES (1,2,1, '01-06-2019 12:00:00'), (1,3,2, '02-06-2019 12:00:00'),(1,4,3, '03-06-2019 12:00:00'),(1,5,4, '04-06-2019 12:00:00'),
							(1,6,1, '05-06-2019 12:00:00'),(1,7,2, '06-06-2019 12:00:00'),(1,8,3, '07-06-2019 12:00:00'),(1,9,4, '08-06-2019 12:00:00'),
							(1,10,5, '09-06-2019 12:00:00'),(2,3,6, '02-06-2019 12:00:00'),(2,4,7, '10-06-2019 12:00:00'),(2,5,8, '11-06-2019 12:00:00'),
							(2,6,9, '12-06-2019 12:00:00'),(2,7,10,'13-06-2019 12:00:00'),(2,8,11, '14-06-2019 12:00:00'),(2,9,1, '15-06-2019 12:00:00'),
							(2,10,2, '16-06-2019 12:00:00'),(3,4,3, '17-06-2019 12:00:00'),(3,5,4, '09-06-2019 12:00:00'),(3,6,5, '10-06-2019 12:00:00'),
							(3,7,6, '11-06-2019 12:00:00'),(3,8,7, '18-06-2019 12:00:00'),(3,9,8, '19-06-2019 12:00:00'),(3,10,9, '20-06-2019 12:00:00'),
							(4,5,10, '21-06-2019 12:00:00'),(4,6,11, '22-06-2019 12:00:00'),(4,7,1, '23-06-2019 12:00:00'),(4,8,2, '24-06-2019 12:00:00'),
							(4,9,3, '25-06-2019 12:00:00'),(4,10,4, '26-06-2019 12:00:00'),(5,6,7, '27-06-2019 12:00:00'),(5,7,8, '28-06-2019 12:00:00'),
							(5,8,9, '29-06-2019 12:00:00'),(5,9,10, '30-06-2019 12:00:00'),(5,10,11, '01-07-2019 12:00:00'),(6,7,1, '01-07-2019 12:00:00'),
							(6,8,2, '02-07-2019 12:00:00'),(6,9,3, '03-07-2019 12:00:00'),(6,10,4, '04-07-2019 12:00:00'),(7,8,5, '01-07-2019 12:00:00'),
							(7,9,6, '01-06-2019 12:00:00'),(7,10,7, '02-06-2019 12:00:00'),(8,9,8, '03-06-2019 12:00:00'),(8,10,9, '05-07-2019 12:00:00'),
							(9,10,10, '23-06-2019 12:00:00');

GO
CREATE TABLE VanueAchive(
     VanueID  INT IDENTITY PRIMARY KEY,
	 VanueName VARCHAR(200),
	 Capacity INT,
	 VanueLocation VARCHAR(80),
	 CountryID INT REFERENCES Country(CountryID));
GO

SELECT * INTO VanueCopy FROM Vanue;
GO
/**1. Create Store Procidure  & Find out the Specipic Team************/

CREATE PROC sp_TeamMatch
@TeamName VARCHAR(50)
AS
SELECT	Matches.MatchID,
		Team1.TeamName + ' VS ' + Team2.TeamName AS Teams,
		Vanue.VanueName,
		Vanue.Capacity,
		Vanue.VanueLocation,
		Country.CountryName,
		Matches.TimeOfMatch
FROM Matches JOIN Team1 ON Team1.Team1ID = Matches.Team1ID
			JOIN Team2 ON Team2.Team2ID = Matches.Team2ID
			JOIN Vanue ON Vanue.VanueID = Matches.VanueID
			JOIN Country ON Country.CountryID = Vanue.CountryID
WHERE Team1.TeamName = @TeamName OR Team2.TeamName  = @TeamName
ORDER BY MatchID;
GO

---create non clustered index
CREATE INDEX IX_Team1 ON Team1(TeamName);
CREATE INDEX IX_Team2 ON Team2(TeamName);
GO
CREATE CLUSTERED INDEX IX_Vanue ON VanueCopy(VanueName ASC);
GO
--CREATE A VIEW FIND ALL MATCH INFORMATION
CREATE VIEW vw_AllMatch
AS
SELECT	Matches.MatchID,
		Team1.TeamName + ' VS ' + Team2.TeamName AS Teams,
		Vanue.VanueName,
		Vanue.Capacity,
		Vanue.VanueLocation,
		Country.CountryName,
		Matches.TimeOfMatch
FROM Matches JOIN Team1 ON Team1.Team1ID = Matches.Team1ID
			JOIN Team2 ON Team2.Team2ID = Matches.Team2ID
			JOIN Vanue ON Vanue.VanueID = Matches.VanueID
			JOIN Country ON Country.CountryID = Vanue.CountryID
GO
--Create a function find out the lower capacity.
CREATE FUNCTION fn_vanueCapacity
(@Capacity int =0)
RETURNS TABLE
AS
RETURN (
		SELECT	
		Matches.MatchID,
		Team1.TeamName + ' VS ' + Team2.TeamName AS Teams,
		Vanue.VanueName,
		Vanue.Capacity,
		Vanue.VanueLocation,
		Country.CountryName,
		Matches.TimeOfMatch
FROM Matches JOIN Team1 ON Team1.Team1ID = Matches.Team1ID
			JOIN Team2 ON Team2.Team2ID = Matches.Team2ID
			JOIN Vanue ON Vanue.VanueID = Matches.VanueID
			JOIN Country ON Country.CountryID = Vanue.CountryID
WHERE Vanue.Capacity < @Capacity);
GO
--Create a trigger
CREATE TRIGGER tr_VanueDelete
ON VanueCopy
AFTER DELETE 
AS 
INSERT INTO VanueAchive(	
	 VanueName,
	 Capacity ,
	 VanueLocation,
	 CountryID)

		SELECT VanueName,
	 Capacity ,
	 VanueLocation,
	 CountryID FROM deleted;
SELECT VanueName,
	 Capacity ,
	 VanueLocation,
	 CountryID FROM VanueAchive WHERE VanueID = @@IDENTITY;
GO
--Create view by including index information *******************************
CREATE PROC sp_All_Index
AS
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
	 t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id;

	 GO
	
	 PRINT 'Scripts successfully executed';