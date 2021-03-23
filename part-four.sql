-- Bigger than Russia
SELECT name FROM world
  WHERE population >
(SELECT population FROM world
WHERE name='Russia');


-- Richer than UK
SELECT name FROM world
WHERE continent = 'Europe' AND
gdp/population > (SELECT gdp/population FROM world
WHERE name = 'United Kingdom');


-- Neighbours of Argentina and Australia
SELECT name, continent FROM world
WHERE continent IN ((SELECT continent FROM world
WHERE name = 'Argentina' OR name = 'Australia'))
ORDER BY name;


-- Between Canada and Poland
SELECT name, population FROM world
WHERE population > (SELECT population FROM world
WHERE name = 'Canada')
AND population <
(SELECT population FROM world
WHERE name = 'Poland');


-- Percentages of Germany
SELECT name, CONCAT(ROUND(population /
(SELECT population FROM world WHERE name = 'Germany') * 100 ),'%')
FROM world
WHERE continent = 'Europe';


-- Bigger than every country in Europe
SELECT name FROM world 
WHERE gdp >
(SELECT MAX(gdp) FROM world WHERE continent = 'Europe');


-- Largest in each continent
SELECT continent, name, area FROM world
WHERE AREA IN ((SELECT MAX(area) FROM world
GROUP BY continent));


-- First country of each continent (alphabetically)
SELECT continent, name FROM world
WHERE name IN 
((SELECT MIN(name) FROM world
GROUP BY continent));


-- Difficult Questions That Utilize Techniques Not Covered In Prior Sections PART 1
SELECT name, continent, population FROM world
WHERE continent IN ((SELECT continent FROM world
GROUP BY continent HAVING MAX(population) <= 25000000));


-- Difficult Questions That Utilize Techniques Not Covered In Prior Sections PART 2
SELECT name, continent FROM world one
WHERE population >= ALL(SELECT population*3
FROM world two
WHERE one.continent = two.continent AND two.name != one.name);
