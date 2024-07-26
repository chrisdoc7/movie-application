SELECT p.id_person, p.firstname, p.lastname, SUM(m.budget) + 
	(
		SELECT SUM(m.budget)
		FROM person p
		INNER JOIN movie_actor ma ON p.id_person = ma.id_person
		INNER JOIN movie m ON ma.id_movie = m.id_movie
	) AS total_budget
FROM person p
INNER JOIN personage pg ON p.id_person = pg.id_person
INNER JOIN movie_personage mp ON pg.id_personage = mp.id_personage
INNER JOIN movie m ON mp.id_movie = m.id_movie;