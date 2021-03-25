-- 1962 movies
SELECT id, title FROM movie
WHERE yr=1962;


-- When was Citizen Kane released?
SELECT yr FROM movie
WHERE title = 'Citizen Kane';


-- Star Trek movies
SELECT id, title, yr FROM movie
WHERE title LIKE '%Star%' AND title LIKE '%Trek%'
ORDER BY yr;


-- id for actor Glenn Close
SELECT id FROM actor
WHERE name = 'Glenn Close';


-- id for Casablanca
SELECT id FROM movie
WHERE title = 'Casablanca';


-- Cast list for Casablanca
SELECT name FROM actor
JOIN casting ON casting.actorid = actor.id
WHERE casting.movieid = 11768;


-- Alien cast list
SELECT actor.name FROM movie JOIN casting ON
movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE title = 'Alien';


-- Harrison Ford movies
SELECT title FROM movie JOIN casting ON
movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE actor.name = 'Harrison Ford';


-- Harrison Ford as a supporting actor
SELECT title FROM movie JOIN casting ON
movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE actor.name = 'Harrison Ford'
AND
casting.ord != 1;


-- Lead actors in 1962 movies
SELECT title, name FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE yr = 1962 AND ord = 1;


-- Busy years for Rock Hudson
SELECT yr, COUNT(title) FROM movie 
JOIN casting ON movie.id = movieid
JOIN actor ON actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;


-- Lead actor in Julie Andrews movies
SELECT title, name FROM movie
JOIN casting ON (id = movieid AND ord = 1)
JOIN actor ON actorid = actor.id
WHERE movieid IN (SELECT movieid FROM casting WHERE
actorid IN (SELECT id FROM actor WHERE
name = 'Julie Andrews'));


-- Actors with 15 leading roles
SELECT DISTINCT actor.name FROM actor
JOIN casting ON actorid = actor.id
WHERE actorid IN (SELECT actorid FROM actor
JOIN casting ON actorid = actor.id
WHERE ord = 1
GROUP BY actorid
HAVING COUNT(*) > 14)
ORDER BY actor.name;


-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(movieid) FROM movie JOIN
casting ON movie.id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(movieid) DESC, title;


-- List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT name FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON actor.id = actorid
WHERE movie.id IN 
(SELECT movieid FROM casting 
JOIN actor ON id = actorid 
WHERE name = 'Art Garfunkel')
AND name != 'Art Garfunkel';
