--1.1
SELECT population FROM world
  WHERE name = 'Germany';

--1.2
SELECT name, gdp/population
FROM world
WHERE area > 5000000;

--1.3
SELECT name, continent
FROM world
WHERE area < 2000
  AND gdp > 5000000000;

--1.4
SELECT name, population
FROM world
WHERE name IN ('Denmark', 'Finland', 'Norway', 'Sweden');

--1.5
SELECT name
FROM world
WHERE name LIKE 'G%';

--1.6
SELECT name, area/1000
FROM world
WHERE area/1000 BETWEEN 207.6 AND 244.82

--2.1
SELECT name, continent, population
FROM world;

--2.2
SELECT name
FROM world
WHERE population>200000000;

--2.3
SELECT name, gdp/population
FROM world
WHERE population > 200000000;

--2.4
SELECT name, population/1000000
FROM world
WHERE continent = 'South America';

--2.5
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

--2.6
SELECT name
FROM world
WHERE name LIKE 'United%';

--3.1
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

--3.2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

--3.3
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

--3.4
SELECT winner
FROM nobel
WHERE yr >= 2000
  AND subject = 'Peace';

--3.5
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature'
  AND yr BETWEEN 1980 AND 1989;

--3.6
SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jed Bartlet', 'Jimmy Carter');

--3.7
SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

--3.8
SELECT DISTINCT phys.yr
FROM (SELECT * FROM nobel WHERE subject = 'Physics') AS phys
LEFT OUTER JOIN (SELECT * FROM nobel WHERE subject = 'Chemistry') AS chem
ON phys.yr = chem.yr
WHERE chem.yr IS NULL;

--4.1
SELECT name FROM world
WHERE population >
 (SELECT population FROM world
  WHERE name='Russia')

--4.2
SELECT name, continent
FROM world
WHERE continent IN
  (SELECT continent
  FROM world
  WHERE name IN ('Belize', 'Belgium'));

--4.3
SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp/population >
    (SELECT gdp/population
     FROM world
     WHERE name = 'United Kingdom');

--4.4
SELECT name, population
FROM world
WHERE population >
  (SELECT population
  FROM world
  WHERE name = 'Canada')
  AND population <
  (SELECT population
  FROM world
  WHERE name = 'Poland');

--4.5
SELECT name
FROM world
WHERE gdp > ALL
  (SELECT gdp
   FROM world
   WHERE continent = 'Europe' AND gdp IS NOT NULL);

--4.6
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
    WHERE y.continent=x.continent
    AND population>0)

--4.7
SELECT a.name, a.continent, a.population
FROM world AS a
WHERE 25000000 > ALL
  (SELECT population
   FROM world AS b
   WHERE a.continent = b.continent);

--4.8
SELECT a.name, a.continent
FROM world AS a
WHERE a.population >= ALL
  (SELECT b.population * 3
   FROM world AS b
   WHERE a.continent = b.continent
   AND a.name != b.name
   AND b.population IS NOT NULL);

--5.1
SELECT SUM(population)
FROM world;

--5.2
SELECT DISTINCT continent
FROM world;

--5.3
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

--5.4
SELECT COUNT(area)
FROM world
WHERE area > 1000000;

--5.5
SELECT SUM(population)
FROM world
WHERE name IN ('France', 'Germany', 'Spain');

--5.6
SELECT continent, COUNT(name)
FROM world
GROUP BY continent;

--5.7
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent;

--5.8
SELECT continent
FROM world AS a
GROUP BY continent
HAVING 100000000 <
  (SELECT SUM(population)
  FROM world AS b
  WHERE a.continent = b.continent);

--6.1
SELECT matchid, player
  FROM goal
  WHERE teamid = 'GER';

--6.2
SELECT id, stadium, team1, team2
  FROM game
  WHERE id = 1012;

--6.3
SELECT go.player, go.teamid, ga.mdate
  FROM goal AS go INNER JOIN game AS ga
    ON go.matchid = ga.id
  WHERE go.teamid = 'GER';

--6.4
SELECT ga.team1, ga.team2, go.player
  FROM goal AS go INNER JOIN game as ga
    ON go.matchid = ga.id
  WHERE go.player LIKE 'Mario%';

--6.5
SELECT g.player, g.teamid, e.coach, g.gtime
  FROM goal AS g JOIN eteam AS e
    ON g.teamid = e.id
  WHERE g.gtime <= 10;

