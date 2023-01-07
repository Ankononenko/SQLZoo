/*
Bigger than Russia
1. List each country name where the population is larger than that of 'Russia'.
*/

SELECT NAME
FROM world
WHERE population > (
		SELECT population
		FROM world
		WHERE NAME = "Russia"
		)
    
Richer than UK
2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
    
SELECT NAME
FROM world
WHERE gdp / population > (
		SELECT gdp / population
		FROM world
		WHERE NAME = "United Kingdom"
		)
	AND continent = "Europe"

