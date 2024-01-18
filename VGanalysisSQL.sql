#Data Overview:


#Counts records in database
select count(*) from vgsales v 

#Checks columns of the table
DESCRIBE vgsales;

#Finds unique values
SELECT DISTINCT platform
FROM vgsales v ;

SELECT DISTINCT genre
FROM vgsales v ;

SELECT DISTINCT Publisher 
FROM vgsales v ;

#This query retrieves the sale columns from the "vgsales" table, replacing any null values with 0.
SELECT
    COALESCE(NA_sales, 0) AS NA_sales,
    COALESCE(EU_Sales, 0) AS EU_Sales,
    COALESCE(JP_Sales, 0) AS JP_Sales,
    COALESCE(Other_Sales, 0) AS Other_Sales,
    COALESCE(Total_Sales, 0) AS Total_Sales
FROM vgsales;


#Distribution Analysis:

#Checks total sales milions per region and total 
select 
	Round(SUM(NA_Sales),2) as 'North America total sales',
	round(SUM(EU_Sales),2) as 'Europe total sales',
	round(SUM(JP_Sales),2) as 'Japan total sales',
	round(SUM(Other_Sales),2) as 'Other countries total sales',
	round(SUM(Total_Sales),2) as 'Total sales'
from vgsales v 

#Genre Patterns:

#Sales Comparison between Genres:
SELECT Genre, 
			SUM(NA_Sales) AS NA_Sales, 
			SUM(EU_Sales) AS EU_Sales, 
			SUM(JP_Sales) AS JP_Sales, 
			SUM(Other_Sales) AS Other_Sales, 
			SUM(Total_Sales) AS Total_Sales
FROM vgsales
GROUP BY Genre
ORDER BY Total_Sales DESC;


#Top genres by number of games released:
SELECT Genre, COUNT(*) AS Games_Count
FROM vgsales
GROUP BY Genre
ORDER BY Games_Count DESC;


#Platform Performance:

SELECT Platform , 
			SUM(NA_Sales) AS NA_Sales, 
			SUM(EU_Sales) AS EU_Sales, 
			SUM(JP_Sales) AS JP_Sales, 
			SUM(Other_Sales) AS Other_Sales, 
			SUM(Total_Sales) AS Total_Sales
FROM vgsales
GROUP BY Platform 
ORDER BY Total_Sales DESC;

#Top games:
SELECT Name, 
			SUM(NA_Sales) AS NA_Sales, 
			SUM(EU_Sales) AS EU_Sales, 
			SUM(JP_Sales) AS JP_Sales, 
			SUM(Other_Sales) AS Other_Sales, 
			SUM(Total_Sales) AS Total_Sales
FROM vgsales
GROUP BY Name  
ORDER BY Total_Sales DESC;

#Top 3 games per genre
SELECT Genre, Title, Total_Sales
FROM (
    SELECT Genre, Title, Total_Sales,
           ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY Total_Sales DESC) AS row_num
    FROM vgsales
) ranked_games
WHERE row_num <= 3;


#Top 1 game per platform
SELECT Platform, Name, Total_Sales
FROM (
    SELECT Platform, NAme, Total_Sales,
           ROW_NUMBER() OVER (PARTITION BY Platform ORDER BY Total_Sales DESC) AS row_num
    FROM vgsales
) ranked_games
WHERE row_num <= 1;

#Publisher Analysis:
SELECT Publisher  , 
			SUM(NA_Sales) AS NA_Sales, 
			SUM(EU_Sales) AS EU_Sales, 
			SUM(JP_Sales) AS JP_Sales, 
			SUM(Other_Sales) AS Other_Sales, 
			SUM(Total_Sales) AS Total_Sales
FROM vgsales
GROUP BY Publisher 
ORDER BY Total_Sales DESC;




