-- How many stops are in the database.
SELECT COUNT(*) FROM stops;


-- Find the id value for the stop 'Craiglockhart'
SELECT id FROM stops
WHERE name = 'Craiglockhart';


-- Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name FROM stops
JOIN route ON id = stop
WHERE num = '4' AND company = 'LRT';


-- Routes and stops
SELECT company, num, COUNT(*) AS amount
FROM route WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING amount = 2;


-- Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop=53
AND b.stop=149;


-- Change the query so that the services between 'Craiglockhart' and 'London Road' are shown
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart'
AND stopb.name= 'London Road';


-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name='Haymarket'
AND stopb.name='Leith';


-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT stopz.name, x.company, x.num
FROM route x JOIN route z ON (x.company = z.company AND x.num = z.num)
JOIN stops stopx ON x.stop = stopx.id
JOIN stops stopz ON y.stop = stopz.id
WHERE stopx.name = 'Craiglockhart';


-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.SELECT DISTINCT x.company, x.num
FROM route x
JOIN route y ON (x.num=y.num AND x.company=y.company)
JOIN stops stopx ON (x.stop=stopx.id)
JOIN stops stopy ON (y.stop=stopy.id)
WHERE stopx.name = 'Craiglockhart'
AND stopy.name = 'Tollcross';



-- Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
SELECT DISTINCT a.num, a.company, stopb.name ,  c.num,  c.company
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
JOIN (route c JOIN route d
ON (c.company = d.company AND c.num= d.num))
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
JOIN stops stopc ON (c.stop = stopc.id)
JOIN stops stopd ON (d.stop = stopd.id)
WHERE  stopa.name = 'Craiglockhart' AND stopd.name = 'Sighthill'
AND  stopb.name = stopc.name
ORDER BY a.num, b.num, c.num, d.num; 