--6.6
SELECT g.mdate, e.teamname
  FROM game AS g JOIN eteam AS e
    ON g.team1 = e.id
  WHERE e.coach = 'Fernando Santos';

--6.7
SELECT go.player
  FROM game AS ga JOIN goal AS go
    ON ga.id = go.matchid
 WHERE ga.stadium = 'National Stadium, Warsaw';

 --6.8
SELECT DISTINCT player
FROM game JOIN goal
ON matchid = id
WHERE (team1 ='GER' OR team2 = 'GER')
AND teamid != 'GER';

--6.9
  SELECT teamname, COUNT(player)
    FROM eteam JOIN goal
      ON id = teamid
GROUP BY teamname;

--6.10
SELECT stadium, COUNT(player)
  FROM game JOIN goal
    ON id = matchid
    GROUP BY stadium;

--6.11
SELECT matchid, mdate, COUNT(player)
  FROM game JOIN goal
    ON id = matchid
  WHERE team1 = 'POL' OR team2 = 'POL'
    GROUP BY mdate;

--6.12
SELECT matchid, mdate, COUNT(player)
  FROM game JOIN goal
    ON id = matchid
  WHERE teamid = 'GER'
    GROUP BY matchid;

--6.13 ???
SELECT tb1.mdate, tb1.team1, tb1.score1, tb2.team2, tb2.score2
FROM
  (SELECT mdate, team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  ga.id id
  FROM game AS ga JOIN goal AS go ON go.matchid = ga.id
  GROUP BY ga.id) AS tb1
    JOIN (SELECT mdate, team2,
    SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2,
    ga.id id
    FROM game AS ga JOIN goal AS go ON go.matchid = ga.id
  GROUP BY ga.id) AS tb2
    USING (mdate)
WHERE tb1.id = tb2.id;



  -- SELECT mdate...
  -- team1 score1 mdate
  -- JOIN with team2 score2 mdate
  -- -- USING (mdate)

--7.1
SELECT id, title
 FROM movie
 WHERE yr=1962;

--7.2
SELECT yr
  FROM movie
  WHERE title = 'Citizen Kane';

--7.3
SELECT id, title, yr
  FROM movie
  WHERE title LIKE '%Star Trek%'
    ORDER BY yr;

--7.4
SELECT title
  FROM movie
  WHERE id IN (11768, 11955, 21191);

--7.5
SELECT id
  FROM actor
  WHERE name = 'Glenn Close';

--7.6
SELECT id
  FROM movie
  WHERE title = 'Casablanca';

--7.7
SELECT a.name
  FROM actor AS a JOIN casting AS c
    ON a.id = c.actorid
    JOIN movie AS m
      ON m.id = c.movieid
WHERE m.title = 'Casablanca';

--7.8
SELECT a.name
  FROM actor AS a JOIN casting AS c
    ON a.id = c.actorid
    JOIN movie AS m
      ON m.id = c.movieid
WHERE m.title = 'Alien';

--7.9
SELECT m.title
  FROM actor AS a JOIN casting AS c
    ON a.id = c.actorid
    JOIN movie AS m
      ON m.id = c.movieid
WHERE a.name = 'Harrison Ford';

--7.10
SELECT m.title
  FROM actor AS a JOIN casting AS c
    ON a.id = c.actorid
    JOIN movie AS m
      ON m.id = c.movieid
WHERE a.name = 'Harrison Ford'
  AND c.ord > 1;

--7.11
  SELECT m.title, a.name
    FROM actor AS a JOIN casting AS c
      ON a.id = c.actorid
      JOIN movie AS m
        ON m.id = c.movieid
  WHERE m.yr = 1962
    AND c.ord = 1;

--7.12
SELECT yr, COUNT(title) AS c
  FROM movie JOIN casting
    ON movie.id = movieid
    JOIN actor
      ON actorid = actor.id
  WHERE name = 'John Travolta'
    GROUP BY yr
    HAVING c > 2;

--7.13
SELECT m.title, a.name
FROM movie AS m JOIN casting AS c
ON m.id = c.movieid
JOIN actor AS a
ON c.actorid = a.id
WHERE c.ord = 1
AND m.title IN (SELECT m.title
  FROM actor AS a JOIN casting AS c
  ON a.id = c.actorid
  JOIN movie AS m
  ON m.id = c.movieid
  WHERE a.name = 'Julie Andrews');

