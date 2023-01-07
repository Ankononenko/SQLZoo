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

/*
Richer than UK
2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
*/
    
SELECT NAME
FROM world
WHERE gdp / population > (
		SELECT gdp / population
		FROM world
		WHERE NAME = "United Kingdom"
		)
	AND continent = "Europe"

/*
Neighbours of Argentina and Australia
3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
*/

SELECT NAME
	,continent
FROM world
WHERE continent IN (
		SELECT continent
		FROM world
		WHERE NAME = "Argentina"
			OR NAME = "Australia"
		)
ORDER BY NAME

/*
Between United Kingdom and Germany
4. Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
*/

SELECT NAME
	,population
FROM world
WHERE population > (
		SELECT population
		FROM world
		WHERE NAME = "United Kingdom"
		)
	AND population < (
		SELECT population
		FROM world
		WHERE NAME = "Germany"
		)

