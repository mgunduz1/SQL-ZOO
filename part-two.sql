-- Large Countries

SELECT name
  FROM world
 WHERE population > 200000000;


-- Per capita GDP

SELECT name, gdp/population AS per_capita_gdp
FROM world WHERE population > 200000000;


-- South America In millions

SELECT name, population/1000000 AS population_mil FROM world
WHERE continent = 'South America';


-- France, Germany, Italy

SELECT name, population FROM world
WHERE name IN ('France','Germany','Italy');


-- United

SELECT name FROM world
WHERE name LIKE '%United%';


-- Two ways to be big

SELECT name, population, area FROM world
WHERE population > 250000000 OR area > 3000000;


-- One or the other (but not both)

SELECT name, population, area FROM world
WHERE population > 250000000 XOR area > 3000000;


-- Rounding

SELECT name, ROUND(population/1000000, 2) AS population_in_mil, 
ROUND(gdp/1000000000, 2) AS gdp_in_bil
FROM world WHERE continent = 'South America';


-- Trillion dollar economies

SELECT name, ROUND(gdp/population, -3)
FROM world WHERE gdp > 1000000000000;


-- Name and capital have the same length

SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital);


-- Matching name and capital

SELECT name, capital FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND name != capital;


-- All the vowels

SELECT name FROM world
WHERE name LIKE '%a%' 
AND name LIKE '%e%' 
AND name LIKE '%i%' 
AND name LIKE  '%o%' 
AND name LIKE '%u%'
AND name NOT LIKE '% %';