--7.14
SELECT b.name
FROM
  (SELECT a.name, COUNT(m.title) AS ct
  FROM actor AS a JOIN casting AS c
    ON a.id = c.actorid
    JOIN movie AS m
      ON m.id = c.movieid
  WHERE c.ord = 1
  GROUP BY a.name) AS b
WHERE b.ct >= 30;

-- OR
SELECT a.name
  FROM actor AS a JOIN casting AS c
    ON a.id = c.actorid
    JOIN movie AS m
      ON m.id = c.movieid
  WHERE c.ord = 1
  GROUP BY a.name
    HAVING COUNT(m.title) >= 30;

--7.15
SELECT m.title, COUNT(a.name)
  FROM actor AS a JOIN casting AS c
    ON a.id = c.actorid
    JOIN movie AS m
      ON m.id = c.movieid
  WHERE m.yr = 1978
  GROUP BY m.title
  ORDER BY COUNT(a.name);

--7.16
SELECT DISTINCT a.name
FROM movie AS m JOIN casting AS c
ON m.id = c.movieid
JOIN actor AS a
ON c.actorid = a.id
WHERE a.name != 'Art Garfunkel' AND m.title IN (SELECT m.title
  FROM actor AS a JOIN casting AS c
  ON a.id = c.actorid
  JOIN movie AS m
  ON m.id = c.movieid
  WHERE a.name = 'Art Garfunkel');

--8.1
SELECT name
  FROM teacher
  WHERE dept IS NULL;

--8.2
SELECT teacher.name, dept.name
 FROM teacher OUTER JOIN dept
           ON (teacher.dept=dept.id)

--8.3
SELECT teacher.name, dept.name
 FROM teacher LEFT OUTER JOIN dept
   ON (teacher.dept=dept.id);

--8.4
SELECT teacher.name, dept.name
 FROM teacher RIGHT OUTER JOIN dept
   ON (teacher.dept=dept.id);

--8.5
SELECT name, COALESCE(mobile, '07966 444 2266')
FROM teacher;

--8.6
SELECT teacher.name, COALESCE(dept.name,'None')
FROM teacher LEFT OUTER JOIN dept
ON teacher.dept = dept.id;

--8.7
SELECT COUNT(teacher.name), COUNT(teacher.mobile)
FROM teacher;

--8.8
SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT OUTER JOIN dept
ON teacher.dept = dept.id
GROUP BY dept.name;

--8.9
SELECT name,
  CASE dept
  WHEN 1 THEN 'Sci'
  WHEN 2 THEN 'Sci'
  ELSE 'Art'
  END?
FROM teacher;

--8.10
SELECT name,
  CASE dept
  WHEN 1 THEN 'Sci'
  WHEN 2 THEN 'Sci'
  WHEN 3 THEN 'Art'
  ELSE 'None'
  END
FROM teacher;

--9.1
SELECT COUNT(id)
  FROM stops;

--9.2
SELECT id
  FROM stops
  WHERE name = 'Craiglockhart';

--9.3
SELECT stop, name
FROM route JOIN stops
ON stop = id
WHERE num = '4' AND company = 'LRT';

--9.4
SELECT company, num, COUNT(*)
  FROM route
  WHERE stop=149 OR stop=53
    GROUP BY company, num
      HAVING COUNT(*) = 2;

--9.5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 53
  AND b.stop = (SELECT id FROM stops WHERE name = 'London Road');

--9.6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'London Road';

--9.7
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Haymarket' AND stopb.name = 'Leith';

--9.8
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross';

--9.9
SELECT DISTINCT stopb.name, b.company, b.num
FROM route a JOIN route b ON
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart';

--9.10 ????
SELECT DISTINCT stopa.name, stopd.name
FROM route c JOIN route d
ON (c.company = d.company AND c.num = d.num)
JOIN stops stopc
ON (c.stop = stopc.id)
JOIN stops stopd
ON (d.stop = stopd.id)
JOIN
WHERE stopc.name IN
  (SELECT DISTINCT stopb.name
  FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa
  ON (a.stop = stopa.id)
  JOIN stops stopb
  ON (b.stop = stopb.id)
  WHERE stopa.name = 'Craiglockhart') AS sub
AND stopd.name = 'Sighthill';

--9.10.2

(SELECT DISTINCT stopb.id
  FROM route a JOIN route b
  ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa
  ON (a.stop = stopa.id)
  JOIN stops stopb
  ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart') AS sub

