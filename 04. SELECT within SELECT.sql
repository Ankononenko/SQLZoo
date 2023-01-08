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

/*
Percentages of Germany
5. Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
The format should be Name, Percentage.
*/

SELECT NAME
	,CONCAT (
		round(population / (
				SELECT population
				FROM world
				WHERE NAME = "Germany"
				) * 100)
		,"%"
		) AS percentage
FROM world
WHERE continent = "Europe"

/*
Bigger than every country in Europe
6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
*/

SELECT NAME
FROM world
WHERE gdp >= ALL (
		SELECT gdp
		FROM world
		WHERE continent = "Europe"
			AND gdp > 0
		)
	AND continent != "Europe"

/*
Largest in each continent
7. Find the largest country (by area) in each continent, show the continent, the name and the area:
*/

SELECT continent
	,NAME
	,area
FROM world x
WHERE area >= ALL (
		SELECT area
		FROM world y
		WHERE y.continent = x.continent
			AND area > 0
		)

/*
First country of each continent (alphabetically)
8. List each continent and the name of the country that comes first alphabetically.
*/

SELECT continent
	,NAME
FROM world x
WHERE NAME <= ALL (
		SELECT NAME
		FROM world y
		WHERE x.continent = y.continent
		)

/*
Difficult Questions That Utilize Techniques Not Covered In Prior Sections
9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
*/

SELECT NAME
	,continent
	,population
FROM world x
WHERE 25000000 >= ALL (
		SELECT population
		FROM world y
		WHERE x.continent = y.continent
		)

/*
Three time bigger
10. Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
*/

SELECT NAME
	,continent
FROM world x
WHERE population > ALL (
		SELECT population * 3
		FROM world y
		WHERE x.continent = y.continent
			AND population > 0
			AND y.NAME != x.NAME
		)
