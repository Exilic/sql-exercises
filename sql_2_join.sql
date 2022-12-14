# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first

SELECT *
FROM City
WHERE Name LIKE 'ping%'
ORDER BY Population ASC;

#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first

SELECT *
FROM City
WHERE Name LIKE 'ran%'
ORDER BY Population DESC;

#
# 3: Count all cities

SELECT COUNT(ID)
FROM City;

#
# 4: Get the average population of all cities

SELECT AVG(Population)
FROM City;

#
# 5: Get the biggest population found in any of the cities

SELECT MAX(Population)
FROM City;

#
# 6: Get the smallest population found in any of the cities

SELECT MIN(Population)
FROM City;

#
# 7: Sum the population of all cities with a population below 10000

SELECT SUM(Population)
FROM City
WHERE Population < 10000; 

#
# 8: Count the cities with the countrycodes MOZ and VNM

SELECT COUNT(ID)
FROM City
WHERE CountryCode IN ('MOZ', 'VNM'); 

#
# 9: Get individual count of cities for the countrycodes MOZ and VNM

SELECT CountryCode, 
	COUNT(ID)
FROM City
GROUP BY CountryCode
HAVING CountryCode IN ('MOZ', 'VNM'); 

#
# 10: Get average population of cities in MOZ and VNM

SELECT CountryCode, 
	AVG(Population)
FROM City
GROUP BY CountryCode
HAVING CountryCode IN ('MOZ', 'VNM'); 

#
# 11: Get the countrycodes with more than 200 cities

SELECT CountryCode
FROM City
GROUP BY CountryCode
HAVING COUNT(ID)>200;

#
# 12: Get the countrycodes with more than 200 cities ordered by city count

SELECT CountryCode
FROM City
GROUP BY CountryCode
HAVING COUNT(ID)>200 
ORDER BY COUNT(ID) DESC;


#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?

SELECT CountryLanguage.Language
FROM City
INNER JOIN CountryLanguage ON City.CountryCode = CountryLanguage.CountryCode
WHERE Population BETWEEN 400 AND 500;

#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

SELECT City.Name, CountryLanguage.Language
FROM City
INNER JOIN CountryLanguage ON City.CountryCode = CountryLanguage.CountryCode
WHERE Population BETWEEN 500 AND 600;

#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)

SELECT City.Name
FROM City
WHERE CountryCode IN (
	SELECT CountryCode
    FROM City
    WHERE Population = 122199);

#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)

SELECT City.Name 
FROM City
WHERE Population != 122199 AND CountryCode IN (
	SELECT CountryCode
    FROM City
    WHERE Population = 122199);

#
# 17: What are the city names in the country where Luanda is capital?

SELECT City.Name 
FROM City
WHERE CountryCode IN (
	SELECT CountryCode
    FROM City
    INNER JOIN Country
    ON City.ID = Country.Capital
    WHERE City.Name = 'Luanda');

#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT City.Name
FROM City
INNER JOIN Country
ON Country.Capital = City.ID
WHERE Region IN (
	SELECT Region
    FROM Country
    INNER JOIN City
    ON City.CountryCode = Country.Code
    WHERE City.Name = 'Yaren');

#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga

SELECT DISTINCT Language
FROM CountryLanguage
INNER JOIN Country
ON Country.Code = CountryLanguage.CountryCode
WHERE Region IN (
	SELECT Region
    FROM Country
    INNER JOIN City
    ON City.CountryCode = Country.Code
    WHERE City.Name = 'Riga');

#
# 20: Get the name of the most populous city

SELECT City.Name
FROM City
WHERE Population IN (SELECT MAX(Population)
	FROM City);

