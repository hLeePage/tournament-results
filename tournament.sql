-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.



CREATE DATABASE tournament;

CREATE TABLE players (
id SERIAL PRIMARY KEY,
name VARCHAR (30) NOT NULL
);

CREATE TABLE matches
(
p1 INT REFERENCES players (id),
P2 INT REFERENCES players (id),
winner INT REFERENCES players (id)
);

CREATE VIEW matches_played AS
	SELECT players.id, players.name,  
		(SELECT COUNT(*) AS played 
		 FROM matches 
		 WHERE players.id in (p1, p2)) 
	FROM players;

	
CREATE VIEW wins AS
	SELECT players.id, players.name, 
		(SELECT COUNT(*) AS wins 
		 FROM matches 
		 WHERE matches.winner = players.id) 
	FROM players 
	ORDER BY wins DESC;
	
	
CREATE VIEW standings AS
	SELECT players.id, players.name,
       (SELECT COUNT(*)
        FROM matches
        WHERE matches.winner = players.id) AS matches_won,
       (SELECT COUNT(*)
        FROM matches
        WHERE players.id in (p1, p2)) AS matches_played
	FROM players
	ORDER BY matches_won DESC;
