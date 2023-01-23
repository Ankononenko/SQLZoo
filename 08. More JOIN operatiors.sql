/*
1962 movies
1. List the films where the yr is 1962 [Show id, title]
*/

SELECT id
	,title
FROM movie
WHERE yr = 1962

/*
When was Citizen Kane released?
2. Give year of 'Citizen Kane'.
*/

SELECT movie.yr
FROM movie
WHERE title = 'Citizen Kane'

/*
Star Trek movies
3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/

SELECT movie.id
	,movie.title
	,movie.yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr ASC

/*
id for actor Glenn Close
4. What id number does the actor 'Glenn Close' have?
*/

SELECT actor.id
FROM actor
WHERE NAME = 'Glenn Close'

/*
id for Casablanca
5. What is the id of the film 'Casablanca'
*/

SELECT movie.id
FROM movie
WHERE title = 'Casablanca'

/*
6. Obtain the cast list for 'Casablanca'.
what is a cast list?
*/

SELECT actor.NAME
FROM actor
INNER JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 27

/*
Alien cast list
7. Obtain the cast list for the film 'Alien'
*/

SELECT actor.NAME
FROM actor
INNER JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = (
		SELECT movie.id
		FROM movie
		WHERE movie.title = 'Alien'
		)

/*
Harrison Ford movies
8. List the films in which 'Harrison Ford' has appeared
*/

SELECT movie.title
FROM movie
WHERE movie.id IN (
		SELECT casting.movieid
		FROM casting
		WHERE casting.actorid = (
				SELECT actor.id
				FROM actor
				WHERE actor.NAME = 'Harrison Ford'
				)
		)

/*
Harrison Ford as a supporting actor
9. List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/

SELECT movie.title
FROM movie
WHERE movie.id IN (
		SELECT casting.movieid
		FROM casting
		WHERE casting.actorid = (
				SELECT actor.id
				FROM actor
				WHERE actor.NAME = 'Harrison Ford'
				)
			AND casting.ord != 1
		)

/*
Lead actors in 1962 movies
10. List the films together with the leading star for all 1962 films.
*/

SELECT movie.title
	,actor.NAME
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962
	AND casting.ord = 1

/*
Busy years for Rock Hudson
11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/

SELECT yr
	,COUNT(title)
FROM movie
INNER JOIN casting ON movie.id = movieid
INNER JOIN actor ON actorid = actor.id
WHERE NAME = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

/*
Lead actor in Julie Andrews movies
12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/

SELECT title
	,NAME
FROM movie
INNER JOIN casting x ON movie.id = movieid
INNER JOIN actor ON actor.id = actorid
WHERE ord = 1
	AND movieid IN (
		SELECT movieid
		FROM casting y
		INNER JOIN actor ON actor.id = actorid
		WHERE NAME = 'Julie Andrews'
		);

/*
Actors with 15 leading roles
13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/

SELECT actor.NAME
FROM actor
INNER JOIN casting ON actor.id = casting.actorid
WHERE casting.ord = 1
GROUP BY NAME
HAVING COUNT(actor.NAME) >= 15

/*
released in the year 1978
14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/

SELECT title
	,COUNT(actorid)
FROM movie
INNER JOIN casting ON movie.id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC
	,title

/*
with 'Art Garfunkel'
15. List all the people who have worked with 'Art Garfunkel'.
*/

SELECT NAME
FROM actor
INNER JOIN casting ON actor.id = actorid
WHERE movieid IN (
		SELECT id
		FROM movie
		WHERE title IN (
				SELECT title
				FROM movie
				INNER JOIN casting ON movie.id = movieid
				WHERE actorid IN (
						SELECT id
						FROM actor
						WHERE NAME = 'Art Garfunkel'
						)
				)
		)
	AND NAME != 'Art Garfunkel'
