----- S2a -----

SELECT tm.department, AVG(t.resolution_hours) AS avg_resolution_hours
FROM tickets t JOIN teams tm ON t.team_id = tm.team_id
GROUP BY tm.department ORDER BY avg_resolution_hours DESC;


----- S2b -----

SELECT  tm.team, AVG(t.resolution_hours) AS avg_resolution_hours
FROM tickets t JOIN teams tm ON t.team_id = tm.team_id
GROUP BY tm.team HAVING AVG(t.resolution_hours) > 24;


----- S2c -----

SELECT channel, COUNT(*) AS breach_count
FROM tickets WHERE resolution_hours > 24
GROUP BY channel ORDER BY breach_count DESC, channel ASC
LIMIT 2;
