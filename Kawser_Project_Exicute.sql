USE master;
GO
USE CricketTrunamentDB;
GO
/**Store Procidure  & Find out the all match of Specipic Team*********************************/
EXEC sp_TeamMatch 'Westindies';
GO
--A VIEW FIND ALL MATCH INFORMATION
SELECT * FROM vw_AllMatch;
GO
--A function find out the lower capacity. 
SELECT * FROM dbo.fn_vanueCapacity(30000);
GO
-- Delete vanuecopy  & insert into vanueachive for chack trigger
DELETE VanueCopy WHERE VanueID = 2
Go
--Capacity of all vanue with agrigate function.
SELECT SUM(Capacity) AS [Total Capacity of all vanue] FROM Vanue; 

GO

/*****Use Like Operator*************************************************/

SELECT * FROM Vanue
WHERE VanueName LIKE '%B%';

GO

/*Use Between Operator****************************************************/

SELECT  
		
		Vanue.VanueName,
		Vanue.Capacity,
		Vanue.VanueLocation
		
FROM  Vanue 
WHERE Capacity BETWEEN 22000 AND 25000;

GO

/***** Cross Join Exaample*************************************************/

SELECT Team1.TeamName, Team2.TeamName
FROM Team1 CROSS JOIN Team2;


GO
--All index information from CricketTrunamentDB Database.
EXEC sp_All_Index;

GO
/*USE The CAST & CONVERT Function*/

SELECT	Matches.MatchID,
		 CONVERT(DATE, TimeOfMatch ) AS Date, 
		CAST(TimeOfMatch AS TIME) AS Time
	FROM Matches;

GO
--using case function
SELECT	Vanue.VanueName,
		Vanue.Capacity ,
		CASE 
			WHEN Vanue.Capacity < 20000 THEN 'Lowest Capacity'
			WHEN Vanue.Capacity < 35000 THEN 'Medium Capacity'
			WHEN Vanue.Capacity < 40000 THEN 'Highest Capacity'
			ELSE 'Highest capacity in the world'
			END AS Remark
	FROM Vanue;

GO
--Using Rank
SELECT	Vanue.VanueName,
		Vanue.Capacity ,
		RANK() OVER (ORDER BY Vanue.Capacity DESC) AS Rank
		FROM Vanue;


GO
--Using try catch
BEGIN TRY
    INSERT Vanue(VanueName, Capacity)
    VALUES ('New Stadium', 'tweenty thousand');
    PRINT 'SUCCESS: Record was inserted.';
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.';
    PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) 
        + ': ' + ERROR_MESSAGE();
END CATCH;

GO
--Using Update 
UPDATE Matches
	SET TimeOfMatch = '12-07-2019'
	WHERE MatchID = 1;

GO
--Using delete
DELETE FROM Matches 
WHERE MatchID =3;

GO

