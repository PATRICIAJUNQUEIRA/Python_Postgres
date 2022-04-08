CREATE TABLE IF NOT EXISTS public.teams
(
id integer NOT NULL,
team_city character varying(80),
team_state character varying(80),
PRIMARY KEY (id)
);



CREATE TABLE IF NOT EXISTS public.players
(    
id integer NOT NULL,
active boolean,
name character varying(80),
country character varying(80),
height integer,
weight integer,
position character varying(80),
team_id integer NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (team_id) REFERENCES teams (id)
);



CREATE TABLE IF NOT EXISTS public.salary
(
season character varying(80),
salary_amount integer,
id_player integer NOT NULL,
FOREIGN KEY (id_player) REFERENCES players (id)
)



INSERT INTO teams(id, team_city, team_state)
SELECT DISTINCT team_id, team_city, team_state
FROM raw;
			
INSERT INTO players(id, active, name, country, height, weight, position, team_id)
SELECT DISTINCT id, active, name, country, height, weight, position, team_id
FROM raw;
			
INSERT INTO salary(season, salary_amount, id_player)
SELECT player_salary_season, player_salary_amount, id
FROM raw
WHERE player_salary_season IS NOT NULL
AND player_salary_amount IS NOT NULL;
			
			
		
select * from teams
select * from salary
select * from players
select * from raw

--salary, teams

--Qual posição mais paga por estado?


SELECT DISTINCT ON (t.team_state) t.team_state ,p.position, MAX(s.salary_amount)
FROM players p
INNER JOIN salary s
ON p.id = s.id_player
INNER JOIN teams t
ON t.id = p.team_id
GROUP BY t.team_state, p.position
ORDER BY t.team_state ,p.position DESC 

SELECT t.team_state ,p.position, s.salary_amount
FROM players p
INNER JOIN salary s
ON p.id = s.id_player
INNER JOIN teams t
ON t.id = p.team_id
where t.team_state  = 'Arizona'
ORDER BY salary_amount DESC
LIMIT 1;
--4421146


--SALARY
-- PLAYER

--Média, mínimo e máximo salário por altura?
SELECT height, salary_amount
FROM players
INNER JOIN salary
ON salary.id_player = players.id


SELECT P.height, S.salary_amount,
AVG(salary_amount) AS "Média",
MIN(salary_amount) AS "MÍNIMO",
MAX(salary_amount) AS "MÁXIMO"
FROM players P
INNER JOIN salary S
ON s.id_player = p.id
GROUP BY 1, 2
LIMIT 3;