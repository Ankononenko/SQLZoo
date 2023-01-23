/*
1. Modify the example to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
*/

SELECT goal.matchid
	,goal.player
FROM goal
WHERE goal.teamid = 'GER'

/*
2. Show id, stadium, team1, team2 for just game 1012
*/

SELECT id
	,stadium
	,team1
	,team2
FROM game
WHERE id = 1012

/*
3. Modify it to show the player, teamid, stadium and mdate for every German goal.
*/

SELECT goal.player
	,goal.teamid
	,game.stadium
	,game.mdate
FROM game
INNER JOIN goal ON (goal.matchid = game.id)
WHERE goal.teamid = 'GER'

/*
4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
*/

SELECT game.team1
	,game.team2
	,goal.player
FROM game
INNER JOIN goal ON (goal.matchid = game.id)
WHERE goal.player LIKE 'Mario%'

/*
5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/

SELECT goal.player
	,goal.teamid
	,eteam.coach
	,goal.gtime
FROM goal
INNER JOIN eteam ON (goal.teamid = eteam.id)
WHERE goal.gtime <= 10

/*
6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
*/

SELECT game.mdate
	,eteam.teamname
FROM game
INNER JOIN eteam ON (game.team1 = eteam.id)
WHERE eteam.coach = 'Fernando Santos'

/*
7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/

SELECT goal.player
FROM goal
INNER JOIN game ON (goal.matchid = game.id)
WHERE game.stadium = 'National Stadium, Warsaw'

/*
8. The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.
*/

SELECT DISTINCT player
FROM game
INNER JOIN goal ON matchid = id
WHERE (
		team1 = 'GER'
		OR team2 = 'GER'
		)
	AND teamid != 'GER'
GROUP BY player

/*
9. Show teamname and the total number of goals scored.
*/

SELECT teamname
	,count(teamid)
FROM eteam
INNER JOIN goal ON id = teamid
GROUP BY teamname
	,teamid
ORDER BY teamname

/*
10. Show the stadium and the number of goals scored in each stadium.
*/

SELECT stadium
	,count(stadium)
FROM game
INNER JOIN goal ON id = matchid
GROUP BY stadium

/*
11. For every match involving 'POL', show the matchid, date and the number of goals scored.
*/

SELECT matchid
	,mdate
	,count(teamid)
FROM game
INNER JOIN goal ON matchid = id
WHERE (
		team1 = 'POL'
		OR team2 = 'POL'
		)
GROUP BY matchid
	,mdate

/*
12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
*/

SELECT matchid
	,mdate
	,count(matchid)
FROM goal
INNER JOIN game ON matchid = id
WHERE teamid = 'GER'
GROUP BY matchid
	,mdate

/*
13.
List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/

SELECT game.mdate
	,game.team1
	,SUM(CASE 
			WHEN goal.teamid = game.team1
				THEN 1
			ELSE 0
			END) score1
	,game.team2
	,SUM(CASE 
			WHEN goal.teamid = game.team2
				THEN 1
			ELSE 0
			END) score2
FROM game
LEFT JOIN goal ON matchid = id
GROUP BY mdate
	,team1
	,team2
