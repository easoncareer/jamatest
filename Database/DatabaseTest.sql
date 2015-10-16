-- All queries written here may have issues since there is no database I could test the script with.

-- A. Write a query that will show the name of all of the clients who are “L” that have a feature called “SpaceshipPlugin”.
	SELECT Clients.ClientName 
	FROM ClienFeatures 
		JOIN Clients
			ON Clients.ClientId = ClientFeatures.ClientId
		JOIN Features
			ON Features.FeatureId = ClientFeatures.FeatureId
	WHERE Clients.ClientSize = 'L'

-- B. Write a query that will show how many of each S,M, and L clients exist in the system. 
	SELECT Clients.ClientSize, COUNT(Clients.ClientSize)
	FROM Clients
	GROUP BY Clients.ClientSize

-- C. Write a query that will show the address of the client named “XYZ Inc”. 
	-- Assuming there is a column "ClientAddress" in table Clients
	SELECT Clients.ClientAddress
	FROM Clients
	WHERE Clients.ClientName = 'XYZ Inc'

-- D. Write a query that will show the top 10 clients of feature called “JetBicycle” 
	SELECT TOP 10 Clients.ClientName 
	FROM ClienFeatures 
		JOIN Clients
			ON Clients.ClientId = ClientFeatures.ClientId
		JOIN Features
			ON Features.FeatureId = ClientFeatures.FeatureId
	WHERE Features.FeatureName = 'JetBicycle'


-- E. Write a query that will show all the features added in 2013 
	SELECT Features.FeatureId, Features.FeatureName, Features.FeatureAddedDate
	FROM Features
	WHERE YEAR(Features.FeatureAddedDate) = 2013

-- F. Write a SQL script to find and remove any duplicate FeatureNames
	-- 1. Update FeatureId in ClientFeatures table to avoid and foreign key problem.
	UPDATE ClientFeatures
	SET ClientFeatures.FeatureId = FeaturesNewID.NewID
	FROM ClientFeatures
		LEFT OUTER JOIN
		(
			SELECT Features.FeatureId , 
				   Features.FeatureName,
				   KeepRows.FeatureId as NewID,
			FROM Features
				LEFT OUTER JOIN (
					SELECT MIN(FeatureId) as FeatureId, FeatureName
					FROM Features 
					GROUP BY FeatureName
				) as KeepRows 
					ON MyTable.FeatureName = KeepRows.FeatureName
			WHERE KeepRows.FeatureId IS NULL
		) as FeaturesNewID
			ON ClientFeatures.FeatureId = FeaturesNewID.FeatureId
	WHERE FeaturesNewID.FeatureId <> FeaturesNewID.NewID

	-- 2. Remove duplicates in Features
	DELETE Features 
	FROM Features
		LEFT OUTER JOIN (
			SELECT MIN(FeatureId) as FeatureId, FeatureName
			FROM Features 
			GROUP BY FeatureName
		) as KeepRows 
			ON MyTable.FeatureId = KeepRows.FeatureId
	WHERE KeepRows.FeatureId IS NULL